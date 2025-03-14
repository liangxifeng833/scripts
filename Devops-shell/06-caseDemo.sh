#!/bin/bash
##############################################################
# File Name:06-caseDemo.sh
# Author:liangxifeng
# Desc: 
# Date:2025.03.11
##############################################################

read -p "input yes or no:" input
case  "$input" in
    yes|y|Y|Yes) echo "ok";;
    no|n|N|No) echo "no";;
    *) echo "输入错误";;
esac
