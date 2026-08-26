-- chunkname: @modules/logic/partygamelobby/model/PartyGameTrialPlayModel.lua

module("modules.logic.partygamelobby.model.PartyGameTrialPlayModel", package.seeall)

local PartyGameTrialPlayModel = class("PartyGameTrialPlayModel", BaseModel)

function PartyGameTrialPlayModel:getNeedAllGameNum()
	if self.needAllGameNum == nil then
		self.needAllGameNum = 0

		for _, count in pairs(PartyGameTrialPlayEnum.selectCountMap) do
			self.needAllGameNum = self.needAllGameNum + count
		end
	end

	return self.needAllGameNum
end

function PartyGameTrialPlayModel:setOneTrialGameId(gameId, playerCount)
	if self._trialPlayGameIds == nil then
		self._trialPlayGameIds = {}
	end

	playerCount = playerCount or PartyGameTrialPlayEnum.trialPlayerNumStep[1]

	if self._trialPlayGameIds[playerCount] == nil then
		self._trialPlayGameIds[playerCount] = {}
	else
		tabletool.clear(self._trialPlayGameIds[playerCount])
	end

	table.insert(self._trialPlayGameIds[playerCount], gameId)
end

function PartyGameTrialPlayModel:recordTrialPlayGame(gameIds)
	local needGameNum = self:getNeedAllGameNum()

	if #gameIds ~= needGameNum then
		logError("gameIds num error")
	end

	if self._trialPlayGameIds == nil then
		self._trialPlayGameIds = {}
	end

	local index = 1

	for _, playerCount in ipairs(PartyGameTrialPlayEnum.trialPlayerNumStep) do
		if self._trialPlayGameIds[playerCount] == nil then
			self._trialPlayGameIds[playerCount] = {}
		else
			tabletool.clear(self._trialPlayGameIds[playerCount])
		end

		local count = PartyGameTrialPlayEnum.selectCountMap[playerCount]

		for _ = 1, count do
			table.insert(self._trialPlayGameIds[playerCount], gameIds[index])

			index = index + 1
		end

		table.insert(self._trialPlayGameIds[playerCount], PartyGameEnum.GameId.CardDrop)
	end
end

function PartyGameTrialPlayModel:clearTrialGame()
	self._trialPlayGameIds = nil
end

function PartyGameTrialPlayModel:removeCurrentAndGetNextGameId(gameResult)
	if self._trialPlayGameIds == nil then
		return false, nil, false
	end

	local nextGameId
	local lastGameCount = 0
	local nextGameCount = 0
	local foundIndex = -1
	local foundPlayerCount = -1

	for _, playerCount in ipairs(PartyGameTrialPlayEnum.trialPlayerNumStep) do
		local list = self._trialPlayGameIds[playerCount]

		if list ~= nil then
			for i, gameId in ipairs(list) do
				if gameId == gameResult.GameId then
					foundIndex = i
					foundPlayerCount = playerCount
					lastGameCount = playerCount

					break
				end
			end
		end

		if foundIndex ~= -1 then
			break
		end
	end

	if foundIndex == -1 then
		return false, nil, false
	end

	local currentList = self._trialPlayGameIds[foundPlayerCount]

	table.remove(currentList, foundIndex)

	if #currentList > 0 then
		nextGameId = currentList[1]
		nextGameCount = foundPlayerCount
	else
		for i, playerCount in ipairs(PartyGameTrialPlayEnum.trialPlayerNumStep) do
			if lastGameCount == playerCount and i < #PartyGameTrialPlayEnum.trialPlayerNumStep then
				nextGameCount = PartyGameTrialPlayEnum.trialPlayerNumStep[i + 1]

				break
			end
		end

		if nextGameCount ~= 0 and self._trialPlayGameIds[nextGameCount] ~= nil and #self._trialPlayGameIds[nextGameCount] > 0 then
			nextGameId = self._trialPlayGameIds[nextGameCount][1]
		end
	end

	if nextGameId ~= nil then
		return true, nextGameId, lastGameCount ~= nextGameCount
	else
		return false, nil, false
	end
end

function PartyGameTrialPlayModel:updateSelectTrialGameIdByPlayerCount(gameId, playerCount)
	local startIndex, endIndex = self:getSelectGameIndexRange(playerCount)

	self:updateSelectTrialGameIdFixIndex(gameId, nil, false, startIndex, endIndex)
end

function PartyGameTrialPlayModel:updateSelectTrialGameIdFixIndex(gameId, index, needRest, startIndex, endIndex)
	if self._allSelectGameIds == nil then
		self._allSelectGameIds = {}

		for i = 1, self:getNeedAllGameNum() do
			self._allSelectGameIds[i] = -1
		end
	end

	if index == nil then
		for i = startIndex, endIndex do
			if self._allSelectGameIds[i] == gameId then
				index = i

				break
			end
		end
	end

	local forceSet = false

	if index == nil or index < startIndex or endIndex < index then
		local needLast = true

		for i = startIndex, endIndex do
			if self._allSelectGameIds[i] == nil or self._allSelectGameIds[i] == -1 then
				index = i
				needLast = false

				break
			end
		end

		if needLast then
			index = endIndex
			forceSet = true
		end
	end

	if self._allSelectGameIds[index] == nil or self._allSelectGameIds[index] == -1 or needRest or forceSet then
		self._allSelectGameIds[index] = gameId
	elseif self._allSelectGameIds[index] == gameId then
		self._allSelectGameIds[index] = -1
	end
end

function PartyGameTrialPlayModel:updateSelectTrialGameId(gameId, index, needRest)
	self:updateSelectTrialGameIdFixIndex(gameId, index, needRest, 1, self:getNeedAllGameNum())
end

function PartyGameTrialPlayModel:getSelectTrialGameIndex(gameId)
	if self._allSelectGameIds ~= nil then
		for i = 1, tabletool.len(self._allSelectGameIds) do
			if gameId == self._allSelectGameIds[i] then
				return i
			end
		end
	end

	return nil
end

function PartyGameTrialPlayModel:getSelectGameId(index)
	return self._allSelectGameIds and self._allSelectGameIds[index]
end

function PartyGameTrialPlayModel:getAllSelectGameIds()
	return self._allSelectGameIds
end

function PartyGameTrialPlayModel:canEnterTrial()
	if self._allSelectGameIds == nil then
		return false
	end

	local totalCount = self:getNeedAllGameNum()

	for i = 1, totalCount do
		local value = self._allSelectGameIds[i]

		if value == nil or value == -1 then
			return false
		end
	end

	return true
end

function PartyGameTrialPlayModel:getSelectGameCount()
	local count = 0

	if self._allSelectGameIds ~= nil then
		for i = 1, self:getNeedAllGameNum() do
			if self._allSelectGameIds[i] ~= nil and self._allSelectGameIds[i] ~= -1 then
				count = count + 1
			end
		end
	end

	return count
end

function PartyGameTrialPlayModel:getSelectGameCountByPlayerNumber(playerCount)
	local count = 0

	if self._allSelectGameIds ~= nil then
		local startIndex, endIndex = self:getSelectGameIndexRange(playerCount)

		for i = startIndex, endIndex do
			if self._allSelectGameIds[i] ~= nil and self._allSelectGameIds[i] ~= -1 then
				count = count + 1
			end
		end
	end

	return count
end

function PartyGameTrialPlayModel:getSelectGameIndexRange(playerCount)
	local startIndex = 1
	local endIndex = 0

	for i = 1, #PartyGameTrialPlayEnum.trialPlayerNumStep do
		local count = PartyGameTrialPlayEnum.selectCountMap[PartyGameTrialPlayEnum.trialPlayerNumStep[i]]

		endIndex = endIndex + count

		if PartyGameTrialPlayEnum.trialPlayerNumStep[i] == playerCount then
			break
		end

		startIndex = startIndex + count
	end

	return startIndex, endIndex
end

function PartyGameTrialPlayModel:clearSelectGameIds()
	if self._allSelectGameIds then
		self._allSelectGameIds = nil
	end
end

function PartyGameTrialPlayModel:getPlayerCountByIndex(index)
	local totalCount = self:getNeedAllGameNum()

	if totalCount < index then
		return nil
	end

	local playerCount = 0

	for i = 1, #PartyGameTrialPlayEnum.trialPlayerNumStep do
		playerCount = playerCount + PartyGameTrialPlayEnum.selectCountMap[PartyGameTrialPlayEnum.trialPlayerNumStep[i]]

		if index <= playerCount then
			return PartyGameTrialPlayEnum.trialPlayerNumStep[i]
		end
	end

	return nil
end

PartyGameTrialPlayModel.instance = PartyGameTrialPlayModel.New()

return PartyGameTrialPlayModel
