-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiGameModel.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiGameModel", package.seeall)

local YeShuMeiGameModel = class("YeShuMeiGameModel", BaseModel)

function YeShuMeiGameModel:onInit()
	self:reInit()
end

function YeShuMeiGameModel:reInit()
	self._curGameIdStr = nil
	self._curGameId = nil
	self._curLevelIndex = nil

	self:_onStart()
end

function YeShuMeiGameModel:initGameData(gameId)
	self:clear()

	self._gameConfig = YeShuMeiConfig.instance:getYeShuMeiGameConfigById(gameId)
	self._curGameIdStr = self._gameConfig and self._gameConfig.gameId

	self:_initLevel()

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function YeShuMeiGameModel:_initLevel()
	if self._curGameIdStr ~= nil then
		self._gameIdList = string.splitToNumber(self._curGameIdStr, "#")
	end

	self._level = {}
	self._curLevelIndex = 1

	for index, _ in ipairs(self._gameIdList) do
		self._level[index] = false
	end
end

function YeShuMeiGameModel:_initGameMo(gameId)
	self._gameMo = YeShuMeiGameMo.create(gameId)

	local gamedata = YeShuMeiConfig.instance:getYeShuMeiLevelDataByLevelId(gameId)

	self._gameMo:init(gamedata)
	self._gameMo:setOrderIndex()
end

function YeShuMeiGameModel:_onStart()
	self._isStart = false
	self._isShadowVible = false
	self._isReView = false
	self._isWrong = false
	self._curStartPointId = nil
	self._curOrder = nil
	self._lastLineCount = 0
	self._correctLineCount = 0
	self._needCheckPointList = nil
	self._lines = {}
	self._lastProcessedPointId = nil
	self._pointInListHash = {}
end

function YeShuMeiGameModel:getStartState()
	return self._isStart
end

function YeShuMeiGameModel:setStartState(state)
	self._isStart = state
end

function YeShuMeiGameModel:getCurGameId()
	return self._curGameId
end

function YeShuMeiGameModel:getGameMo()
	return self._gameMo
end

function YeShuMeiGameModel:getCurGameConfig()
	return self._gameConfig
end

function YeShuMeiGameModel:getAllPoint()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getAllPoint()
end

function YeShuMeiGameModel:getPointById(id)
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getPointById(id)
end

function YeShuMeiGameModel:setReview(state)
	self._isReView = state
end

function YeShuMeiGameModel:getReView()
	return self._isReView
end

function YeShuMeiGameModel:insertPointList(pointId, isLastPoint)
	self._needCheckPointList = self._needCheckPointList or {}

	local pointInList = false

	for _, id in ipairs(self._needCheckPointList) do
		if id == pointId then
			pointInList = true

			break
		end
	end

	if pointInList and not isLastPoint then
		return false
	end

	if #self._needCheckPointList == 0 then
		local startIds = self:getStartPointIds()

		for _, id in ipairs(startIds) do
			if id == pointId then
				self._curOrder = self._gameMo:getCurrentStartOrder(pointId)
				self._curStartPointId = pointId
			end
		end
	end

	if not self._curOrder then
		return
	end

	if not tabletool.indexOf(self._needCheckPointList, pointId) then
		table.insert(self._needCheckPointList, pointId)

		local count = #self._needCheckPointList

		if count == #self._curOrder and isLastPoint and not self._isWrong then
			self._level[self._curLevelIndex] = true
		end

		return true
	end

	local count = #self._needCheckPointList

	if isLastPoint and count + 1 == #self._curOrder and not self._isWrong then
		self._level[self._curLevelIndex] = true

		table.insert(self._needCheckPointList, pointId)

		return true
	end

	return false
end

function YeShuMeiGameModel:getNeedCheckPointList()
	return self._needCheckPointList
end

function YeShuMeiGameModel:checkConnectionCorrect()
	if not self._curOrder or #self._curOrder < 1 then
		return
	end

	if #self._needCheckPointList > #self._curOrder then
		self._isWrong = true

		return false
	end

	for i = 1, #self._needCheckPointList do
		if self._needCheckPointList[i] ~= self._curOrder[i] then
			self._isWrong = true

			return false
		end
	end

	self._curStartPointId = self._needCheckPointList[#self._needCheckPointList]

	return true
end

function YeShuMeiGameModel:getConfigStartPointIds()
	if self._gameMo then
		return (self._gameMo:getStartPointIds())
	end
end

function YeShuMeiGameModel:getStartPointIds()
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

function YeShuMeiGameModel:checkLineExist(beginPointId, endPointId)
	local exist = false

	if self._lines and #self._lines > 0 then
		for _, lineMo in ipairs(self._lines) do
			exist = lineMo:havePoint(beginPointId, endPointId)

			if exist then
				break
			end
		end

		return exist
	end

	return false
end

function YeShuMeiGameModel:getLineMoByPointId(beginPointId, endPointId)
	if self._lines and #self._lines > 0 then
		for _, lineMo in ipairs(self._lines) do
			if lineMo:havePoint(beginPointId, endPointId) then
				return lineMo
			end
		end
	end
end

function YeShuMeiGameModel:getLineMoByErrorId(errorId)
	if self._lines and #self._lines > 0 then
		for _, lineMo in ipairs(self._lines) do
			if lineMo:checkHaveErrorId(errorId) then
				return lineMo
			end
		end
	end
end

function YeShuMeiGameModel:checkDiffPosAndConnection(posX, posY)
	self._pointInListHash = self._pointInListHash or {}
	self._needCheckPointList = self._needCheckPointList or {}
	self._lastProcessedPointId = self._lastProcessedPointId or nil

	local targetPoint
	local pointlist = self:getAllPoint()

	for _, point in ipairs(pointlist) do
		if point and point:isInCanConnectionRange(posX, posY) then
			targetPoint = point

			break
		end
	end

	if not targetPoint then
		self._lastProcessedPointId = nil

		return false
	end

	local targetPointId = targetPoint:getId()

	if self._curOrder then
		if not #self._curOrder then
			local listLen = 0

			if listLen > 0 then
				if not self._curOrder[listLen] then
					local lastPointId
					local isInList = self._pointInListHash[targetPointId]
					local isSameAsLast = self._lastProcessedPointId == targetPointId
					local isFirstPoint = #self._needCheckPointList == 0
					local isLastPoint = targetPointId == lastPointId

					if not (isFirstPoint and not isInList or not isInList and not isSameAsLast or isLastPoint and not isSameAsLast) then
						return false
					end

					local insertSuccess = self:insertPointList(targetPointId, isLastPoint)

					if not insertSuccess then
						return false
					end

					self._pointInListHash[targetPointId] = true
					self._lastProcessedPointId = targetPointId

					if self:checkConnectionCorrect() then
						targetPoint:setState(YeShuMeiEnum.StateType.Connect)
					else
						targetPoint:setState(YeShuMeiEnum.StateType.Error)

						self._isWrong = true
					end

					return true
				end
			end
		end
	end
end

function YeShuMeiGameModel:checkCorrectConnection()
	if self._isWrong then
		self:resetToLastConnection()
	elseif not self:checkHaveNewConnection() then
		self:resetToLastConnection()
	else
		self._lastLineCount = self._correctLineCount
	end
end

function YeShuMeiGameModel:checkHaveNewConnection()
	if self._correctLineCount > self._lastLineCount then
		return true
	end

	return false
end

function YeShuMeiGameModel:resetToLastConnection()
	self._needCheckPointList = self._needCheckPointList or {}

	local pointCount = #self._needCheckPointList

	if pointCount > 1 then
		local validList = {}
		local find = false

		for _, pointId in ipairs(self._needCheckPointList) do
			table.insert(validList, pointId)

			if pointId == self._curStartPointId then
				find = true

				break
			end
		end

		self._needCheckPointList = find and validList or {}
	else
		self._needCheckPointList = {}
		self._curStartPointId = nil
	end

	self._pointInListHash = {}

	for _, pointId in ipairs(self._needCheckPointList) do
		self._pointInListHash[pointId] = true
	end

	self._isWrong = false

	if pointCount > 0 then
		self._lastProcessedPointId = self._needCheckPointList[#self._needCheckPointList] or nil
	end
end

function YeShuMeiGameModel:clearConnection()
	if self._needCheckPointList and #self._needCheckPointList > 0 then
		for index, pointId in ipairs(self._needCheckPointList) do
			local point = self:getPointById(pointId)

			point:clearPoint()
		end
	end

	self._isWrong = false
end

function YeShuMeiGameModel:addLines(beginPointId, endPointId)
	if self._lines == nil then
		self._lines = {}
	end

	local newLineMo = YeShuMeiLineMo.New(#self._lines + 1)

	newLineMo:updatePoint(beginPointId, endPointId)

	if self._isWrong then
		newLineMo:setState(YeShuMeiEnum.StateType.Error)
	else
		self._correctLineCount = (self._correctLineCount or 0) + 1
	end

	local isDuplicate = false

	for _, existingLine in ipairs(self._lines) do
		if existingLine:havePoint(beginPointId, endPointId) then
			isDuplicate = true

			break
		end
	end

	if not isDuplicate then
		table.insert(self._lines, newLineMo)
	end

	return newLineMo
end

function YeShuMeiGameModel:deleteLines(idList)
	if not self._lines then
		return
	end

	if not idList then
		tabletool.clear(self._lines)

		self._lines = nil
	else
		for _, id in ipairs(idList) do
			for index, lineMo in ipairs(self._lines) do
				if lineMo.id == id then
					table.remove(self._lines, index)
				end
			end
		end
	end
end

function YeShuMeiGameModel:getCurStartPointAfter()
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

function YeShuMeiGameModel:getWrong()
	return self._isWrong
end

function YeShuMeiGameModel:getCurStartPointMo()
	if self._curStartPointId then
		return self:getPointById(self._curStartPointId)
	end
end

function YeShuMeiGameModel:getCurrentLevelIndex()
	return self._curLevelIndex
end

function YeShuMeiGameModel:getCurrentLevelComplete()
	return self._level[self._curLevelIndex]
end

function YeShuMeiGameModel:getCompleteLevelNum()
	local num = 0

	for index, value in ipairs(self._level) do
		if value then
			num = num + 1
		end
	end

	return num
end

function YeShuMeiGameModel:checkHaveNextLevel()
	local index = self._curLevelIndex + 1
	local gameId = self._gameIdList[index]
	local gamedata = YeShuMeiConfig.instance:getYeShuMeiLevelDataByLevelId(gameId)

	if gamedata then
		return true
	else
		return false
	end
end

function YeShuMeiGameModel:checkNeedCheckListEmpty()
	return self._needCheckPointList and #self._needCheckPointList == 0 or true
end

function YeShuMeiGameModel:getCurStartPointId()
	return self._curStartPointId
end

function YeShuMeiGameModel:setNextLevelGame()
	self._curLevelIndex = self._curLevelIndex + 1

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function YeShuMeiGameModel:destroy()
	self:clear()

	if self._gameMo then
		self._gameMo:destroy()

		self._gameMo = nil
	end
end

YeShuMeiGameModel.instance = YeShuMeiGameModel.New()

return YeShuMeiGameModel
