### **Jenkins Terraform Automation**

This repository contains Terraform configurations and Jenkins pipelines for provisioning and managing a **Jenkins cluster** on AWS. The infrastructure includes a **Jenkins Master** and multiple **Jenkins Agents**, with automation for deployment, state management, and pipeline execution.

---

### **Repository Structure**

```
├── config/backend/            # Terraform state backend configuration (S3 + DynamoDB)
├── cicd/               # CI/CD pipelines for Terraform Apply & Destroy
├── environment/
│   ├── dev/            # Terraform configuration for the Development environment
│    |──── scripts/          # Automation scripts (e.g., Jenkins agent startup)
│   ├── prod/           # Terraform configuration for the Production environment
│    |──── scripts/          # Automation scripts (e.g., Jenkins agent startup)
├── modules/            # Reusable Terraform modules (VPC, Compute, Security)
└── README.md           # Project documentation
```

---

### **Features**

- **Jenkins Master and Agent Deployment** – Provisioned with Terraform.
- **Environment-Specific Configurations** – Separate folders for `dev` and `prod` environments.
- **Remote Terraform State Management** – Uses **S3 backend** and **DynamoDB locking** for secure state management.
- **Parameterized Pipelines** – CI/CD pipelines for Terraform Apply & Destroy stored in `cicd/`.
- **Security Best Practices** –
  - Restricted access to Jenkins via **admin IP only**.
  - **SSH Key authentication** for Jenkins Master and Agents.
  - **Remote execution support** for agent startup.

---

### **Prerequisites**

- **Terraform** (latest version)
- **AWS CLI** with configured credentials
- **Jenkins with required plugins** (Git, AWS Credentials, Pipeline, Utility Steps)
- **S3 bucket and DynamoDB table** for state storage

---

### **Usage**

#### **1. Clone the repository**

```bash
git clone git@github.com:vti-do2402/jenkins-terraform.git
cd jenkins-terraform
```

#### **2. Configure Terraform Backend**

Edit `backend.tf` in `environment/dev/provider.tf` or `environment/prod/provider.tf` to match your S3 bucket and DynamoDB setup.

#### **3. Deploy Infrastructure**

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

#### **4. Access Jenkins**

- **Jenkins Master**: `http://<JENKINS_MASTER_IP>:8080`
- **Jenkins Agent Logs**: Check `/var/log/jenkins-agent.log`

#### **5. Run Terraform Pipelines in Jenkins**

- Navigate to **Jenkins Dashboard** → Select **Terraform Apply Pipeline** → **Run Build with Parameters**

#### **6. Destroy Infrastructure (When Needed)**

```bash
terraform destroy --auto-approve
```
