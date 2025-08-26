# AWS EC2 Instances Lab

This lab guides you through the process of launching two Amazon EC2 instances in different Availability Zones, configuring user data to display instance details in a browser, and ensuring both instances are correctly configured.

## Steps to Finish

1. Launch an Amazon EC2 Instance.
2. Configure a user data script to display the instance details in a browser.
3. Launch a second Amazon EC2 Instance in a different Availability Zone of the same AWS Region.

---

## Instructions

### 1. Navigate to EC2 in the AWS Management Console

- In the **EC2 Dashboard**, click on **"Launch Instance"**.

### 2. Launching the First EC2 Instance

On the **Launch Instance** page, set up the following:

#### 1. Name and Tags Section:
- **Name:** `webserver01`

#### 2. Application and OS Images (Amazon Machine Image, AMI):
- **Choose:** `Amazon Linux 2 AMI (HVM), SSD Volume Type`

#### 3. Instance Type:
- **Choose:** `t2.micro` (eligible for the free tier)

#### 4. Key Pair:
- **Choose:** `Proceed without a key pair` (If you don’t have an existing key pair, ensure SSH access is not required for this lab)

#### 5. Network Settings:
- **VPC:** Choose `YourTestVpc`
- **Subnet:** Choose `us-east-1a` Availability Zone

#### 6. Security Group:
- **Security Group Name:** `Security-Group-Lab`
- **Description:** `HTTP Security Group`
- **Inbound Security Group Rules:**
  - **Type:** `HTTP (port 80)`

#### 7. Configure Storage:
- **Root Volume:** `gp2` (default type)

#### 8. Advanced Details:
- Scroll to the **User Data** section:
  - **Choose File** and select your **user-data script** file (ensure it displays instance details in a browser).
  
    Example of a simple user-data script:
    ```bash
    #!/bin/bash
    echo "<html><body><h1>Instance Information</h1><pre>" > /var/www/html/index.html
    curl http://000.000.000.000/latest/meta-data/ >> /var/www/html/index.html
    echo "</pre></body></html>" >> /var/www/html/index.html
    service httpd start
    ```

#### 9. Review:
- Review the settings and click **"Launch Instance"**.

#### 10. Success Alert:
- After launching, review the success message, then scroll down and click **"View all Instances"**.

#### 11. Review Instance:
- In the **Instances** section, select **webserver01** and confirm the instance is **running**.
- Under the **Details** section, copy the **Public IPv4 DNS** (or Public IP).
- Paste the copied DNS into a browser tab to ensure the webpage displays the correct instance details (from the user-data script).

---

### 3. Launch a Second EC2 Instance in a Different Availability Zone

Repeat the same steps as above to launch the second instance, but make the following adjustments:

#### 1. Name and Tags Section:
- **Name:** `webserver02`

#### 2. Availability Zone:
- **Choose:** `us-east-1b` (this is a different Availability Zone from the first instance)

#### 3. Security Group:
- Use the same security group, `Security-Group-Lab`, or create a new one if desired.

#### 4. User Data:
- Use the same or a different user-data script as needed.

#### 5. Review and Launch:
- Follow the same steps for review and launching as in the first instance setup.

#### 6. Instance Confirmation:
- After launching, ensure both instances (**webserver01** and **webserver02**) are **running**.
- Copy the **Public IPv4 DNS** of **webserver02** and paste it into a browser tab to verify that the webpage is functioning correctly.

---

## Summary

By following these steps, we successfully launched two EC2 instances in different Availability Zones with a user-data script that displays instance metadata in a browser.

---



