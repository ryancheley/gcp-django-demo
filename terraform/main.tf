resource "random_id" "instance_id" {
  byte_length = 4
}

data "template_file" "windows-metadata" {
template = <<EOF
$securePassword = ConvertTo-SecureString "${var.password}" -AsPlainText -Force
New-LocalUser -Name "admin" -Password $securePassword -PasswordNeverExpires:$true
net localgroup administrators admin /add

 # Install IIS and CGI
Install-WindowsFeature -name Web-Server,Web-CGI -IncludeManagementTools

# Enable IIS-ApplicationDevelopment
dism /online /enable-feature /featurename:IIS-ApplicationDevelopment

# Enable CGI
dism /online /enable-feature /featurename:IIS-CGI


# Install Python 3.11
Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe -OutFile C:\\python-3.11.0-amd64.exe;
Start-Process C:\\python-3.11.0-amd64.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1 /c dir `"%SystemDrive%\Python`' -Wait;

# Install Visual Studio Code
Invoke-WebRequest -Uri https://code.visualstudio.com/sha/download?build=stable"&"os=win32-x64 -OutFile C:\\vscode-setup.exe;
Start-Process C:\\vscode-setup.exe -ArgumentList '/silent /mergetasks=!runcode,!desktopicon' -Wait; 

# Download Git for Windows installer 
Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-64-bit.exe -OutFile C:\Git-2.31.1-64-bit.exe 

# Install Git for Windows with default options 
Start-Process C:\Git-2.31.1-64-bit.exe -ArgumentList '/SILENT' -Wait
EOF
}

provider "google" {
  project = var.project
}

resource "google_compute_instance" "windows_server" {
  count        = var.instance_count
  name         = "${lower(var.cloud)}-${lower(var.app_name)}-${var.environment}-vm-${count.index}-${random_id.instance_id.hex}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20230414"
      size  = 50
    }
    
  }

  metadata = {
    sysprep-specialize-script-ps1 = data.template_file.windows-metadata.rendered
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
    access_config {

    }    
  }

  tags = ["http-server", "https-server"]

}


output "external_ips" {
  value = [for instance in google_compute_instance.windows_server : instance.network_interface[0].access_config[0].nat_ip]
}
