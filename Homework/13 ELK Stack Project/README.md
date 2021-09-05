## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Diagram/XRedTeam_Infrastructure.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. 

https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/filebeat-playbook.yml
https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/metricbeat-playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting connections to the network.

Load balancer receives traffic comes into the website and distributes it across multiple servers to mitigates Dos attacks and it is much more resilient than if a single server 
was running the website. In the event, one of the machine is compromised, another machine can still continue to operate. In another aspect, load balancer restricts a direct access
to the virtual machines and is built on the zero trust network security model.  In this design, NSGs are used to explicitly permit allowed traffic HTTP and port 80. Without NSG 
setting on a subnet or NIC of the virtual machine resource, traffic isn't allowed to reach this resource.

Jump box is a special purpose machine typically used to access machines within the internal network or trusted networks. It is exposed to the public internet and sitting in front 
of other machines within the internal network. Provisioner tool sit in Jumpbox to facilitate the deployment of virtual machines and containers automatically without much human 
effort. This will drastically reduce the potential for human errors and make the deployment easier especially if dealing with thousands of machines.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs. In this project, we installed two types of beat. There
are Filebeat and Metribeat.

Filebeat is a lightweight shipper for forwarding and centralizing log data. it watch for the log files, collect, and forwards them either to Elasticsearch or Logstash for 
indexing.

Metricbeat is an Elastic Beat. It is a lightweight shipper which can be installed in the servers to periodically collects metrics from the operating system and from services
running on the server. Metricbeat records the metrics and statistic and ship to a specified output destination such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.1.0.4   | Linux            |
| Web-1    | Web Server | 10.1.0.6   | Linux            |
| Web-2    | Web Server | 10.1.0.7   | Linux            |
| ELK      | ELK Server | 10.2.0.4   | Linux            |

Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
Whitelist: 125.253.30.165
Machines within the network can only be accessed by each other. The Web-1 and Web-2 send data and logs to ELK server.

Which machine did you allow to access your ELK VM?
Jump Box is allowed to access to ELK VM. 

What was its IP address?
10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name                     | Publicly Accessible | Allowed IP Addresses          |
|--------------------------|---------------------|------------------------------ |
| Jum Jump-Box-Provisioner | Yes                 | 125.253.30.165                |
| Web-1                    | No                  | 10.1.0.1-254 and 10.2.0.1-254 |        
| Web-2                    | No                  | 10.1.0.1-254 and 10.2.0.1-254 |
| ELK                      | No                  | 10.2.0.1-254 and 10.2.0.1-254 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because
it will drastically reduce the potential for human errors and make it easy to configure potentially thousands of identical machines all at once.

The playbook implements the following tasks:
Step 1: Installation of Docker
Step 2: Download the ELK Image from Github source
Step 3: Apt install ELK Image
Step 4: Enable Instance
Step 5: Setup Instance
Step 6: Start up Instance


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/nchkong/2021-ChewHung-Monash-Cybersecurity/blob/Master/Homework/13%20ELK%20Stack%20Project/Ansible/docker_ps_output.png

Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web-1 and Web-2

We have installed the following Beats on these machines:
Filebeats and Metricbeat

These Beats allow us to collect the following information from each machine:
Filebeat collects log files in the server it installed, Example of the filebeat is system log which collects and parses logs created by the system logging service of common
Unix/Linux based distributions.

Metricbeat periodically collects metrics from the operating system and from services running on the server. Example of the Metribeat is Docker Metricbeat which collects the 
information about the docker containers.


Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
Which file is the playbook? Where do you copy it? 
filebeat-playbook.yml is the playbook. Copy this file from /etc/ansible to /etc/ansible/roles/ 
filebeat-config.yml also requires to be downloded from gist.githubusercontent.com. copy from /etc/ansible/filebeat-config.yml to /etc/filebeat-config.yml

Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install 
Filebeat on?
/etc/ansible/hosts requires an update to include the machine information for ansible to run the playbook. Machines are specified under a group such as 
[webservers] or [elk].  The below is an extraction from the /etc/ansible/hosts.

----------------------------------------------------------------------------
[webservers]
10.1.0.6 ansible_python_interpreter=/usr/bin/python3
10.1.0.7 ansible_python_interpreter=/usr/bin/python3

[elk]
10.2.0.4 ansible_python_interpreter=/usr/bin/python3
----------------------------------------------------------------------------

Which URL do you navigate to in order to check that the ELK server is running?
http://20.78.140.1:5601/app/kibana

As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.
Download filebeat-config.yml
curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat >> /etc/ansible/filebeat-config.yml

Update /etc/ansible/filebeat-playbook.yml
vi /etc/ansible/filebeat-playbook.yml





