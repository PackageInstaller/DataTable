-- chunkname: @modules/logic/rouge/model/RougeCollectionMO.lua

module("modules.logic.rouge.model.RougeCollectionMO", package.seeall)

local RougeCollectionMO = class("RougeCollectionMO")

function RougeCollectionMO:init(info)
	self:initBaseInfo(info)
	self:updateAttrValues(info.attr)
end

function RougeCollectionMO:initBaseInfo(info)
	self.id = tonumber(info.id)
	self.cfgId = tonumber(info.itemId)
	self.enchantIds = {}

	if info.holdIds then
		for _, holeId in ipairs(info.holdIds) do
			table.insert(self.enchantIds, tonumber(holeId))
		end
	end

	self.enchantCfgIds = {}

	if info.holdItems then
		for _, enchantCfgId in ipairs(info.holdItems) do
			table.insert(self.enchantCfgIds, tonumber(enchantCfgId))
		end
	end
end

function RougeCollectionMO:getCollectionCfgId()
	return self.cfgId
end

function RougeCollectionMO:getCollectionId()
	return self.id
end

function RougeCollectionMO:isEnchant(index)
	return self.enchantIds and self.enchantIds[index] and self.enchantIds[index] > 0
end

function RougeCollectionMO:getEnchantIdAndCfgId(holeIndex)
	if self.enchantIds then
		if self.enchantCfgIds then
			local cfgId = self.enchantCfgIds[holeIndex]

			return self.enchantIds, cfgId
		end
	end
end

function RougeCollectionMO:getAllEnchantId()
	return self.enchantIds
end

function RougeCollectionMO:getEnchantCount()
	local enchantCount = 0

	for _, enchantId in pairs(self.enchantIds) do
		if enchantId and enchantId > 0 then
			enchantCount = enchantCount + 1
		end
	end

	return enchantCount
end

function RougeCollectionMO:getAllEnchantCfgId()
	return self.enchantCfgIds
end

function RougeCollectionMO:updateEnchant(enchantId, holeIndex)
	self.enchantIds = self.enchantIds or {}
	self.enchantIds[holeIndex] = enchantId
end

function RougeCollectionMO:updateEnchantTargetId(targetId)
	self.enchantUid = targetId
end

function RougeCollectionMO:getEnchantTargetId()
	return self.enchantUid or 0
end

function RougeCollectionMO:isEnchant2Collection()
	return self.enchantUid and self.enchantUid > 0
end

function RougeCollectionMO:getRotation()
	return RougeEnum.CollectionRotation.Rotation_0
end

function RougeCollectionMO:updateInfo(info)
	self:init(info)
end

function RougeCollectionMO:copyOtherCollectionMO(mo)
	if not mo then
		return
	end

	self.id = mo.id
	self.cfgId = mo.cfgId
	self.enchantIds = {}

	if mo.enchantIds then
		for _, holeId in ipairs(mo.enchantIds) do
			table.insert(self.enchantIds, tonumber(holeId))
		end
	end

	self.enchantCfgIds = {}

	if mo.enchantCfgIds then
		for _, enchantCfgId in ipairs(mo.enchantCfgIds) do
			table.insert(self.enchantCfgIds, tonumber(enchantCfgId))
		end
	end
end

function RougeCollectionMO:updateAttrValues(attrValues)
	self.attrValueMap = {}

	if attrValues then
		local attrIds = attrValues.attrIds
		local attrVals = attrValues.attrVals

		for index, attrId in ipairs(attrIds) do
			self.attrValueMap[attrId] = tonumber(attrVals[index])
		end
	end
end

function RougeCollectionMO:isAttrExist(attrId)
	return self.attrValueMap and self.attrValueMap[attrId] ~= nil
end

function RougeCollectionMO:getAttrValueMap()
	return self.attrValueMap
end

function RougeCollectionMO:getLeftTopPos()
	return Vector2(1000, 1000)
end

return RougeCollectionMO
