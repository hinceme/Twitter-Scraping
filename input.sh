#!/bin/bash

# usage ./input [machine_list_filename] [pem_key_filename]

readarray machines < $1

for i in "${!machines[@]}"; do
    sftp -i $2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${machines[i]} << EOF
    put -r "snscrape" snscrape
    put "cities_$i.csv" "cities.csv"
    put "scrape.py" "scrape.py"
EOF >
    ssh -i $2 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${machines[i]} -- < ssh_commands.sh
done
