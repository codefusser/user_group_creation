#Prompt user to enter user name
echo -n "Enter the username for the new user:"                                  
read username                                                                   
                                                                                
getent passwd $username >> /dev/null                                            

#This while block will test whether the username exists and then control will jump out of the loop based on the $?... test condition
#if the username doesn't exist it will jump out otherwise it will request for another username                                                                         
while [ $? -eq 0 ]                                                              
  do                                                                            
    echo -n "User already created\n"                                            
    echo -n "Please enter another username: "                                   
    read username                                                               
    getent passwd $username >> /dev/null                                        
  done                                                                          

#Prompt user to enter group name                                                                                
echo -n "Enter a group name: \n"                                                
read groupname                                                                  
                                                                                
getent group $groupname >> /dev/null                                            



#This while block will test whether the groupname exists and then control will jump out of the loop based on the $?... test condition
#if the groupname doesn't exist it will jump out otherwise it will request for another groupname                                                                                                                                                         
while [ $? -eq 0 ]                                                              
  do                                                                            
   echo -e "Group already exists\n"                                             
   echo -e "Please enter another group name: \n"                                
   read groupname                                 
   getent group $groupname >> /dev/null                                         
  done                                                                 
                                                                                
groupadd $groupname                                                             
useradd -m -s /bin/bash -g $groupname $username 
passwd $username                              
                                                                                
echo -n "User created\n"                                                       


#set permission to each user named directory that will be created to disallow users from deleting files from shared directory                                                                                
mkdir /$username                                                                
chown $username.$groupname /$username                                           
chmod 1770 /$username
