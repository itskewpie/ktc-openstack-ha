# setup dev vips
return  unless  chef_environment == "dev"
node[:vips] = {
  "mysql-db" =>  {
    ip: "10.1.1.2",
    port: "3306"
  },
  "identity-api" => {
    ip: "10.1.1.2",
    port: "5000"
  },
  "identity-admin" => {
    ip: "10.1.1.2",
    port: "35357"
  },
  "compute-api" => {
    ip: "10.1.1.2",
    port: "8774"
  },
  "compute-ec2-api" => {
    ip: "10.1.1.2",
    port: "8773"
  },
  "compute-ec2-admin" => {
    ip: "10.1.1.2",
    port: "8773"
  },
  "compute-xvpvnc" => {
    ip: "10.1.1.2",
    port: "6081"
  },
  "compute-novnc" => {
    ip: "10.1.1.2",
    port: "6080"
  },
  "noetwork-api" => {
    ip: "10.1.1.2",
    port: "9696"
  },
  "image-api" => {
    ip: "10.1.1.2",
    port: "9292"
  },
  "image-registry" => {
    ip: "10.1.1.2",
    port: "9191"
  },
  "volume-api" => {
    ip: "10.1.1.2",
    port: "8776"
  },
  "metering-api" => {
    ip: "10.1.1.2",
    port: "8777"
  }
}

