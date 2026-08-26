-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A4MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A4MO", package.seeall)

local NecrologistV3A4MO = class("NecrologistV3A4MO", NecrologistStoryGameBaseMO)

function NecrologistV3A4MO:onInit()
	return
end

function NecrologistV3A4MO:onUpdateData()
	local data = self:getData()

	self.baseDataDict = {}

	if data.baseFinishList then
		for _, baseId in ipairs(data.baseFinishList) do
			self.baseDataDict[baseId] = true
		end
	end

	self.gameDataDict = {}

	if data.gameDataList then
		for _, gameData in ipairs(data.gameDataList) do
			self:updateGameData(gameData.gameId, gameData)
		end
	end
end

function NecrologistV3A4MO:onSaveData()
	local data = self:getData()

	data.baseFinishList = {}

	for baseId, _ in pairs(self.baseDataDict) do
		table.insert(data.baseFinishList, baseId)
	end

	data.gameDataList = {}

	for _, gameData in pairs(self.gameDataDict) do
		table.insert(data.gameDataList, gameData)
	end
end

function NecrologistV3A4MO:isBaseUnlock(baseId)
	local config = NecrologistStoryV3A4Config.instance:getBaseConfig(baseId)

	if not config then
		return false
	end

	local preBaseId = config.preId

	if preBaseId ~= 0 and not self:isBaseFinish(preBaseId) then
		return false
	end

	return true
end

function NecrologistV3A4MO:isAllBaseFinish()
	local list = NecrologistStoryV3A4Config.instance:getBaseList()

	for _, config in ipairs(list) do
		if not self:isBaseFinish(config.id) then
			return false
		end
	end

	return true
end

function NecrologistV3A4MO:isBaseFinish(baseId)
	return self.baseDataDict[baseId]
end

function NecrologistV3A4MO:setBaseFinish(baseId)
	if self:isBaseFinish(baseId) then
		return
	end

	self.baseDataDict[baseId] = true

	self:setDataDirty()
end

function NecrologistV3A4MO:getGameData(gameId)
	local data = self.gameDataDict[gameId]

	if not data then
		data = {
			gameId = gameId,
			nodeDict = {}
		}
		self.gameDataDict[gameId] = data
	end

	return data
end

function NecrologistV3A4MO:getGameNodePutItemList(gameId, nodeId)
	local data = self:getGameData(gameId)

	return data.nodeDict[nodeId] or {}
end

function NecrologistV3A4MO:getGameNodeItemList(gameId, nodeId)
	local config = NecrologistStoryV3A4Config.instance:getGameNodeConfig(gameId, nodeId)
	local nodeSlot = config.nodeSlot
	local list = string.splitToNumber(config.nodeItemId, "#") or {}
	local fixCount = #list
	local putItemList = self:getGameNodePutItemList(gameId, nodeId)

	tabletool.addValues(list, putItemList)

	local ret = {}

	for i = 1, nodeSlot do
		ret[i] = list[i]
	end

	return ret, fixCount
end

function NecrologistV3A4MO:updateGameData(gameId, gameData)
	local data = self:getGameData(gameId)

	data.nodeDict = {}

	if gameData.nodeDict then
		for nodeId, itemList in pairs(gameData.nodeDict) do
			data.nodeDict[nodeId] = itemList
		end
	end
end

function NecrologistV3A4MO:isCurrentGameNodeIndex(gameId, nodeId, index)
	local preId = nodeId - 1

	if preId > 0 then
		local config = NecrologistStoryV3A4Config.instance:getGameNodeConfig(gameId, preId)
		local nodeSlot = config.nodeSlot
		local itemList = self:getGameNodeItemList(gameId, preId)

		if nodeSlot > #itemList then
			return false
		else
			local pointCount = self:getItemPointCount(gameId, preId)

			if not config.nodePoint then
				if pointCount ~= config.nodePoint then
					return false
				end
			end
		end
	end

	local itemList = self:getGameNodeItemList(gameId, nodeId)

	return index > #itemList
end

function NecrologistV3A4MO:putGameNodeItem(gameId, nodeId, itemId)
	local config = NecrologistStoryV3A4Config.instance:getGameNodeConfig(gameId, nodeId)
	local nodeSlot = config.nodeSlot
	local itemList = self:getGameNodeItemList(gameId, nodeId)

	if nodeSlot <= #itemList then
		return
	end

	local list = self:getGameNodePutItemList(gameId, nodeId)
	local fixedCount = #itemList - #list

	table.insert(list, itemId)

	local data = self:getGameData(gameId)

	data.nodeDict[nodeId] = list

	self:setDataDirty()

	return true, #list + fixedCount
end

function NecrologistV3A4MO:clearGameNodeItemList(gameId, nodeId)
	local oldList = self:getGameNodePutItemList(gameId, nodeId)

	if not oldList or #oldList == 0 then
		return
	end

	local data = self:getGameData(gameId)

	data.nodeDict[nodeId] = {}

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A4_OnDataUpdate)
	self:setDataDirty()
end

function NecrologistV3A4MO:getItemPointCount(gameId, nodeId)
	local itemList = self:getGameNodeItemList(gameId, nodeId)
	local count = 0

	for _, itemId in ipairs(itemList) do
		local itemConfig = NecrologistStoryV3A4Config.instance:getItemConfig(itemId)

		if itemConfig then
			count = count + itemConfig.point
		end
	end

	return count
end

function NecrologistV3A4MO:checkGameIsFinish(gameId)
	local data = self:getGameData(gameId)

	if not data then
		return false
	end

	local list = NecrologistStoryV3A4Config.instance:getGameNodeList(gameId)

	for i, v in ipairs(list) do
		local itemPointCount = self:getItemPointCount(gameId, v.nodeId)

		if not v.nodePoint then
			if itemPointCount ~= v.nodePoint then
				return false
			end
		end
	end

	return true
end

function NecrologistV3A4MO:resetGame(gameId)
	self.gameDataDict[gameId] = nil

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A4_OnDataUpdate)
	self:setDataDirty()
end

return NecrologistV3A4MO
