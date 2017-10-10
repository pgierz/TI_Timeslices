#!/bin/bash -e
#
# This script prepares the runscripts for the timeslices in TI
# 
# 10 October, 2017 09:41:06 AM
# Paul Gierz, AWI Bremerhaven

for i in $(seq 1 $(cat co2_list.txt | wc -l));
do
    current_file=TI_`printf %02d $i`ka_GO.run
    cp template_runscript.run $current_file
    current_co2_value=$(cat co2_list.txt | tail -$i | head -1 | tr -d '[:space:]')
    current_ch4_value=$(cat ch4_list.txt | tail -$i | head -1 | tr -d '[:space:]')
    current_n2o_value=$(cat n2o_list.txt | tail -$i | head -1 | tr -d '[:space:]')
    current_perihelion=$(cat length_of_perihelion.txt | tail -$i | head -1 | tr -d '[:space:]')
    current_obliquity=$(cat obliquity.txt | tail -$i | head -1 | tr -d '[:space:]')
    current_eccentricity=$(cat eccentricity.txt | tail -$i | head -1 | tr -d '[:space:]')

    sed -i "s/190.e-6/$current_co2_value/" $current_file
    sed -i "s/375.e-9/$current_ch4_value/" $current_file
    sed -i "s/193.e-9/$current_n2o_value/" $current_file
    
    sed -i "s/294.23/$current_perihelion/" $current_file
    sed -i "s/22.94/$current_obliquity/" $current_file
    sed -i "s/1.90e-02/$current_eccentricity/" $current_file

    sed -i 's/1890-12-31/2200-12-31/' $current_file
done
