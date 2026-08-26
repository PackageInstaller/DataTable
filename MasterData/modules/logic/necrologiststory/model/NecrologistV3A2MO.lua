-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A2MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A2MO", package.seeall)

local NecrologistV3A2MO = class("NecrologistV3A2MO", NecrologistStoryGameBaseMO)

function NecrologistV3A2MO:onInit()
	return
end

function NecrologistV3A2MO:onUpdateData()
	local data = self:getData()

	self.itemUnlockDict = {}

	if data.itemUnlockList then
		for _, itemId in ipairs(data.itemUnlockList) do
			self.itemUnlockDict[itemId] = true
		end
	end
end

function NecrologistV3A2MO:onSaveData()
	local data = self:getData()

	data.itemUnlockList = {}

	for itemId, _ in pairs(self.itemUnlockDict) do
		table.insert(data.itemUnlockList, itemId)
	end
end

function NecrologistV3A2MO:setItemUnlock(itemId)
	if self:isItemUnlock(itemId) then
		return
	end

	self.itemUnlockDict[itemId] = true

	self:setDataDirty()
	HeroStoryRpc.instance:sendHeroStoryCommonTaskRequest(NecrologistStoryEnum.TaskParam.V3A2ItemUnlockCount, 1)
end

function NecrologistV3A2MO:isItemUnlock(itemId)
	return self.itemUnlockDict[itemId]
end

function NecrologistV3A2MO:isBaseUnlock(baseId)
	local config = NecrologistStoryV3A2Config.instance:getBaseConfig(baseId)

	if not config or config.preId == 0 then
		return true
	end

	return self:isBaseFinished(config.preId)
end

function NecrologistV3A2MO:isBaseFinished(baseId)
	local config = NecrologistStoryV3A2Config.instance:getBaseConfig(baseId)
	local storyId = config.storyId

	return (self:isStoryFinish(storyId))
end

function NecrologistV3A2MO:getBaseState(baseId)
	local config = NecrologistStoryV3A2Config.instance:getBaseConfig(baseId)
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

return NecrologistV3A2MO
