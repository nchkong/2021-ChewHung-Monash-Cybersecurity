## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![XRed_team_Infra.png](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Diagram/XRed_team_Infra.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. 

[Ansible file: Install ELK](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/install_elk.yml)

[Ansible file: Install Filebeat](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/filebeat-playbook.yml)

[Ansible file: Install metribeat](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/metricbeat-playbook.yml)


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application. 

Load balancing ensures that the application will be highly available, in addition to restricting connections to the network. Load balancer receives traffic comes into the website and distributes it across multiple servers to mitigates Dos attacks, therefore it is much more resilient than if a single server was running the website. Load balancer is built on the zero trust network security model.  In this design, NSGs are used to explicitly permit allowed traffic HTTP and port 80. Without NSG setting on a subnet or NIC of the virtual machine resource, traffic isn't allowed to reach this resource.

Another important component in this design is Jump box. It is a special purpose machine typically used to access machines within the internal network or trusted networks. Jump box is exposed to the public internet and sitting in front of other machines within the internal network. Provisioner tool sits in Jumpbox to facilitate the deployment of virtual machines and containers automatically without much human effort. This will minimize human errors and make the deployment easier especially if dealing with thousands of machines.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs. In this project, we installed two types of beats. There
are Filebeat and Metribeat. Filebeat is a lightweight shipper for forwarding and centralizing log data. it watches for the log files, collects, and forwards them either to Elasticsearch or Logstash for indexing. Metricbeat is an Elastic Beat. It is a lightweight shipper which can be installed in the servers to periodically collects metrics from the operating system and from services running on the server. Metricbeat records the metrics and statistic and ship to a specified output destination such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.1.0.4   | Linux            |
| Web-1    | Web Server | 10.1.0.6   | Linux            |
| Web-2    | Web Server | 10.1.0.7   | Linux            |
| ELK      | ELK Server | 10.2.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the IP address: 125.253.30.165 through SSH. Machines within the network can only be accessed by each other. The Web-1 and Web-2 send data and logs to ELK server.

A summary of the access policies in place can be found in the table below.

| Name                     | Publicly Accessible | Allowed IP Addresses          |
|--------------------------|---------------------|------------------------------ |
| Jump-Box-Provisioner     | Yes                 | 125.253.30.165                |
| Web-1                    | No                  | 20.37.249.187 (XRedTeam_LB)   |        
| Web-2                    | No                  | 20.37.249.187 (XRedTeam_LB)   |
| ELK                      | Yes                 | 125.253.30.165 port:5601      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it reduces human errors and increases the efficiency due to automation and standarization.

The playbook implements the following tasks:

Step 1: Installation of Docker

Step 2: Download the ELK Image from Github source

Step 3: Apt install ELK Image

Step 4: Enable Instance

Step 5: Setup Instance

Step 6: Start up Instance


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker output screen](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/Docker_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor Web-1 and Web-2 servers. Filebeats and Metricbeat have been installed on these machines to collect information from each machine. Filebeat collects log files in the server it installed, E.g system log collects and parses logs created by the system logging service of common Unix/Linux based distributions. On the other hand, Metricbeat periodically collects metrics from the operating system and from services running on the server. E.g Docker Metricbeat collects the information about the docker containers.


###Using the Playbook
Ansible control node has to be installed in the Jump box prior to the filebeat. 

SSH into the control node and follow the steps below:

Step 1: Copy playbook and update the playbook
Copy the playbook (.yml) to /etc/ansible  

Step 2: Update /etc/ansible/hosts to include machine names. 
Machines are specified under a group such as [webservers] or [elk]. 

![Ansible_hosts_file.png](https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/Ansible_hosts_file.png)

Step 3: Update ansible.cfg to include your userid 
remote_user = "yourid"

Step 4: Play the playbook using ansible-playbook command
ansible-playbook install_elk.yml

Step 5: Checking on the site to confirm the installation.
http://20.78.140.1:5601/app/kibana

As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.






