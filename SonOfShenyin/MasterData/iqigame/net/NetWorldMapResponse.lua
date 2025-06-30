-- chunkname: @IQIGame\\Net\\NetWorldMapResponse.lua

function net_sceneMap.enterAreaResult(code, areaCid, roomCid, active)
	WorldMapModule.EnterAreaResult(areaCid, roomCid, active)
end

function net_sceneMap.enterRoomResult(code, areaCid, roomCid, active, data)
	WorldMapModule.EnterRoomResult(areaCid, roomCid, active, data)
end

function net_sceneMap.moveCompResult(code)
	WorldMapModule.MoveCompResult()
end

function net_sceneMap.notifyAreas(areas)
	WorldMapModule.NotifyAreas(areas)
end

function net_sceneMap.notifyRooms(rooms)
	WorldMapModule.NotifyRooms(rooms)
end

function net_sceneMap.notifyComps(comps)
	WorldMapModule.NotifyComps(comps)
end

function net_sceneMap.notifyActions(actions)
	WorldMapModule.NotifyActions(actions)
end

function net_sceneMap.triggerActionResult(code, actionCid, schedule, pod)
	WorldMapModule.TriggerActionResult(actionCid, schedule, pod)
end

function net_sceneMap.notifyFinishActions(finishActions)
	WorldMapModule.NotifyFinishActions(finishActions)
end

function net_sceneMap.notifyEnterRooms(areaCid, roomCid)
	WorldMapModule.EnterRoomResult(areaCid, roomCid, true)
end

function net_sceneMap.openBoxResult(code)
	return
end

function net_sceneMap.wishResult(code)
	return
end

function net_sceneMap.changeMapTimeSpanResult(code)
	WorldMapModule.ChangeMapTimeSpanResult()
end

function net_sceneMap.notifyMapTimeSpan(timeSpan)
	WorldMapModule.NotifyMapTimeSpan(timeSpan)
end

function net_sceneMap.notifySceneMapInfo(info)
	WorldMapModule.NotifySceneMapInfo(info)
end
