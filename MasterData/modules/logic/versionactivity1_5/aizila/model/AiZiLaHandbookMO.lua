-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaHandbookMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookMO", package.seeall)

local AiZiLaHandbookMO = pureTable("AiZiLaHandbookMO")

function AiZiLaHandbookMO:init(itemId)
	self.id = itemId
	self.itemId = itemId or 0
	self._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, self.itemId)
end

function AiZiLaHandbookMO:getConfig()
	self._config = self._config or AiZiLaConfig.instance:getItemCo(self.itemId)

	return self._config
end

function AiZiLaHandbookMO:getQuantity()
	return AiZiLaModel.instance:getItemQuantity(self.itemId)
end

function AiZiLaHandbookMO:isHasRed()
	if AiZiLaModel.instance:isCollectItemId(self.itemId) and not AiZiLaHelper.isFinishRed(self._redPointKey) then
		return true
	end

	return false
end

function AiZiLaHandbookMO:finishRed()
	AiZiLaHelper.finishRed(self._redPointKey)
end

function AiZiLaHandbookMO:getRedUid()
	return self.itemId
end

return AiZiLaHandbookMO
