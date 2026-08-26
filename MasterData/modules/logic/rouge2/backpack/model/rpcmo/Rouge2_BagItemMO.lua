-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_BagItemMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_BagItemMO", package.seeall)

local Rouge2_BagItemMO = pureTable("Rouge2_BagItemMO")

function Rouge2_BagItemMO:init(info)
	self._uid = info.uid
	self.id = self._uid
	self._itemId = info.itemId
	self._count = info.count
	self._bagType = Rouge2_BackpackHelper.uid2BagType(self._uid)
	self._config = Rouge2_BackpackHelper.getItemConfig(self._itemId)

	if info:HasField("relicsItem") then
		self._relicsItem = self._relicsItem or Rouge2_RelicsItemMO.New()

		self._relicsItem:init(info.relicsItem)
	else
		self._relicsItem = nil
	end
end

function Rouge2_BagItemMO:getCount()
	return self._count
end

function Rouge2_BagItemMO:getUid()
	return self._uid
end

function Rouge2_BagItemMO:getItemId()
	return self._itemId
end

function Rouge2_BagItemMO:getRare()
	return self._config and self._config.rare
end

function Rouge2_BagItemMO:getConfig()
	return self._config
end

function Rouge2_BagItemMO:getAttrTag()
	return self._config and tonumber(self._config.attributeTag)
end

function Rouge2_BagItemMO:getAttrMap()
	return self._relicsItem and self._relicsItem:getAttrMap()
end

function Rouge2_BagItemMO:getAttrValue(attrId)
	return self._relicsItem and self._relicsItem:getAttrValue(attrId)
end

function Rouge2_BagItemMO:isTriggerEffect(effectId)
	return self._relicsItem and self._relicsItem:isTriggerEffect(effectId)
end

function Rouge2_BagItemMO:isTriggerUnlockEffect()
	local attrVal = self:getAttrValue(3001)

	return attrVal and attrVal ~= 0
end

function Rouge2_BagItemMO:__tostring()
	return string.format("uid : %s, itemId : %s, count : %s, bagType : %s", self._uid, self._itemId, self._count, self._bagType)
end

return Rouge2_BagItemMO
