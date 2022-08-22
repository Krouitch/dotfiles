alias invs="innovus -stylus -invs -no_gui"
alias x=exit
alias cdAbb="cd /net/borvo/borvo0/projets/2019-07-ABB-IP-PVT.02/08-Place_And_Route_MENTOR; source_csh setup"
alias ABB-IP_Phase2="cd /net/varan/volume1/PROJETS/ABB-PVT-AF.01/dev/ABB-IP-Phase2 && source PROJECT/setup_project.sh"
alias PVTBS="cd /net/varan/volume1/PROJETS/ABB-PVT-AF.01/ABB-IP_PVTB && MATLAB_R2020b"
# export PATH_VEP=~/LocalStockKagao/vep
export PATH_VEP=/net/varan/volume1/PROJETS/VEP/USERS/fbe/vep
alias cdvep="cd $PATH_VEP; source SourceMe.csh"
alias cdnpucluster="cdvep ; cd $PATH_VEP/PARTITIONS/npu_cluster_domain/PNR/NITRO"
alias cdswu="cdvep ; cd $PATH_VEP/PARTITIONS/smartwake_domain/PNR/NITRO"

alias sudoX11='sudo xauth add $(xauth -f ~fbe/.Xauthority list|tail -1)'

alias vnc1k="/opt/TurboVNC/bin/vncserver -geometry 1920x1080 -wm /usr/bin/xfce4-session"
alias vnc2k="/opt/TurboVNC/bin/vncserver -geometry 2560x1440 -wm /usr/bin/xfce4-session"
alias vnc2kwide="/opt/TurboVNC/bin/vncserver -geometry 3440x1440 -wm /usr/bin/xfce4-session"

alias lr="ls -ltr"

alias v=vim
alias vtabs="vim -p"
alias psme="ps aux | grep fbe | grep"

alias ftpmentor="echo \"MdP2uUWfRX4e\" ; sftp francois.bertrand@dolphin.fr@mst-eu.mentor.com"
alias ftpmst="sftp -i ~/.ssh/id_rsa_mst francois.bertrand@dolphin.fr@mst-eu.mentor.com"
alias ftpsnps="echo \"M{^in4Di4=%K\" ; sftp dolfbertrand@eft.synopsys.com"
alias ftpcdns="echo \"Nope\" ; sftp ftp.cadence.com"
alias ftpgf="echo \"4uxnbvc4t3\" ; sftp dolphinip90@sgftp.globalfoundries.com"

alias cdphys="cd \$(pwd -P)"


function grep_tcl () {
  read -r -d '' HELP << EndOfHelp
  $CCHAR Help: grep_tcl
  $CCHAR Description:
  $CCHAR \tGreps in the find tcl files using extendeded regex
  $CCHAR Usage:
  $CCHAR \tgrep_tcl -path ../some/path -follow -i pat1 pat2 ...
  $CCHAR Arguments:
  $CCHAR \t -h|--help                    --> Optionnal, prints this help
  $CCHAR \t -path                        --> Optionnal, specify the startpoint of the search
  $CCHAR \t -follow                      --> Optionnal, follow symlinks
  $CCHAR \t -i                           --> Optionnal, case unsensitive
  $CCHAR \t -pat1 pat2 ...               --> Mandatory(at least one), extended regex to be matched in found tcl files
EndOfHelp

  declare -a pats
  FOLLOW=0
  CASESENSITIVE=1
  FINDPATH=.
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
        echo -e $HELP
        exit 0
        ;;
        -path)
        FINDPATH="$2"
        shift # past argument
        shift # past value
        ;;
        -follow)
        FOLLOW=1
        shift # past value
        ;;
        -i)
        CASESENSITIVE=0
        shift # past argument
        shift # past value
        ;;
        *)    # unknown option
        pats+=($1)
        shift # past argument
        ;;
    esac
  done
  if [[ $FOLLOW ]]; then
    files=$(find $FINDPATH -name "*.tcl" -follow -type f)
  else
    files=$(find $FINDPATH -name "*.tcl" -type f)
  fi
  declare -A matches
  for file in $files; do
    for pat in ${pats[@]}; do
      if [[ $CASESENSITIVE ]]; then
        match=$(grep -H -i -e $pat $file)
      else
        match=$(grep -H -e $pat $file)
      fi
      if [[ -n $match ]]; then
        matches[${file},${pat}]=$match
      fi
    done
  done
  for file in $files; do
    FILEMATCHES=0
    for pat in ${pats[@]}; do
      if [[ ${matches[${file},${pat}]+exists}  ]]; then
        if [[ $FILEMATCHES ]]; then
          echo "#############################################"
          echo "############ Grepped $file"
          echo "#############################################"
          FILEMATCHES=1
        fi
        echo "@@@@@@@@@@@@ Grep result of $pat"
        echo -e  $( echo ${matches[${file},${pat}]} | sed "s;${file}:;\\\\\\\\n;g" )
      fi
    done
    if [[ ! $FILEMATCHES ]]; then
      echo "#############################################"
      echo "############ Finished grepping $file"
      echo "#############################################"
    fi
  done
}
