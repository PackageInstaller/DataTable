-- chunkname: @IQIGame\\Net\\NetDreamMapResponse.lua

function net_dreamMap.enterMapResult(code, mapData)
	DreamlandModule.OnEnterMap(mapData)
end

function net_dreamMap.openCellResult(code, exectionItems, combo, movePoint, showCellX, showCellY)
	DreamlandModule.OnOpenCell(exectionItems, combo, movePoint, showCellX, showCellY)
end

function net_dreamMap.resetMapResult(code, mapData)
	DreamlandModule.OnResetMap(mapData)
end

function net_dreamMap.notifyOpenDialog(dialogCid)
	DreamlandModule.OnOpenDialog(dialogCid)
end

function net_dreamMap.selectDialogResult(code, nextDialogCid)
	DreamlandModule.MapData.currDialog = nextDialogCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)
end

function net_dreamMap.markCellResult(code, x, y, markType)
	DreamlandModule.OnMarkCell(x, y, markType)
end
