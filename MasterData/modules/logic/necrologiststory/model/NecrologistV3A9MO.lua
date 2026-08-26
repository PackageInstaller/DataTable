-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A9MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A9MO", package.seeall)

local NecrologistV3A9MO = class("NecrologistV3A9MO", NecrologistStoryGameBaseMO)

function NecrologistV3A9MO:onInit()
	return
end

function NecrologistV3A9MO:onUpdateData()
	local data = self:getData()

	self.itemUnlockDict = {}

	if data.itemUnlockList then
		for _, itemId in ipairs(data.itemUnlockList) do
			self.itemUnlockDict[itemId] = true
		end
	end
end

function NecrologistV3A9MO:onSaveData()
	local data = self:getData()

	data.itemUnlockList = {}

	for itemId, _ in pairs(self.itemUnlockDict) do
		table.insert(data.itemUnlockList, itemId)
	end
end

function NecrologistV3A9MO:setItemUnlock(itemId)
	if self:isItemUnlock(itemId) then
		return
	end

	local config = NecrologistStoryV3A9Config.instance:getItemConfig(itemId)

	if not config then
		return
	end

	local groupId = config.group
	local otherItemId = self:getUnlockItemByGroup(groupId)

	if otherItemId then
		self.itemUnlockDict[otherItemId] = nil
	else
		HeroStoryRpc.instance:sendHeroStoryCommonTaskRequest(NecrologistStoryEnum.TaskParam.V3A9ItemUnlockCount, 1)
	end

	self.itemUnlockDict[itemId] = true

	self:setDataDirty()
end

function NecrologistV3A9MO:isItemUnlock(itemId)
	return self.itemUnlockDict[itemId]
end

function NecrologistV3A9MO:isBaseUnlock(baseId)
	local config = NecrologistStoryV3A9Config.instance:getBaseConfig(baseId)

	if not config or config.preId == 0 then
		return true
	end

	return self:isBaseFinished(config.preId)
end

function NecrologistV3A9MO:isBaseFinished(baseId)
	local config = NecrologistStoryV3A9Config.instance:getBaseConfig(baseId)
	local storyId = config.storyId

	return (self:isStoryFinish(storyId))
end

function NecrologistV3A9MO:getBaseState(baseId)
	local config = NecrologistStoryV3A9Config.instance:getBaseConfig(baseId)
	local isPreUnlock = self:isBaseUnlock(config.preId)

	if not isPreUnlock then
		return NecrologistStoryEnum.V3A2BaseState.Hide
	end

	local isFinished = self:isBaseFinished(baseId)

	if isFinished then
		return NecrologistStoryEnum.V3A2BaseState.Finish
	end

	local isUnlock = self:isBaseUnlock(baseId)

	if isUnlock then
		return NecrologistStoryEnum.V3A2BaseState.Normal
	end

	return NecrologistStoryEnum.V3A2BaseState.Lock
end

function NecrologistV3A9MO:getUnlockItemByGroup(groupId)
	for itemId, _ in pairs(self.itemUnlockDict) do
		local config = NecrologistStoryV3A9Config.instance:getItemConfig(itemId)

		if config.group == groupId then
			return itemId
		end
	end
end

function NecrologistV3A9MO:getResultData()
	local star1Count = 0
	local star2Count = 0

	for itemId, _ in pairs(self.itemUnlockDict) do
		local config = NecrologistStoryV3A9Config.instance:getItemConfig(itemId)

		if config.type == 1 then
			star1Count = star1Count + 1
		elseif config.type == 2 then
			star2Count = star2Count + 1
		end
	end

	local config, star3Count, randomConfig = NecrologistStoryV3A9Config.instance:getItemNewsConfig(self.itemUnlockDict)
	local result = {}

	result.star1Count = math.min(star1Count, 5)
	result.star2Count = math.min(star2Count, 5)
	result.star3Count = math.min(star3Count, 5)
	result.config = config
	result.randomConfig = randomConfig

	return result
end

function NecrologistV3A9MO:getProgress()
	local itemList = NecrologistStoryV3A9Config.instance:getItemList()
	local total = 0
	local cur = 0
	local dict = {}

	for _, v in ipairs(itemList) do
		if not dict[v.group] then
			dict[v.group] = true
			total = total + 1
		end

		if self:isItemUnlock(v.id) then
			cur = cur + 1
		end
	end

	return cur, total
end

function NecrologistV3A9MO:getShowItemList()
	local itemList = NecrologistStoryV3A9Config.instance:getItemList()
	local list = {}
	local dict = {}
	local itemCount = 0

	for i, v in ipairs(itemList) do
		if not dict[v.group] then
			itemCount = itemCount + 1
			dict[v.group] = itemCount

			table.insert(list, v)
		elseif self:isItemUnlock(v.id) then
			list[dict[v.group]] = v
		end
	end

	table.sort(list, SortUtil.keyLower("group"))

	return list
end

return NecrologistV3A9MO
