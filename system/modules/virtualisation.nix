{config, pkgs, ...}:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "overlay2";
    autoPrune = {
      enable = true;
      dates = "daily";
    };
  };

  # systemd.services.init-gitea-br-network = {
  #   description = "Gitea Docker Bridge Network";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   
  #   serviceConfig.Type = "oneshot";
  #   script = let
  #     dockercli = "${config.virtualisation.docker.package}/bin/docker";
  #   in ''
  #     check=$(${dockercli} network ls | grep "gitea-br" || true)
  #      if [ -z "$check" ]; then
  #       ${dockercli} network create gitea-br
  #      else
  #       echo "gitea-br already exists in docker network"
  #      fi
  #   '';
  # };

  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers = {
  #     gitea = {
  #       image = "gitea/gitea:latest";
  #       extraOptions = [ "--network=gitea-br" ];
  #       ports = [ "3000:3000" "2222:22" ];
  #       volumes = [ "/etc/localtime:/etc/localtime:ro" ];
  #       dependsOn = [ "postgresql" ];
  #       environment = {
  #         USER_UID = "1000";
  #         USER_GID = "1000";
  #         GITEA__database__DB_TYPE = "postgres";
  #         GITEA__database__DHOST = "postgresql:5432";
  #         GITEA__database__NAME = "gitea";
  #         GITEA__database__USER = "gitea";
  #         GITEA__database__PASSWD = "gitea";
  #       };
  #     };
  #     postgresql = {
  #       image = "postgres:latest";
  #       extraOptions = [ "--network=gitea-br" ];
  #       volumes = [ "/etc/localtime:/etc/localtime:ro" ];
  #       environment = {
  #         POSTGRES_USER = "gitea";
  #         POSTGRES_PASSWORD = "gitea";
  #         POSTGRES_DB = "gitea";
  #       };
  #     };
  #   };
  # };
}
