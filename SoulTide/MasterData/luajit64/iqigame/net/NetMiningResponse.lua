-- chunkname: @IQIGame\\Net\\NetMiningResponse.lua

function net_mining.enterMapResult(code, layer)
	MiningModule.EnterMapResult(layer)
end

function net_mining.excavateResult(code, gridId)
	MiningModule.ExcavateResult(gridId)
end

function net_mining.autoExcavateResult(code, gridIds)
	MiningModule.AutoExcavateResult(gridIds)
end

function net_mining.selectDialogResult(code, nextDialogCid)
	MiningModule.SelectDialogResult(nextDialogCid)
end

function net_mining.interactResult(code, gridId)
	MiningModule.InteractResult(gridId)
end

function net_mining.notifyGridComplete(gridId)
	MiningModule.NotifyGridComplete(gridId)
end

function net_mining.notifyEnterLayer(layer)
	MiningModule.NotifyEnterLayer(layer)
end

function net_mining.notifyOpenDialog(dialogCid)
	MiningModule.NotifyOpenDialog(dialogCid)
end

function net_mining.notifyFightComplete(win, dmgRecords, getItems)
	MiningModule.NotifyFightComplete(win, dmgRecords, getItems)
end

function net_mining.notifyGetRewards(getItems)
	MiningModule.NotifyGetRewards(getItems)
end
