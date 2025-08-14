

# Google Cloud VM Instance Setup 
We're setting up a compute instnace in Google Cloud to use for the rest of the project. Before doing it we are going to create a pair of SSH keys (project wide) that we will use to ssh into the VM when we are working in it. 
- See docs and the step below. 
- https://cloud.google.com/compute/docs/connect/create-ssh-keys

## 1. Generate SSH Key Pair 
```bash
# Generate SSH key for Google Cloud VM (leave passphrase empty)
ssh-keygen -t rsa -f ~/.ssh/gcp-ssh-key-C username
```
- Note the username refers to the user for this VM. Choose your name or whatever. 
- Now print your public key.  `cat ~/.ssh/gcp-ssh-key.pub`
- Go to Google Cloud Console. Compute Engine > Metadata > SSH Keys
- Click Add SSH Key. Paste in the public key that you just printed. Click save.

## 2. Create VM Instance
- Go to **Compute Engine > VM Instances**
- Name your VM, choose region closest to you
- Machine type: `e2-standard-4` (4 vCPU, 16GB RAM)
- Boot disk: 20GB
- Create instance

## 3. SSH into VM
Now we need to securely get into our VM so we can start setting up our project environment there. 
  
```bash
ssh -i ~/.ssh/gcp-ssh-key chip@<EXTERNAL_IP>
```

## 4. Install Miniconda / Anaconda
Once in the VM, download and install Miniconda (or Anaconda)
Verify Python:
```bash 
which python
python -c "import pandas as pd; print(pd.__version__)"
```

## 5. Set up local SSH tunnel & Remote SSH for VScode
We'll do two things here. 
1. Set up a tunnel that allows us easy direct access to our VM from our local terminal. 
2. Setup VSCode RemoteSSH so we can connect to our VM there. 

#### Configure local SSH 
- Cd into your ~/.ssh folder on local machine and create a new file called config
- `touch config`. Open it in VSCode using `code .`
- Add this script to the config file to define the SSH tunnel: 
```bash 
Host nyc-taxi-vm
    HostName <EXTERNAL_IP>
    User chip
    IdentityFile ~/.ssh/gcp-ssh-key
```
- Now, you can ssh into the VM directly from terminal VM using thie command: 
```bash
ssh nyc-taxi-vm
```

#### Set up Remote SSH in VSCode
- In VSCode: Download Remote SSH extension from Microsoft 
- Open a remote window. You should see <SSH: your-vm-name> in bottom left of VScode window. 

## 6. Install Docker on the VM 
The tutorial does this manually (see Appendix). I used the steps from the official Docker docs and outlined the process below. 
#### [Docker Docs - Install Docker Engine on Debian](https://docs.docker.com/engine/install/debian/#prerequisites)


#### 1. Remove old Docker (`docker.io`) to avoid conflicts:
```bash
     sudo apt-get remove docker.io
     sudo apt autoremove
```
#### 2. Setup the official Docker apt repository. 
Paste the commands from Docker docs exactly (a bit long):
```bash 
# Install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Add Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list
sudo apt-get update
```
#### 3. Install docker pacakages.
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
#### 4. Verify the installation was successful. 
Run this command which should print a confirmation message. 
```bash 
sudo docker run hello-world
```
#### 5. Run docker without sudo 
On Linux, Docker normally requires `sudo`. If the steps above didn’t already handle this, fix it with:
[Linux Post-Installation Steps](https://docs.docker.com/engine/install/linux-postinstall/)

```bash
sudo usermod -aG docker $USER
newgrp docker
```

**To test running Docker without sudo:**

`docker run hello-world` → prints confirmation


`docker compose version` → prints Compose version

If errors occur, follow the post-install instructions above exactly.

## ✅  Status Check
- Docker Engine installed
- Compose plugin installed
- Commands can be run without sudo









## Appendix: Manual Installation of Docker & Docker Compose 
- **OS:** Debian/Ubuntu VM
- **Source:** Default OS repository (`docker.io`) + manual Compose binary
- **Packages installed via apt:** 
  - `docker.io` (older version of Docker Engine)
- **Compose installed manually:**
  - Download binary from GitHub into `$HOME/.docker/cli-plugins` or `/usr/local/lib/docker/cli-plugins`
  - Make it executable with `chmod +x`
- **Steps:**
  1. Install `docker.io` via `apt`
  2. Configure Docker to run without `sudo` (add user to `docker` group)
  3. Download and install Compose binary manually
- **Result:**
  - Works for learning and experiments
  - Docker and Compose may be older versions
  - Manual updates required for Compose

---

### ✅ Summary
| Feature | Official Docker Repo | Tutorial (`docker.io`) |
|---------|-------------------|----------------------|
| Docker Engine version | Latest stable | Often older |
| Compose | Installed as plugin | Manual binary download |
| Update via apt | Yes | No (manual for Compose) |
| No sudo setup | Yes, just add to docker group | Yes, same |
| Recommended for production | ✅ | ❌ |
| Quick learning setup | ❌ | ✅ |

