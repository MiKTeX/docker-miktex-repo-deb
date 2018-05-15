if not exist %~dp0gnupg\nul (
  mkdir %~dp0gnupg
  gpg --homedir=%~dp0gnupg --gen-key
  gpg --homedir=%~dp0gnupg --export-secret-keys > %~dp0signing.sec
)
set command=%1
set distribution=%2
set component=%3
set passphrase=test
docker run --rm -t ^
  -v %~dp0debs:/miktex/debs:ro ^
  -v %~dp0signing.sec:/miktex/signing.sec:ro ^
  -v %~dp0aptly:/miktex/aptly:rw ^
  -e "MIKTEX_PASSPHRASE=%passphrase%" ^
  miktex/miktex-repo-deb ^
  /miktex/manage-repository.sh %command% %distribution% %component%
