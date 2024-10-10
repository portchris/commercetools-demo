{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  terraform = pkgs.writers.writeBashBin "terraform" ''
    ${pkgs.terraform}/bin/terraform "$@"
  '';
in
pkgs.mkShell {
  name = "demo-commercetools-nix";
  buildInputs = [
    pkgs.nodejs_22
    terraform
    pkgs.pnpm
    pkgs.ngrok
  ];
  shellHook = ''

    # Begin creating terraform environment variables specific to project
    if [ -n "$TF_VARS" ]; then
      JSON_OBJ="{}"
      JSON_FILE=terraform.tfvars.json

      # Start the JSON
      echo "{" > "$JSON_FILE"

      # Read each line from the environment file
      while IFS= read -r line; do
          KEY=$(echo "$line" | cut -d '=' -f 1 | tr '[:upper:]' '[:lower:]')
          LINE=$(echo "$line" | cut -d '=' -f 2-)
          VALUE=$(echo "$LINE" | sed 's/"/\\"/g')
          if [[ $KEY != *"#"* ]] && [[ $KEY != "" ]]; then
            echo "  \"$KEY\": \"$VALUE\"," >> "$JSON_FILE"
            export TF_VAR_$KEY=$VALUE
          fi
      done < "./.env"

      # Remove the trailing comma and close the JSON object
      sed -i '$ s/,$//' "$JSON_FILE"
      echo "}" >> "$JSON_FILE"
    fi
  '';
}