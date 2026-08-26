-- chunkname: @modules/logic/versionactivity3_5/lamona/model/LamonaGameModel.lua

module("modules.logic.versionactivity3_5.lamona.model.LamonaGameModel", package.seeall)

local LamonaGameModel = class("LamonaGameModel", BaseModel)

function LamonaGameModel:onInit()
	self:clearAllData()
end

function LamonaGameModel:reInit()
	self:clearAllData()
end

function LamonaGameModel:clearAllData()
	self._genUid = 0
	self._targetGhostCount = 0
	self._isGameEnd = false
	self._playerUid = nil
	self._unitDict = {}
	self._type2UnitDict = {}
	self._grid2UnitUidDict = {}
	self._saveGameInfoList = {}

	self:_setGameEpisodeId()
	self:_setGameId()
	self:setRound()
	self:setGhostMoveTurn()
	self:setPropCount()
	self:setCaughtGhostCount()
end

function LamonaGameModel:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function LamonaGameModel:onEnterGame(episodeId, gameId)
	self:clearAllData()
	LamonaStatHelper.instance:initGameStartTime()
	self:_setGameEpisodeId(episodeId)
	self:_setGameId(gameId)

	local propCount = LamonaConfig.instance:getLamonaPropCount(gameId)

	self:setPropCount(propCount)

	local mapId = self:getMapId()
	local mapContents = LamonaConfig.instance:getLamonaMapContent(mapId)

	if not string.nilorempty(mapContents) then
		local mapData = cjson.decode(mapContents)

		for _, data in ipairs(mapData) do
			local x = data.x
			local y = data.y
			local dirList = string.splitToNumber(data.dirs, "#")
			local unitIdList = string.splitToNumber(data.unitIds, "#")

			for i, id in ipairs(unitIdList) do
				local attrDict = {}
				local attrStrList = LamonaConfig.instance:getLamonaUnitAttrList(id)

				for _, attrStr in ipairs(attrStrList) do
					local attrData = string.split(attrStr, "#")
					local attrKey = attrData[1]

					attrDict[attrKey] = tonumber(attrData[2])
				end

				local unitInfo = {
					x = x,
					y = y,
					dir = dirList[i],
					attrDict = attrDict
				}
				local mo = self:addUnitMO(id, unitInfo)
				local type = mo and mo:getType()

				if type == LamonaEnum.UnitType.Player then
					self._playerUid = mo:getUid()
				elseif type == LamonaEnum.UnitType.Ghost then
					self._targetGhostCount = self._targetGhostCount + 1
				end
			end
		end
	end
end

function LamonaGameModel:saveGameInfo()
	local round = self:getRound()
	local propCount = self:getPropCount()
	local caughtGhostCount = self:getCaughtGhostCount()
	local unitInfoDict = {}

	for uid, unitMO in pairs(self._unitDict) do
		local type = unitMO:getType()
		local isGhost = type == LamonaEnum.UnitType.Ghost

		if isGhost or type == LamonaEnum.UnitType.Player or type == LamonaEnum.UnitType.Prop then
			if not ((isGhost or nil) and unitMO:getIsCaught()) then
				unitInfoDict[uid] = unitMO:getUnitInfo()
			end
		end
	end

	local info = {
		round = round,
		propCount = propCount,
		caughtGhostCount = caughtGhostCount,
		unitInfoDict = unitInfoDict
	}

	table.insert(self._saveGameInfoList, info)
end

function LamonaGameModel:popLastSaveGameInfo()
	local info

	return (self._saveGameInfoList and #self._saveGameInfoList > 0 or nil) and table.remove(self._saveGameInfoList)
end

function LamonaGameModel:isHasSaveGameInfo()
	return self._saveGameInfoList and #self._saveGameInfoList > 0
end

function LamonaGameModel:loadUnitInfos(unitInfoDict)
	local loadedUid = {}

	unitInfoDict = unitInfoDict or {}

	for uid, unitInfo in pairs(unitInfoDict) do
		local mo = self:getUnitByUid(uid)

		if mo then
			local x = unitInfo.x
			local y = unitInfo.y

			self:setUnitGrid(uid, x, y)
			mo:setUnitInfo(unitInfo)
		else
			self:addUnitMO(unitInfo.id, unitInfo)
		end

		loadedUid[uid] = true
	end

	local toRemoveList = {}

	for uid, mo in pairs(self._unitDict or {}) do
		local type = mo:getType()

		if not loadedUid[uid] and type ~= LamonaEnum.UnitType.Obstacle then
			table.insert(toRemoveList, uid)
		end
	end

	for _, uid in ipairs(toRemoveList) do
		self:removeUnitMO(uid)
	end
end

function LamonaGameModel:addUnitMO(id, info)
	if not id or not info then
		return
	end

	local type = LamonaConfig.instance:getLamonaUnitType(id)

	if not type then
		return
	end

	local mo

	if not info.uid then
		local uid = self:_generateUid()

		mo = type == LamonaEnum.UnitType.Ghost and LamonaGameGhostUnitMO.New(uid, id, info) or LamonaGameUnitMO.New(uid, id, info)
		self._unitDict[uid] = mo

		local typeUnitDict = GameUtil.tabletool_checkDictTable(self._type2UnitDict, type)

		typeUnitDict[uid] = mo

		local mapWidth = self:getMapSize()
		local gridId = LamonaHelper.getGridId(info.x, info.y, mapWidth)
		local gridUnitUidDict = GameUtil.tabletool_checkDictTable(self._grid2UnitUidDict, gridId)

		gridUnitUidDict[uid] = true

		return mo
	end
end

function LamonaGameModel:removeUnitMO(uid)
	local mo = self:getUnitByUid(uid)

	if not mo then
		return
	end

	self._unitDict[uid] = nil

	local type = mo:getType()

	if self._type2UnitDict[type] then
		self._type2UnitDict[type][uid] = nil
	end

	local mapWidth = self:getMapSize()
	local gridX, gridY = mo:getGridXY()
	local gridId = LamonaHelper.getGridId(gridX, gridY, mapWidth)

	if self._grid2UnitUidDict and self._grid2UnitUidDict[gridId] then
		self._grid2UnitUidDict[gridId][uid] = nil
	end
end

function LamonaGameModel:_setGameEpisodeId(episodeId)
	self._gameEpisodeId = episodeId
end

function LamonaGameModel:_setGameId(gameId)
	self._gameId = gameId
	self._mapId = nil
	self._mapWidth = 0
	self._mapHeight = 0

	if self._gameId then
		self._mapId = LamonaConfig.instance:getLamonaMapId(self._gameId)
		self._mapWidth, self._mapHeight = LamonaConfig.instance:getLamonaMapSize(self._mapId)
	end
end

function LamonaGameModel:setRound(round)
	self._round = math.max(0, round or 0)
end

function LamonaGameModel:addRound()
	local round = self:getRound()

	self:setRound(round + 1)
end

function LamonaGameModel:setGameEnd()
	self._isGameEnd = true
end

function LamonaGameModel:setGhostMoveTurn(isGhostMove)
	self._isGhostMoveTurn = isGhostMove
end

function LamonaGameModel:setPropCount(propCount)
	self._propCount = math.max(0, propCount or 0)
end

function LamonaGameModel:setCaughtGhostCount(count)
	self._caughtGhostCount = count or 0
end

function LamonaGameModel:setUnitGrid(uid, newX, newY)
	local mo = self:getUnitByUid(uid)

	if not mo then
		return
	end

	local oldX, oldY = mo:getGridXY()

	if oldX == newX and oldY == newY then
		return
	end

	local mapWidth = self:getMapSize()
	local oldGridId = LamonaHelper.getGridId(oldX, oldY, mapWidth)
	local oldGridUnitUidDict = GameUtil.tabletool_checkDictTable(self._grid2UnitUidDict, oldGridId)

	oldGridUnitUidDict[uid] = nil

	local newGridId = LamonaHelper.getGridId(newX, newY, mapWidth)
	local newGridUnitUidDict = GameUtil.tabletool_checkDictTable(self._grid2UnitUidDict, newGridId)

	newGridUnitUidDict[uid] = true

	mo:setGridXY(newX, newY)
end

function LamonaGameModel:getGameEpisodeId()
	return self._gameEpisodeId
end

function LamonaGameModel:getGameId()
	return self._gameId
end

function LamonaGameModel:getMapId()
	return self._mapId
end

function LamonaGameModel:getMapSize()
	return self._mapWidth, self._mapHeight
end

function LamonaGameModel:getRound()
	return self._round or 0
end

function LamonaGameModel:getIsGameEnd()
	return self._isGameEnd or ViewMgr.instance:isOpen(ViewName.LamonaResultView)
end

function LamonaGameModel:getIsGhostMoveTurn()
	local gameId = self:getGameId()

	if not gameId then
		return
	end

	local isGameEnd = self:getIsGameEnd()

	if isGameEnd then
		return
	end

	return self._isGhostMoveTurn
end

function LamonaGameModel:getIsPlayerTurn()
	local gameId = self:getGameId()

	if not gameId then
		return
	end

	local isGameEnd = self:getIsGameEnd()

	if isGameEnd then
		return
	end

	if self._isGhostMoveTurn then
		return
	end

	return true
end

function LamonaGameModel:getPropCount()
	return self._propCount or 0
end

function LamonaGameModel:getTargetGhostCount()
	return self._targetGhostCount or 0
end

function LamonaGameModel:getCaughtGhostCount()
	return self._caughtGhostCount or 0
end

function LamonaGameModel:getUnitDict()
	return self._unitDict
end

function LamonaGameModel:getUnitByUid(uid)
	return self._unitDict and self._unitDict[uid]
end

function LamonaGameModel:getUnitUidsInGrid(x, y, unitType)
	local uidList = {}
	local mapWidth = self:getMapSize()
	local gridId = LamonaHelper.getGridId(x, y, mapWidth)

	if self._grid2UnitUidDict then
		if self._grid2UnitUidDict then
			for uid, _ in pairs(self._grid2UnitUidDict) do
				if unitType then
					local mo = self:getUnitByUid(uid)

					if mo and mo:getType() == unitType then
						table.insert(uidList, uid)
					end
				else
					table.insert(uidList, uid)
				end
			end
		end

		return uidList
	end
end

function LamonaGameModel:getHasUnityTypeInGrid(x, y, unitType)
	local mapWidth = self:getMapSize()
	local gridId = LamonaHelper.getGridId(x, y, mapWidth)

	if self._grid2UnitUidDict then
		if self._grid2UnitUidDict then
			for uid, _ in pairs(self._grid2UnitUidDict) do
				local mo = self:getUnitByUid(uid)

				if mo and mo:getType() == unitType then
					return true
				end
			end
		end

		return false
	end
end

function LamonaGameModel:getUnitDictByType(unitType)
	return self._type2UnitDict and self._type2UnitDict[unitType]
end

function LamonaGameModel:getPlayerMO()
	if not self._playerUid then
		local unitDict = self:getUnitDictByType(LamonaEnum.UnitType.Player)

		if unitDict then
			self._playerUid = next(unitDict)
		end
	end

	return self:getUnitByUid(self._playerUid)
end

function LamonaGameModel:getIsCanPlaceUnitInGrid(uid, targetGridX, targetGridY)
	local mo = self:getUnitByUid(uid)

	if not mo or not targetGridX or not targetGridY then
		return
	end

	local mapWidth, mapHeight = self:getMapSize()
	local isOutSize = LamonaHelper.isOutsizeMap(targetGridX, targetGridY, mapWidth, mapHeight)

	if isOutSize then
		return
	end

	local hasObstacle = self:getHasUnityTypeInGrid(targetGridX, targetGridY, LamonaEnum.UnitType.Obstacle)

	if hasObstacle then
		return
	end

	return true
end

LamonaGameModel.instance = LamonaGameModel.New()

return LamonaGameModel
