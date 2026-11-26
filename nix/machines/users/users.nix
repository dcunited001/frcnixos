# [[file:../../../README.org::*Users][Users:1]]
{ pkgs, ... }: {

  # this is the default, I think
  users.groups = {
    users = {
      name = "users";
      gid = 1000;
    };
  };
  
}
# Users:1 ends here
