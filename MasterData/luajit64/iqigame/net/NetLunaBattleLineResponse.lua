-- chunkname: @IQIGame\\Net\\NetLunaBattleLineResponse.lua

function net_lunaBattleLine.garrisonResult(code, zoneId, soulPrefabId, garrison)
	LunaBattleLineModule.OnGarrison(zoneId, soulPrefabId, garrison)
end

function net_lunaBattleLine.getAssistsResult(code, zoneId, assistUnits)
	LunaBattleLineModule.OnGetAssists(zoneId, assistUnits)
end

function net_lunaBattleLine.refreshAssistResult(code, zoneId, assistUnits)
	LunaBattleLineModule.OnRefreshAssists(zoneId, assistUnits)
end

function net_lunaBattleLine.getStrengthenSoulPrefabResult(code, zoneId, soulPrefabs)
	LunaBattleLineModule.OnGetStrengthenSoulPrefab(zoneId, soulPrefabs)
end

function net_lunaBattleLine.enterFortMazeResult(code, zoneId, maze)
	MazeModule.EnterMaze(maze)
end

function net_lunaBattleLine.enterSealMazeResult(code, zoneId, maze)
	MazeModule.EnterMaze(maze)
end

function net_lunaBattleLine.enterStrengthenMazeResult(code, zoneId, maze)
	MazeModule.EnterMaze(maze)
end

function net_lunaBattleLine.broadcastGarrison(zoneId, pname, soulCid)
	return
end
