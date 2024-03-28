#!/bin/bash
i=1;while [ $i -le 10000 ]; do echo $(factor $i); ((i++));done

