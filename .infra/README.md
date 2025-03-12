# Terraform Setup for Jenkins Cluster

## Project Structure

This Terraform configuration is structured into different levels to manage infrastructure efficiently.

### Environment Level

Contains configurations specific to an environment (e.g., `dev`, `prod`).

```
 environment/
 ├── dev/
 │   ├── data.tf
 │   ├── locals.tf
 │   ├── main.tf
 │   ├── outputs.tf
 │   ├── providers.tf
 │   ├── variables.tf
 │   ├── terraform.tfvars
```

### Module Level

Reusable modules for provisioning infrastructure components.

```
 modules/
 ├── jenkins-master/
 │   ├── scripts/
 │   │   ├── startup.sh
 │   ├── templates/
 │   │   ├── docker-compose.tpl
 │   ├── main.tf
 │   ├── outputs.tf
 │   ├── variables.tf
```

### Application Level

Defines the root project structure for managing infrastructure.

```
 root/
 ├── .infra/
 ├── config/
 ├── global/
 ├── environment/
 │   ├── dev/
 │   ├── prod/
 ├── modules/
 │   ├── jenkins-agent/  # Includes userdata script, EC2 instance, security groups, key pairs, remote execution for isolated Docker script runs.
 │   ├── jenkins-master/  # Same as above.
 │   ├── network/        # VPC, Subnets, and common Security Groups.
```

## Terraform Usage

### 1. Initialize, Plan, and Apply

1. Navigate to the environment folder (`dev` or `prod`):
   ```sh
   cd environment/dev
   ```
2. Initialize and validate Terraform:
   ```sh
   terraform init
   terraform fmt  # Format the configuration
   terraform validate  # Validate the configuration
   ```
3. Plan the Terraform execution:
   ```sh
   terraform plan
   ```
4. Apply the configuration:
   ```sh
   terraform apply
   ```

## Provisioning Jenkins Cluster

### 1. Deploying Jenkins Master

1. Ensure `jenkins_master` is provisioned first by setting the following in `terraform.tfvars`:
   ```hcl
   run_agent = false
   ```
2. Apply the configuration:
   ```sh
   terraform apply
   ```

### 2. Configuring Jenkins Agent

1. Manually set up the agent in the Jenkins GUI to retrieve:
   - Agent Secret
   - Agent Name
   - Agent Home Path
2. Update `terraform.tfvars` with these values.
3. Enable agent provisioning by setting:
   ```hcl
   run_agent = true
   ```
4. Apply the configuration again:
   ```sh
   terraform apply
   ```

## Notes

- Ensure your AWS credentials are correctly configured before running Terraform.
- The Jenkins master should be running before provisioning the agent.
- Modify security groups and networking settings according to your infrastructure needs.

---

This README provides a structured overview of the Terraform setup for Jenkins. If any modifications are needed, update the respective environment or module configurations accordingly.
