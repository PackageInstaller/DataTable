-- chunkname: @IQIGame\\Net\\NetDialogResponse.lua

function net_dialog.selectDialogResult(code, nextDialogCid)
	PlayerModule.OnSelectDialogResult(nextDialogCid)
end

function net_dialog.notifyOpenDialog(dialogCid)
	PlayerModule.PlayerInfo.currDialog = dialogCid

	DialogModule.OpenDialog(dialogCid, false, true)
end
