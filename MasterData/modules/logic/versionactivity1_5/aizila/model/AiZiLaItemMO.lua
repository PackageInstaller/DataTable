-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaItemMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaItemMO", package.seeall)

local AiZiLaItemMO = pureTable("AiZiLaItemMO")

function AiZiLaItemMO:init(uid, itemId, quantity)
	self.id = uid
	self.uid = uid
	self.itemId = itemId or 0
	self.quantity = quantity or 0
end

function AiZiLaItemMO:getConfig()
	self._config = self._config or AiZiLaConfig.instance:getItemCo(self.itemId)

	return self._config
end

function AiZiLaItemMO:updateInfo(info)
	self.itemId = info.itemId
	self.quantity = info.quantity
end

function AiZiLaItemMO:addInfo(info)
	if self.itemId == info.itemId then
		self.quantity = self.quantity + info.quantity
	end
end

function AiZiLaItemMO:getQuantity()
	return self.quantity
end

return AiZiLaItemMO
