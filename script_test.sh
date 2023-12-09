function quit(){
	
	kill
		
}

function value(){

	echo  -e "Enter the value  or quit(q): \c  "
}

function first_page(){
echo "*******************************************************************************************"
echo "[1] Edit a connection"
echo "[2] Activate a connection"
echo "[3] set hostname"
echo "[4] list connections"
echo " "
value
read value1
}

function edit_a_connection(){

echo "*******************************************************************************************"
	echo "[1] Add"
	echo "[2] Edit"
	echo "[3] Delete"
        echo "[4] list connections"
	echo " "
	value
	read value2
}
function add_connection(){
	
echo "*******************************************************************************************"
		echo "select connection type : "
		echo "[1] Ethernet"
		echo "[2] wifi"
	        echo " "
		value
		read value3
	}

function ethernet(){
	
	function configuration(){
		echo " Select configuration : "
		echo "[1] Automatic"
	        echo "[2] Manual"
             	echo " "
                value
                read value4
	     					}

	function manual_method(){
		read -p "Enter IP Address : " ipadd
		read -p "Gateway : " gate
		read -p "DNS :  " dns
	}

	function command1(){
		nmcli c add con-name $con_name type Ethernet ifname $dev_name
	}
	function command2(){
		nmcli c mod $con_name ipv4.addresses $ipadd
		nmcli c mod $con_name ipv4.gateway $gate
		nmcli c mod $con_name ipv4.dns $dns
		nmcli c mod $con_name ipv4.method manual
					   }

		     echo -e "Connection name : \c"
		     read con_name
		     echo -e "device name : \c" 
		     read dev_name
		     configuration
		     if [ $value4 == 1 ]
		     then
			     command1
			 fi
		     if [ $value4 == 2 ]
		     then
			     manual_method
			     command1
			     command2
		     else
			     configuration
		      fi

	      }
	      
	      
function activate_a_connection(){
	echo "[A] Activate "
	echo "[D] Deactivate "
	echo " "
	list_connections
	read -p "Activate(A)/Deactivate(D) : " AD 
	read -p "Enter connection name : " conn_up
	if [ $AD == 'A' ]
	then
		nmcli c up $conn_up
	elif [ $AD == 'D' ]
	then
		nmcli c down $conn_up
	fi

		}
#function set_hostname(){}
function list_connections(){
	read -p "List connections (y/n) : " yn
	if [ $yn == 'y' ]
	then	nmcli c
	fi
}
#function list_devices(){}
#function disconnect_device(){}

first_page
if [ $value1 == 1 ]
then
	edit_a_connection
	if [ $value2 == 1 ]
	then
		add_connection
	        if [ $value3 == 1 ]
	        then
		    ethernet
	        elif [ $value1 == 'q' ]
		then
			quit
		fi
	
	elif [ $value1 == 'q' ]
	then
		quit
                    
	fi
elif [ $value1 == 2 ]
then
	activate_a_connection
elif [ $value1 == 4 ]
then
	list_connections
elif [ $value1 == 'q' ]
then
	quit
fi



