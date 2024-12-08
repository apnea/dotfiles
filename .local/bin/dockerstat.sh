#!/bin/bash
sudo docker stats --format "table {{.Container}}\t{{.Name}}\t{{.MemUsage}}\t{{.CPUPerc}}"

