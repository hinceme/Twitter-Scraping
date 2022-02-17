#!/bin/bash

machines=(<<machines here>>)

for i in "${!machines[@]}"; do
    scp -i -y <<.pem file here>> "${machines[i]}:output_${machines[i]}.csv" ~/Twitter-Scraping/output_2017_2020
done