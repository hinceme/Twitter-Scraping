#!/bin/bash

machines=(<<machines here>>)

for i in "${!machines[@]}"; do
    sftp -i <<.pem file here>> -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${machines[i]} << EOF
    put -r "snscrape" snscrape
    put "cities_$i.csv" "cities.csv"
    put "scrape.py" "scrape.py"
EOF
    ssh -i "output_2017_2020.pem" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ${machines[i]} -- << EOF
    sudo amazon-linux-extras install python3.8 > /dev/null && echo "python installed"
    sudo yum install git -y > /dev/null && echo "git installed" &&
    sudo python3.8 -m pip install --upgrade pip > /dev/null && "echo pip installed and upgraded" &&
    pip3 install pandas > /dev/null && echo "pandas installed" &&
    pip3 install git+https://github.com/JustAnotherArchivist/snscrape.git > /dev/null && echo "snscrape installed"
    echo "starting task... good luck!"
    nohup python3.8 scrape.py cities.csv output_${machines[i]}.csv &>/dev/null &
EOF
done
