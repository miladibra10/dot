# Enable Git commit signing with SSH
# This configuration enables SSH-based commit signing in Git.

git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global user.signingkey ~/.ssh/id_ed25519.pub
