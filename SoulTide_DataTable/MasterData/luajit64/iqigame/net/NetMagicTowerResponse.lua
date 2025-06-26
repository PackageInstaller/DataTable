-- chunkname: @IQIGame\\Net\\NetMagicTowerResponse.lua

function net_magicTower.enterMapResult(code, mapData)
	MagicTowerModule.OnEnterMap(mapData)
end

function net_magicTower.moveResult(code, cellId)
	MagicTowerModule.OnMoveArrive(cellId)
end

function net_magicTower.notifyExecution(executionItem)
	MagicTowerModule.OnExecution(executionItem)
end

function net_magicTower.notifyOpenDialog(dialogCid)
	MagicTowerModule.OnOpenDialog(dialogCid)
end

function net_magicTower.selectDialogResult(code, nextDialogCid)
	MagicTowerModule.OnSelectDialog(nextDialogCid)
end

function net_magicTower.giveupResult(code)
	return
end

function net_magicTower.notifySettlement(success)
	MagicTowerModule.OnSettlement(success)
end
