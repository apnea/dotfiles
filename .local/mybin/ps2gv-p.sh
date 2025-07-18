#!/bin/sh
#
# ps2gv-p.sh	ptree info to graphvis, with present column.
#
# USAGE: ps2gv-p.sh ptree1.txt [...]
#
# Converts provided ptree input files to .gv files.  The input file has the
# following format (space or tab delimitered):
#
#	zonename ppid pid rss pcpu comm [present=1]
#
# Which can be generated using "ps -eo zone,ppid,pid,rss,pcpu,comm".
# If your OS does not have the zone field, then add a dummy field using awk,
# or edit this script to drop it. The final optional column, present, can be
# post-generated using perl, and is used for animated sequences.
#
# See: http://www.brendangregg.com/ColonyGraphs/cloud.html

hidezone=1	# convert zonenames to "zone-000n"
cpulimit=10	# scale node size from 0 to cpulimit percent

# For an OS where a single busy process shows pcpu as 100%, such as Linux,
# cpulimit can be set to 100. You may want to use smaller values, eg, 10, to
# emphasize smaller CPU consumers. For OSes where pcpu is the average across
# all CPUs, eg, Solaris, you will want to make cpulimit much smaller (divide
# by number of CPUs).

for infile in $*; do
outfile=${infile%.txt}.gv
echo processing $infile '->' $outfile
echo $outfile
(
echo 'digraph ptree {'
echo 'node [ style = filled ];'

cat $infile | awk '
	BEGIN {
		curzone = ""; 
		'"`cat colors.awk`"'
		hidezone = '$hidezone'
		cpulimit = '$cpulimit'
	}
	$1 != curzone { curzone = $1 }
	$3 > 10  && $3 != "PID" {
		ppid = $2
		pid = $3
		realppid = ppid
		gsub(/.*-/, "", realppid)
		cpu = $5
		if (cpu == "-") { cpu = "0" }
		comm = $6
		present = $7;
		if (realppid == 1) {
			realzone = curzone
			gsub(/.*-/, "", realzone)
			ppid = ppid "-" realzone
			if (hidezone && !hidezonemask[curzone]) {
				hidezonemask[curzone] = 1
				zoneid++
				printf "	\"%s\" [ label = \"zone-%05d\" ];\n", ppid, zoneid
			}
		}
		gsub(/^\/.*\//, "", comm)

		colortxt = ""
		if (comm2color[comm] != "") {
			colortxt = "color = \"" comm2color[comm] "\" "
		}

		# animation, if column provided:
		if (present != "" && present == "0") {
			colortxt = colortxt " style = \"invis\""
		}

		# node size, based an pcpu:
		if (cpu < 0.1) {
			sizetxt = ""
		} else {
			if (cpu > cpulimit) { cpu = cpulimit; }
			ratio = cpu / cpulimit;
			width = sprintf("%.2f", 1 + 1.8 * ratio);
			height = sprintf("%.2f", 0.7 + 2.3 * ratio);
			sizetxt = " width = \"" width " \" height = \"" height "\" "
		}

		print "	\"" ppid "\" -> \"" pid "\" [ " colortxt " ];"
		print "	\"" pid "\" [ label = \"" comm "\" " colortxt sizetxt " ];"
	}
'
echo '}'
) > $outfile
done
