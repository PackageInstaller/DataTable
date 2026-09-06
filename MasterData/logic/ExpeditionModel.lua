-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/model/ExpeditionModel.lua

module("logic.extensions.expedition.model.ExpeditionModel", package.seeall)

local ExpeditionModel = class("ExpeditionModel", BaseModel)
local GridType = {
	EMPTY = 0,
	END = 3,
	START = 1,
	EVENT = 2
}

ExpeditionModel.EventType = {
	PRIZE = 4,
	FIGHT = 1,
	TREASURE = 7,
	BUFF = 3,
	REVIVE = 5,
	PET = 2,
	SHOP = 6
}
ExpeditionModel.GridType = GridType

local tempArr = {
	{
		0,
		2,
		-2,
		4,
		-4,
		6,
		-6,
		8,
		-8,
		10,
		-10,
		12,
		-12,
		14,
		-14,
		16,
		-16,
		18,
		-18,
		20,
		-20
	},
	{
		1,
		-1,
		3,
		-3,
		5,
		-5,
		7,
		-7,
		9,
		-9,
		11,
		-11,
		13,
		-13,
		15,
		-15,
		17,
		-17,
		19,
		-19,
		21,
		-21
	}
}

function ExpeditionModel:ctor()
	return
end

function ExpeditionModel:onInit()
	self._info = {}
	self._gridList = {}
	self._colIndices = {}
	self._onekeySweepFootPrintsList = nil
	self._curOneKeyIndex = 1
	self._onekeySweepChangeSetId = nil
end

function ExpeditionModel:onReset()
	self._battleResult = nil
	self.needShowFinish = nil
	self.isGridDone = nil
	self._sweepChangeSetId = nil

	self:setRunBattleGridData(nil)

	self._info = {}
	self._gridList = {}
	self._colIndices = {}
	self._onekeySweepFootPrintsList = nil
	self._curOneKeyIndex = 1
	self._onekeySweepChangeSetId = nil
end

function ExpeditionModel:setRunBattleGridData(data)
	self._lastRunBattleGridData = data
end

function ExpeditionModel:getRunBattleGridData()
	return self._lastRunBattleGridData
end

function ExpeditionModel:isEventCompeleted(evtType, progress)
	if evtType == ExpeditionModel.EventType.FIGHT then
		return progress == 2
	end

	return progress ~= 0
end

function ExpeditionModel:setInfo(msg)
	ExpeditionTilingModel.instance:resetTilingMapInfos()
	self:setRunBattleGridData(nil)

	self._info = {}
	self._info.level = msg.level
	self._info.buffIds = msg.buffIds
	self._info.supportedPets = msg.supportedPets

	self:_setUpSupportedPetsMap(msg)

	self._info.footPrints = msg.footPrints
	self._info.gridTypeIds = msg.mapGridList
	self._info.endTime = checknumber(msg.endTime)
	self._info.curMaxZdl = msg.curMaxZdl

	ExpeditionSweepModel.instance:setSweepEvents(msg.sweepEvents)
	self:_setUpStatesMap(msg)
	self:setupGridList(msg.level)
	self:_calculateAxises(msg)
	self:_createEndGrid()

	self.isGridDone = not self:isAllFinished()

	ExpeditionTilingModel.instance:setTilingMapGrid(self._info.nextXAixs, self._info.nextYAixs, self._info.nextEventIndex)
	ExpeditionTilingModel.instance:setTilingMapInfos(msg.map)
	ExpeditionFmtModel.instance:setFormation(msg.myForm)
	GlobalDispatcher:dispatch(GlobalNotify.OnGetExpeditionInfo)
end

function ExpeditionModel:isInfoValid()
	return self._info and table.nums(self._info) > 0 and self._info.endTime - ServerTime.nowMs() > 0
end

function ExpeditionModel:updateData(msg)
	self._info.level = msg.level
	self._info.buffIds = msg.buffIds
	self._info.supportedPets = msg.supportedPets

	self:_setUpSupportedPetsMap(msg)

	self._info.footPrints = msg.footPrints

	self:_setUpStatesMap(msg)
	self:setupGridList(msg.level)
	self:_calculateAxises(msg, true)
	self:_createEndGrid()
	ExpeditionTilingModel.instance:setTilingMapGrid(self._info.nextXAixs, self._info.nextYAixs, self._info.nextEventIndex)
	ExpeditionTilingModel.instance:updateTilingMapInfos(msg.evetGrid, msg.canLeave)
end

function ExpeditionModel:onDoSweepEvent(msg)
	self._info.buffIds = msg.buffIds
	self._info.supportedPets = msg.supportedPets

	self:_setUpSupportedPetsMap(msg)
end

function ExpeditionModel:isAllFinished()
	if not self._info then
		return false
	end

	local info = self:getInfo()
	local isMaxLv = self:isMaxLevel(info.level + 1)

	if info.level and isMaxLv then
		local gridList = self:getGridList()
		local maxX = -9999

		for k, v in ipairs(gridList) do
			if maxX < v.xAxis then
				maxX = v.xAxis
			end
		end

		if info.xAxis == maxX then
			return true
		end
	end

	return false
end

function ExpeditionModel:onSweepLevelBack(msg)
	self._info.level = msg.level
	self._info.footPrints = msg.footPrints
	self._sweepChangeSetId = msg.changeSetId

	self:setupGridList(msg.level)
	self:_calculateAxises(msg)
	self:_createEndGrid()
	self:_setDoubleGetTitle(msg.changeSetId)

	self.needShowFinish = true

	ExpeditionTilingModel.instance:setTilingMapGrid(self._info.nextXAixs, self._info.nextYAixs, self._info.nextEventIndex)
	ExpeditionTilingModel.instance:resetTilingMapInfos()
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function ExpeditionModel:setSweepChangeSetId(changesetId)
	self._sweepChangeSetId = changesetId
end

function ExpeditionModel:getSweepChangeSetId()
	return self._sweepChangeSetId
end

function ExpeditionModel:onOneKeySweepBack(msg)
	self:setOneKeySweepChangeSetId(msg.changeSetId)
	self:_setDoubleGetTitle(msg.changeSetId)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self.needShowFinish = false

	if not msg.footPrints then
		self._onekeySweepFootPrintsList = msg.footPrints
		self._curOneKeyIndex = 1

		ExpeditionTilingModel.instance:setTilingMapGrid(self._info.nextXAixs, self._info.nextYAixs, self._info.nextEventIndex)
		ExpeditionTilingModel.instance:resetTilingMapInfos()
	end
end

function ExpeditionModel:setPopSweepOK(curLevel)
	GameUtil.saveUserDayData("exped_sweep_pop" .. curLevel, 1)
end

function ExpeditionModel:doAndGetCurrOneKeySweepData()
	if self._onekeySweepFootPrintsList and #self._onekeySweepFootPrintsList > 0 then
		local onekeyFootPrints = self._onekeySweepFootPrintsList[self._curOneKeyIndex]

		if onekeyFootPrints then
			local level = onekeyFootPrints.level

			if not onekeyFootPrints.footPrints then
				if not onekeyFootPrints.mapGridList then
					local mapGridList = {}

					self:setPopSweepOK(level)

					self._info.level = level
					self._info.footPrints = onekeyFootPrints.footPrints
					self._info.gridTypeIds = mapGridList

					local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(self._info.level + 1) or {}

					self._info.xAxis = #mapCos
					self._info.yAxis = 0
					self._info.curGridIndex = 0
					self._info.nextXAixs = 0
					self._info.nextYAixs = 0
					self._info.nextEventIndex = 0

					self:setupGridList(level)
					self:_createEndGrid()

					self._info.xAxis = 0
					self._curOneKeyIndex = self._curOneKeyIndex + 1

					return onekeyFootPrints.footPrints
				end
			end
		end
	end

	return nil
end

function ExpeditionModel:oneKeySweepJumpToLastPoint()
	if self._onekeySweepFootPrintsList and #self._onekeySweepFootPrintsList > 0 then
		local onekeyFootPrints = self._onekeySweepFootPrintsList[#self._onekeySweepFootPrintsList]

		if onekeyFootPrints then
			local level = onekeyFootPrints.level

			if not onekeyFootPrints.footPrints then
				if not onekeyFootPrints.mapGridList then
					self._info.level = level
					self._info.footPrints = onekeyFootPrints.footPrints
					self._info.gridTypeIds = {}

					local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(self._info.level + 1) or {}

					self._info.xAxis = #mapCos
					self._info.yAxis = self:getYAxisByGridIndex(#mapCos, 0)
				end
			end
		end
	end
end

function ExpeditionModel:setOneKeySweepChangeSetId(changesetId)
	self._onekeySweepChangeSetId = changesetId
end

function ExpeditionModel:getOneKeySweepChangeSetId()
	return self._onekeySweepChangeSetId
end

function ExpeditionModel:checkNextLevelGrid()
	if not self._info or not self._info.level or not self._gridList or #self._gridList == 0 then
		return
	end

	local isUnlockNewLevel = false
	local unlockNewLevels = {}
	local nextLevelCo = ExpeditionConfig.instance:getNextLevelCo(self._info.level + 1)

	if nextLevelCo and nextLevelCo.nextLevel then
		for j = 1, #nextLevelCo.nextLevel do
			local nextLvCo = ExpeditionConfig.instance:getNextLevelCo(nextLevelCo.nextLevel[j])

			if MofangModel.instance:getCurLv() >= checknumber(nextLvCo.playerLvLimit) then
				unlockNewLevels[nextLevelCo.nextLevel[j]] = false
			end
		end
	end

	for i = 1, #self._gridList do
		if self._gridList[i].gridType == GridType.END and unlockNewLevels[self._gridList[i].nextLevelId] ~= nil then
			unlockNewLevels[self._gridList[i].nextLevelId] = true
		end
	end

	for k, v in pairs(unlockNewLevels) do
		if not v then
			isUnlockNewLevel = true
		end
	end

	if isUnlockNewLevel then
		local cnt = #self._gridList
		local i = 1

		while i <= cnt do
			if self._gridList[i].gridType == GridType.END then
				table.remove(self._gridList, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end

		self:_createEndGrid()
	end
end

function ExpeditionModel:_calculateAxises(msg, isUpdate)
	if msg.curStep == 0 and msg.map and msg.map.gridMapId == -1 then
		self._info.xAxis = 0
		self._info.yAxis = 0
		self._info.curGridIndex = 0
		self._info.nextXAixs = 0
		self._info.nextYAixs = 0
		self._info.nextEventIndex = 0

		return
	end

	self._info.curGridIndex = msg.curGridIndex
	self._info.xAxis = msg.curStep
	self._info.yAxis = self:getYAxisByGridIndex(msg.curStep, msg.curGridIndex)

	if self._colIndices[msg.curStep + 1] and msg.nextGridIndex >= 0 then
		if isUpdate then
			if ExpeditionTilingModel.instance:hasGetTilingMapInfos() then
				self._info.nextXAixs = msg.curStep + 1
				self._info.nextYAixs = self:getYAxisByGridIndex(self._info.nextXAixs, msg.nextGridIndex)
			else
				self._info.nextXAixs = 0
				self._info.nextYAixs = 0
			end
		elseif msg.map and msg.map.gridMapId ~= -1 then
			self._info.nextXAixs = msg.curStep + 1
			self._info.nextYAixs = self:getYAxisByGridIndex(self._info.nextXAixs, msg.nextGridIndex)
		end
	else
		self._info.nextXAixs = 0
		self._info.nextYAixs = 0
	end

	self._info.nextEventIndex = msg.nextGridIndex
end

function ExpeditionModel:getYAxisByGridIndex(curStep, curGridIndex)
	if not self._colIndices[curStep] then
		return 0
	end

	local yAxis = self._colIndices[curStep][curGridIndex + 1]

	return yAxis or 0
end

function ExpeditionModel:_getGridIndexByYAxis(curStep, yAsix)
	if not self._colIndices[curStep] then
		return 0
	end

	return table.indexof(self._colIndices[curStep], yAsix) or 0
end

function ExpeditionModel:onSelectGrid(xAxis, yAsix, eventIndex)
	self._info.nextXAixs = xAxis
	self._info.nextYAixs = yAsix
	self._info.nextEventIndex = eventIndex
end

function ExpeditionModel:isMaxLevel(currLv)
	local nextLvCo = ExpeditionConfig.instance:getNextLevelCo(currLv)

	return not nextLvCo or not nextLvCo.nextLevel or #nextLvCo.nextLevel == 0
end

function ExpeditionModel:isNeededSelectNextLevel()
	local currLv = self._info.level + 1
	local num = 0
	local nextLvCo = ExpeditionConfig.instance:getNextLevelCo(currLv)

	if nextLvCo then
		for i = 1, #nextLvCo.nextLevel do
			local lvCo = ExpeditionConfig.instance:getNextLevelCo(nextLvCo.nextLevel[i])

			if MofangModel.instance:getCurLv() >= checknumber(lvCo.playerLvLimit) then
				num = num + 1
			end
		end
	end

	return num > 1
end

function ExpeditionModel:setupGridList(level)
	local gridTypeIds = self._info.gridTypeIds

	self._gridList = {}
	self._colIndices = {}

	if not gridTypeIds then
		return
	end

	for i = 1, #gridTypeIds do
		local sortedYAxix = {}
		local startIdx = i % 2
		local gridMapId = gridTypeIds[i].gridMapId
		local minYAxis = math.huge

		for j = 1, #gridMapId do
			local yAxis = tempArr[startIdx + 1][j]

			table.insert(sortedYAxix, yAxis)

			if yAxis < minYAxis then
				minYAxis = yAxis
			end
		end

		table.sort(sortedYAxix, function(x, y)
			return x < y
		end)

		for j = 1, #gridMapId do
			local grid = self:_createGrid(i, sortedYAxix[j], GridType.EVENT)

			grid.eventId = gridMapId[j]
			grid.eventIndex = j - 1

			table.insert(self._gridList, grid)
		end

		self._colIndices[i] = sortedYAxix
	end

	local gridStart = self:_createGrid(0, 0, GridType.START)

	gridStart.eventIndex = 0

	table.insert(self._gridList, 1, gridStart)
end

function ExpeditionModel:isToLevelEnded()
	local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(self._info.level + 1)

	if self._info.xAxis == #mapCos then
		return true
	end

	return false
end

function ExpeditionModel:_createEndGrid()
	local mapCos = ExpeditionConfig.instance:getExpeditionMapCo(self._info.level + 1)
	local isMaxLv = self:isMaxLevel(self._info.level + 1)

	if not isMaxLv and self._info.xAxis == #mapCos then
		local nextLevelCo = ExpeditionConfig.instance:getNextLevelCo(self._info.level + 1)
		local evtIdx = 0

		for j = 1, #nextLevelCo.nextLevel do
			local nextLvCo = ExpeditionConfig.instance:getNextLevelCo(nextLevelCo.nextLevel[j])

			if MofangModel.instance:getCurLv() >= checknumber(nextLvCo.playerLvLimit) then
				local xAxis = #mapCos + 1
				local yAxis = tempArr[(#mapCos + 1) % 2 + 1][j]
				local grid = self:getGridData(xAxis, yAxis, GridType.END)

				if not grid then
					local gridEnd = self:_createGrid(xAxis, yAxis, GridType.END)

					gridEnd.eventIndex = evtIdx
					gridEnd.nextLevelId = nextLevelCo.nextLevel[j]

					table.insert(self._gridList, gridEnd)
				end

				evtIdx = evtIdx + 1
			end
		end
	end
end

function ExpeditionModel:_createGrid(x, y, gridType)
	local grid = {}

	grid.xAxis = x
	grid.yAxis = y
	grid.gridType = gridType

	return grid
end

function ExpeditionModel:isHistoricalPath(x, eventIndex)
	if self._info.footPrints then
		return self._info.footPrints[x + 1] == (eventIndex or 0)
	end
end

function ExpeditionModel:onDoneGrid(msg)
	self:updateData(msg)
	self:_setRewardShow(msg.changeSetId, msg.eventRes)
	self:_setDoubleGetTitle(msg.changeSetId)

	self.isGridDone = not self:isAllFinished()

	GlobalDispatcher:dispatch(GlobalNotify.OnMapUpdate)
end

function ExpeditionModel:_setRewardShow(changeSetId, eventRes)
	local json = require("cjson")
	local t = json.decode(eventRes)
	local mul = checknumber(t.rewardMultiply)

	BattleSettlementModel.instance:setRewardChangeSetId(changeSetId, mul > 1, mul)
end

function ExpeditionModel:getPetState(id)
	if self._info and self._info.petStates then
		return self._info.petStates[id]
	end
end

function ExpeditionModel:isPetDead(id)
	if self._info and self._info.petStates then
		local petState = self._info.petStates[id]

		return petState and petState.hpRate <= 0
	end
end

function ExpeditionModel:getDeadPets()
	local pets

	if self._info and self._info.petStates then
		for k, v in pairs(self._info.petStates) do
			if v.hpRate <= 0 then
				pets = pets or {}

				table.insert(pets, v)
			end
		end
	end

	return pets
end

function ExpeditionModel:reviveAllPets()
	if self._info and self._info.petStates then
		for k, v in pairs(self._info.petStates) do
			if v.hpRate <= 0 then
				v.hpRate = 1
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnReviveAllPets)
end

function ExpeditionModel:getInfo()
	return self._info
end

function ExpeditionModel:getGridList()
	return self._gridList
end

function ExpeditionModel:getBuffIds()
	return self._info.buffIds
end

function ExpeditionModel:getSupportedPetIds()
	return self._info.supportedPets
end

function ExpeditionModel:getSupportedPet(id)
	return self._info.supportedPetsMap[id]
end

function ExpeditionModel:getFootPrints()
	return self._info.footPrints
end

function ExpeditionModel:addBuff(id)
	table.insert(self._info.buffIds, id)
end

function ExpeditionModel:setBattleResult(r)
	self._battleResult = r
end

function ExpeditionModel:getBattleResult(id)
	return self._battleResult
end

function ExpeditionModel:getGridData(xAxis, yAxis, gridType)
	if not self._gridList or not xAxis or not yAxis then
		return
	end

	for i = 1, #self._gridList do
		local gridData = self._gridList[i]

		if gridData.xAxis == xAxis and gridData.yAxis == yAxis and gridData.gridType == gridType then
			return gridData
		end
	end
end

function ExpeditionModel:onNextLevel(level, mapGridList)
	self._info.level = level
	self._info.gridTypeIds = mapGridList
	self._info.footPrints = nil
	self._info.xAxis = 0
	self._info.yAxis = 0
	self._info.nextXAixs = 0
	self._info.nextYAixs = 0
	self._info.nextEventIndex = 0
	self._info.curGridIndex = 0

	self:setRunBattleGridData(nil)
	self:setupGridList(level)
	self:_createEndGrid()
	ExpeditionTilingModel.instance:setTilingMapGrid(self._info.nextXAixs, self._info.nextYAixs, self._info.nextEventIndex)
	ExpeditionTilingModel.instance:resetTilingMapInfos()
	GlobalDispatcher:dispatch(GlobalNotify.OnMapUpdate)
	GlobalDispatcher:dispatch(GlobalNotify.OnExeExpNextLevel)
end

function ExpeditionModel:onNextEvent(xAxis, yAxis, eventIndex)
	if not xAxis or not yAxis then
		return
	end

	if xAxis == 0 and yAxis == 0 then
		return
	end

	self._info.footPrints = self._info.footPrints or {}

	table.insert(self._info.footPrints, self._info.curGridIndex)

	self._info.nextXAixs = 0
	self._info.nextYAixs = 0
	self._info.curGridIndex = 0
	self._info.nextEventIndex = 0

	self:setRunBattleGridData(nil)
	self:_createEndGrid()
	GlobalDispatcher:dispatch(GlobalNotify.OnMapUpdate)
end

function ExpeditionModel:_setUpStatesMap(msg)
	if msg.petStates and #msg.petStates > 0 then
		self._info.petStates = self._info.petStates or {}

		for i = 1, #msg.petStates do
			msg.petStates[i].hpRate = msg.petStates[i].hpRate / 10000
			self._info.petStates[msg.petStates[i].petId] = msg.petStates[i]
		end
	end
end

function ExpeditionModel:_setUpSupportedPetsMap(msg)
	self._info.supportedPetsMap = {}

	if msg.supportedPets then
		for i = 1, #msg.supportedPets do
			self._info.supportedPetsMap[msg.supportedPets[i].petId] = msg.supportedPets[i]
		end
	end
end

function ExpeditionModel:resetSweepsInfo()
	self._sweepChangeSetId = nil
end

function ExpeditionModel:_setDoubleGetTitle(changeSetId)
	local isInTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Expedition)

	isInTime = isInTime or NewhandwelfareController.instance:isInNewPrivilegeTime()

	if isInTime then
		ItemGetController.instance:setTitleType(changeSetId, ItemGetController.TITLE_DOUBLE)
	end
end

ExpeditionModel.instance = ExpeditionModel.New()

return ExpeditionModel
