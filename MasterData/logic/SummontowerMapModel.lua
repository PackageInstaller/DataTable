-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummontowerMapModel.lua

module("logic.extensions.summer.model.SummontowerMapModel", package.seeall)

local SummontowerMapModel = class("SummontowerMapModel", BaseModel)

function SummontowerMapModel:onInit()
	self:onReset()
end

function SummontowerMapModel:onReset()
	self:clearData()
end

function SummontowerMapModel:clearData()
	self._gridData = nil
	self._mapId = 0
	self._doorGridId = 0
	self._resultScores = -1
	self._passGame = nil
	self._playerPosRow = 0
	self._playerPosCol = 0

	self:clearGridData()
end

function SummontowerMapModel:setPlayerPos(playerPosRow, playerPosCol)
	self._playerPosRow = playerPosRow
	self._playerPosCol = playerPosCol
end

function SummontowerMapModel:getPlayerPos()
	return self._playerPosRow, self._playerPosCol
end

function SummontowerMapModel:getMapGridsData()
	return self._gridData
end

function SummontowerMapModel:setResultScores(scores)
	self._resultScores = scores
end

function SummontowerMapModel:getResultScores()
	return self._resultScores
end

function SummontowerMapModel:setPassGame(passGame)
	self._passGame = passGame
end

function SummontowerMapModel:isPassGame()
	return self._passGame
end

function SummontowerMapModel:getRowAndCol(idx)
	local row = math.ceil(idx / 6)
	local col = idx - (row - 1) * 6

	return row, col
end

function SummontowerMapModel:setMapGridsData(mapInfo)
	local mapId = mapInfo.mapId

	self._mapId = mapId
	self._playerPosRow = 0
	self._playerPosCol = 0
	self._gridData = {}
	self._curMustHandleGridId = mapInfo.curMustHandleGridId

	for i = 1, #mapInfo.gridInfos do
		local nodeMo = SummomMapNodeMO.New()

		nodeMo.mapId = mapId

		self:updateGrid(mapInfo.gridInfos[i], nodeMo)
		table.insert(self._gridData, nodeMo)
	end

	self:_initCoinAndBox_BirthPoint()
	self:_calDoorGridId()
	self:checkDoorUnlock()
end

function SummontowerMapModel:_initCoinAndBox_BirthPoint()
	local mapCo = SummontowerConfig.instance:getMapCo(self._mapId)

	for i = 1, #mapCo do
		local eventType = mapCo[i].eventType

		if eventType == SummonGridEvtType.BirthPoint or (eventType == SummonGridEvtType.Coin or eventType == SummonGridEvtType.Box) and not self:getMapGridData(mapCo[i].gridId) then
			local nodeMo = SummomMapNodeMO.New()

			nodeMo.mapId = self._mapId

			local gridInfo = {
				gridId = mapCo[i].gridId,
				girdStatus = SummomMapNodeMO.gridStatus.Init
			}

			self:updateGrid(gridInfo, nodeMo)

			nodeMo.isUnlock = self:checkGridUnlock(mapCo[i].gridId)

			table.insert(self._gridData, nodeMo)
		end
	end
end

function SummontowerMapModel:getDoorGridId()
	return self._doorGridId
end

function SummontowerMapModel:_calDoorGridId()
	local mapCo = SummontowerConfig.instance:getMapCo(self._mapId)

	for i = 1, #mapCo do
		if mapCo[i].eventType == SummonGridEvtType.Door then
			self._doorGridId = mapCo[i].gridId

			break
		end
	end
end

function SummontowerMapModel:setCurMustHandleGridId(curMustHandleGridId)
	self._curMustHandleGridId = curMustHandleGridId
end

function SummontowerMapModel:getCurMustHandleGridId()
	return self._curMustHandleGridId
end

function SummontowerMapModel:updateGrid(gridInfo, nodeMo)
	if not nodeMo and self._gridData then
		nodeMo = self:getMapGridData(gridInfo.gridId)
	end

	if not nodeMo then
		return
	end

	local mapId = nodeMo.mapId
	local gridId = gridInfo.gridId
	local gridCo = SummontowerConfig.instance:getMapGridCo(mapId, gridId)

	nodeMo.gridId = gridId
	nodeMo.isUnlock = true
	nodeMo.isFinished = gridInfo.girdStatus == SummomMapNodeMO.gridStatus.Fnish
	nodeMo.gridEventType = gridCo.eventType

	if gridCo.eventType == SummonGridEvtType.Shop then
		nodeMo.shopEvent = gridInfo.shopEvent
		nodeMo.gridEventId = nodeMo.shopEvent.shopId
	elseif gridCo.eventType == SummonGridEvtType.Guard and gridInfo:HasField("guardEvent") then
		nodeMo.guardEvent = gridInfo.guardEvent
		nodeMo.gridEventId = nodeMo.guardEvent.eventId
	end

	nodeMo.girdStatus = gridInfo.girdStatus
	nodeMo.extInfo = gridInfo.extInfo
end

function SummontowerMapModel:checkCoinAndBoxUnlock()
	if not self._gridData then
		return
	end

	for i = 1, #self._gridData do
		local gridData = self._gridData[i]

		if (gridData.gridEventType == SummonGridEvtType.Coin or gridData.gridEventType == SummonGridEvtType.Box) and not gridData.isFinished and not gridData.isUnlock then
			gridData.isUnlock = self:checkGridUnlock(gridData.gridId)
		end
	end
end

function SummontowerMapModel:checkDoorUnlock()
	local isUnlockDoor = self:checkGridUnlock(self._doorGridId)

	if not isUnlockDoor or self:getMapGridData(self._doorGridId) then
		return
	end

	local nodeMo = SummomMapNodeMO.New()

	nodeMo.mapId = self._mapId

	local gridInfo = {
		gridId = self._doorGridId,
		girdStatus = SummomMapNodeMO.gridStatus.Init
	}

	self:updateGrid(gridInfo, nodeMo)
	table.insert(self._gridData, nodeMo)
end

function SummontowerMapModel:checkGridUnlock(gridId)
	local gridCo = SummontowerConfig.instance:getMapGridCo(self._mapId, gridId)

	if not gridCo then
		return false
	end

	if string.nilorempty(gridCo.unlockCondition) then
		return true
	end

	local unlockCondition = string.split(gridCo.unlockCondition, "|")

	for i = 1, #unlockCondition do
		local grid = string.split(unlockCondition[i], "$")

		if grid[1] == "Grid" then
			local gridData = self:getMapGridData(checknumber(grid[2]))

			if gridData and gridData.isFinished then
				return true
			end
		end
	end

	return false
end

function SummontowerMapModel:getMapGridData(gridId)
	if not self._gridData then
		return
	end

	for i = 1, #self._gridData do
		if self._gridData[i].gridId == gridId then
			return self._gridData[i]
		end
	end
end

function SummontowerMapModel:saveGridData(gridId)
	self._summomGridRecordMO = SummomGridRecordMO.New()
	self._summomGridRecordMO.gridId = gridId
	self._summomGridRecordMO.currPets = SummontowerPetsModel.instance:getPets()
end

function SummontowerMapModel:getGridRecordData()
	return self._summomGridRecordMO
end

function SummontowerMapModel:clearGridData()
	self._summomGridRecordMO = nil
end

function SummontowerMapModel:canMake1Wish()
	return self:getWishGridData() ~= nil
end

function SummontowerMapModel:getWishGridData()
	if not SummontowerModel.instance:isGameInfoReady() then
		return
	end

	local curMustHandleGridId = SummontowerMapModel.instance:getCurMustHandleGridId()

	if curMustHandleGridId == 0 then
		return
	end

	local gridData = SummontowerMapModel.instance:getMapGridData(curMustHandleGridId)

	if gridData and gridData.girdStatus == SummomMapNodeMO.gridStatus.Wish then
		return gridData
	end
end

function SummontowerMapModel:getOneGuardNode()
	if not self._gridData then
		return
	end

	for i = 1, #self._gridData do
		local gridData = self._gridData[i]

		if gridData.gridEventType == SummonGridEvtType.Guard then
			return gridData
		end
	end
end

SummontowerMapModel.instance = SummontowerMapModel.New()

return SummontowerMapModel
