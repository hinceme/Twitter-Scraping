rm -f *.log
echo "installing python..." 
( sudo amazon-linux-extras install python3.8 &> python_install.log &&
echo "python installed" ) || ( echo "python install failed" && exit 1 )
echo "installing git..." 
( sudo yum install git -y &> git_install.log && 
echo "git installed") || ( echo "git install failed" && exit 1)
( sudo python3.8 -m pip install --upgrade pip &> pip_install.log &&
echo "pip installed" ) || ( echo "pip install failed" && exit 1 )
( pip3 install pandas &> pandas_install.log && echo "pandas installed" &&
echo "pandas installed" ) || ( echo "pandas install failed" && exit 1 )
( pip3 install git+https://github.com/JustAnotherArchivist/snscrape.git &> snscrape_install.log &&
echo "snscrape installed" ) || ( echo "snscrape install failed" && exit 1 )
echo "starting task... good luck!"
python3.8 scrape.py cities.csv output_${machines[i]}.csv &> script.log &
echo "task started with pid $!"
 