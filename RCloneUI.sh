#!/bin/bash
run () {
    DRIVE_ID=$(zenity --entry --title="RClone UI" --text="Enter Drive ID")
    if [ "$DRIVE_ID" == "" ]
    then
        zenity --error --title="RClone UI" --text="No Drive ID"
        exit 0
    fi

    WHAT_TO_DO=$(zenity --list --title="RClone UI" --column="0" "Sync To Drive" "Sync To Local Folder" --hide-header)

    if [ "$WHAT_TO_DO" == "Sync To Drive" ]
    then
        FOLDER=$(zenity --file-selection --directory --title="Select Folder To Sync To $DRIVE_ID")
        echo Sync to $FOLDER
        gnome-terminal -- /bin/sh -c "rclone sync '$FOLDER' '$DRIVE_ID': --progress; exec bash"
    fi
    if [ "$WHAT_TO_DO" == "Sync To Local Folder" ]
    then
        FOLDER=$(zenity --file-selection --directory --title="Select Folder To Sync To $DRIVE_ID")
        echo Sync to $DRIVE_ID
        gnome-terminal -- /bin/sh -c "rclone sync '$DRIVE_ID': '$FOLDER' --progress; exec bash"
    fi
}

if zenity --question --title="RClone UI" --text="Do you know your RClone Drive ID"
then
    run
else
    DRIVES=$(rclone listremotes) 
    zenity --info --title="Drives" --text=$DRIVES
    run
fi