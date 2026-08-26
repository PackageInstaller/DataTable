-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianGameModel.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianGameModel", package.seeall)

local LuSiJianGameModel = class("LuSiJianGameModel", BaseModel)

function LuSiJianGameModel:onInit()
	self:reInit()
end

function LuSiJianGameModel:reInit()
	self._curGameIdStr = nil
	self._curGameId = nil
	self._curLevelIndex = nil

	self:_onStart()

	self._showPoint = false
end

function LuSiJianGameModel:initGameData(gameId)
	self:clear()

	self._gameConfig = LuSiJianConfig.instance:getLuSiJianGameConfigById(gameId)
	self._curGameIdStr = self._gameConfig and self._gameConfig.gameId

	self:_initLevel()

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function LuSiJianGameModel:testGameData(gameId)
	self:clear()

	self._gameIdList = {
		gameId
	}
	self._level = {}
	self._curLevelIndex = 1

	local gameId = self._gameIdList[self._curLevelIndex]

	for index, _ in ipairs(self._gameIdList) do
		self._level[index] = false
	end

	self:_initGameMo(gameId)
	self:_onStart()
end

function LuSiJianGameModel:_initLevel()
	if self._curGameIdStr ~= nil then
		self._gameIdList = string.splitToNumber(self._curGameIdStr, "#")
	end

	self._level = {}
	self._curLevelIndex = 1

	for index, _ in ipairs(self._gameIdList) do
		self._level[index] = false
	end
end

function LuSiJianGameModel:_initGameMo(gameId)
	self._gameMo = LuSiJianGameMo.New(gameId)

	local gamedata = LuSiJianConfig.instance:getLuSiJianLevelDataByLevelId(gameId)

	self._gameMo:init(gamedata)
	self._gameMo:setOrderIndex()
end

function LuSiJianGameModel:_onStart()
	self._isStart = false
	self._curStartPointId = nil
	self._curOrder = nil
	self._needCheckPointList = nil
	self._lastProcessedPointId = nil
	self._pointInListHash = {}
	self._isSeqError = false
	self._insertLastPoint = false
end

function LuSiJianGameModel:getStartState()
	return self._isStart
end

function LuSiJianGameModel:setStartState(state)
	self._isStart = state
end

function LuSiJianGameModel:getCurGameId()
	return self._curGameId
end

function LuSiJianGameModel:getGameMo()
	return self._gameMo
end

function LuSiJianGameModel:getCurGameConfig()
	return self._gameConfig
end

function LuSiJianGameModel:getAllPoint()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getAllPoint()
end

function LuSiJianGameModel:getPointById(id)
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getPointById(id)
end

function LuSiJianGameModel:rebuildOrderIndexMap()
	self._idToIndexMap = {}

	if self._curOrder then
		for i, id in ipairs(self._curOrder) do
			self._idToIndexMap[id] = self._idToIndexMap[id] or i
		end
	end
end

function LuSiJianGameModel:checkAndFixDirection(nextPointId)
	local curOrder = self._curOrder
	local lastPointId = self._needCheckPointList[1]
	local idx1 = self._idToIndexMap[lastPointId]
	local idx2 = self._idToIndexMap[nextPointId]
	local reverseList = self:getReverseOrderDeep(curOrder)
	local skipReverse = 9999
	local rIdx1 = 1
	local rIdx2 = tabletool.indexOf(reverseList, nextPointId)

	if rIdx2 and rIdx1 < rIdx2 then
		skipReverse = rIdx2 - rIdx1 - 1
	end

	local tolerance = LuSiJianEnum.FaultTolerance

	if skipReverse < ((idx1 and idx2 and idx1 < idx2 or nil) and idx2 - idx1 - 1) and skipReverse <= tolerance then
		self._curOrder = reverseList

		self:rebuildOrderIndexMap()
	end
end

function LuSiJianGameModel:getReverseOrderDeep(orderList)
	local newOrder = {}
	local len = #orderList

	if len == 0 then
		return {}
	end

	table.insert(newOrder, orderList[1])

	local isLoop = orderList[1] == orderList[len]

	if isLoop then
		for i = len - 1, 2, -1 do
			table.insert(newOrder, orderList[i])
		end

		table.insert(newOrder, orderList[len])
	else
		for i = len, 2, -1 do
			table.insert(newOrder, orderList[i])
		end
	end

	return newOrder
end

function LuSiJianGameModel:insertPointList(pointId, isLastPoint)
	if not self._needCheckPointList then
		self._needCheckPointList = {}
		self._pointInListHash = {}
	end

	if #self._needCheckPointList == 0 then
		local startIds = self:getStartPointIds()

		for _, id in ipairs(startIds) do
			if id == pointId then
				self._curOrder = self._gameMo:getCurrentStartOrder(pointId)
				self._curStartPointId = pointId
				self._curSkipCount = 0

				self:rebuildOrderIndexMap()
				table.insert(self._needCheckPointList, pointId)

				self._pointInListHash[pointId] = true

				return true
			end
		end

		return false
	end

	if not self._curOrder then
		return false
	end

	if self._pointInListHash[pointId] and not isLastPoint then
		return false
	end

	if #self._needCheckPointList == 1 then
		self:checkAndFixDirection(pointId)
	end

	local lastAddedId = self._needCheckPointList[#self._needCheckPointList]
	local lastIdx = self._idToIndexMap[lastAddedId]
	local curIdx = self._idToIndexMap[pointId]

	if isLastPoint then
		curIdx = #self._curOrder
	end

	if not lastIdx or not curIdx then
		return false
	end

	local diff = curIdx - lastIdx

	if diff <= 0 then
		return false
	end

	local stepSkipCount = diff - 1

	self._curSkipCount = self._curSkipCount or 0

	if self._curSkipCount + stepSkipCount > LuSiJianEnum.FaultTolerance then
		self._isSeqError = true

		return false
	end

	self._curSkipCount = self._curSkipCount + stepSkipCount

	table.insert(self._needCheckPointList, pointId)

	if isLastPoint then
		self._insertLastPoint = true
	end

	self._pointInListHash[pointId] = true

	return true
end

function LuSiJianGameModel:checkDiffPosAndConnection(posX, posY)
	self._pointInListHash = self._pointInListHash or {}
	self._needCheckPointList = self._needCheckPointList or {}

	local pointlist = self:getAllPoint()
	local targetPoint
	local minDistSq = 99999999

	for i = 1, #pointlist do
		local point = pointlist[i]

		if point and point:isInCanConnectionRange(posX, posY) then
			local pId = point:getId()
			local isConnected = self._pointInListHash[pId]

			if (isConnected and self._curOrder and #self._curOrder > 0 and pId == self._curOrder[#self._curOrder] or nil) and true then
				local dx = point.posX - posX
				local dy = point.posY - posY
				local dSq = dx * dx + dy * dy

				if dSq < minDistSq then
					minDistSq = dSq
					targetPoint = point
				end
			end
		end
	end

	if not targetPoint then
		self._lastProcessedPointId = nil

		return false
	end

	local targetPointId = targetPoint:getId()

	if self._lastProcessedPointId == targetPointId then
		return true
	end

	local insertSuccess = self:insertPointList(targetPointId, (self._curOrder and #self._curOrder > 0 or nil) and targetPointId == self._curOrder[#self._curOrder])

	if insertSuccess then
		self._lastProcessedPointId = targetPointId

		targetPoint:setState(LuSiJianEnum.StateType.Connect)

		return true
	end

	return false
end

function LuSiJianGameModel:getNeedCheckPointList()
	return self._needCheckPointList
end

function LuSiJianGameModel:getConfigStartPointIds()
	if self._gameMo then
		return (self._gameMo:getStartPointIds())
	end
end

function LuSiJianGameModel:getStartPointIds()
	if self._curStartPointId then
		return {
			self._curStartPointId
		}
	end

	if self._gameMo then
		local startIdList = self._gameMo:getStartPointIds()

		if not self._curStartPointId then
			return startIdList
		end
	end
end

function LuSiJianGameModel:clearCheckPointList()
	if self._needCheckPointList and #self._needCheckPointList > 0 then
		self._needCheckPointList = {}
		self._pointInListHash = {}
	end

	self._isSeqError = false
	self._insertLastPoint = false
end

function LuSiJianGameModel:getCurStartPointAfter()
	local list = {}

	if not self._curStartPointId then
		return self._needCheckPointList
	end

	if self._curStartPointId and self._needCheckPointList and #self._needCheckPointList > 0 then
		local foundIndex

		for index, value in ipairs(self._needCheckPointList) do
			if value == self._curStartPointId then
				foundIndex = index
			end

			if foundIndex and foundIndex < index then
				table.insert(list, value)
			end
		end
	end

	return list
end

function LuSiJianGameModel:getWrong()
	return self._isSeqError
end

function LuSiJianGameModel:getCurStartPointMo()
	if self._curStartPointId then
		return self:getPointById(self._curStartPointId)
	end
end

function LuSiJianGameModel:getCurrentLevelIndex()
	return self._curLevelIndex
end

function LuSiJianGameModel:getCurrentLevelComplete()
	return self._level[self._curLevelIndex]
end

function LuSiJianGameModel:getCompleteLevelNum()
	local num = 0

	for index, value in ipairs(self._level) do
		if value then
			num = num + 1
		end
	end

	return num
end

function LuSiJianGameModel:checkHaveNextLevel()
	local index = self._curLevelIndex + 1
	local gameId = self._gameIdList[index]
	local gamedata = LuSiJianConfig.instance:getLuSiJianLevelDataByLevelId(gameId)

	if gamedata then
		return true
	else
		return false
	end
end

function LuSiJianGameModel:checkNeedCheckListEmpty()
	if not self._needCheckPointList then
		return true
	else
		return #self._needCheckPointList == 0
	end
end

function LuSiJianGameModel:checkPointFinish()
	if not self._curOrder then
		return
	end

	local targetCount = #self._curOrder - LuSiJianEnum.FaultTolerance
	local currentCount = #self._needCheckPointList

	return targetCount <= currentCount and self._insertLastPoint
end

function LuSiJianGameModel:getCurStartPointId()
	return self._curStartPointId
end

function LuSiJianGameModel:setNextLevelGame()
	self._curLevelIndex = self._curLevelIndex + 1

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function LuSiJianGameModel:_isShowPoint()
	return self._showPoint
end

function LuSiJianGameModel:setShowPointState(state)
	self._showPoint = state
end

function LuSiJianGameModel:destroy()
	self:clear()

	if self._gameMo then
		self._gameMo:destroy()

		self._gameMo = nil
	end
end

LuSiJianGameModel.instance = LuSiJianGameModel.New()

return LuSiJianGameModel
