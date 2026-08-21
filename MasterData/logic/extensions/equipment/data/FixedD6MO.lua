-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/FixedD6MO.lua

module("logic.extensions.equipment.data.FixedD6MO", package.seeall)

local M = class("FixedD6MO", ItemBaseData)
local iconPrefix = "25010"

function M:ctor(FixedDiceNO)
	M.super.ctor(self, FixedDiceNO)
	self:updateByNo(FixedDiceNO)
end

function M:updateByNo(FixedDiceNO)
	self._itemId = FixedDiceNO.itemId
	self._attrs = {}

	for _, DiceAttrNO in ipairs(FixedDiceNO.attrs) do
		table.insert(self._attrs, DiceAttrMO.New(DiceAttrNO))
	end

	self._effectIndex = FixedDiceNO.effectIndex
	self._effectFace = FixedDiceNO.effectFace
end

function M:getItemId()
	return self._itemId
end

function M:getAttrs()
	return self._attrs
end

function M:setEffectIndex(effectIndex)
	self._effectIndex = effectIndex
end

function M:getEffectIndex()
	return self._effectIndex
end

function M:setEffectFace(effectFace)
	self._effectFace = effectFace
end

function M:getEffectFace()
	return self._effectFace
end

function M:getEffectAttr()
	return self._attrs[self._effectFace]
end

function M:getIcon()
	local part = self:getPart()
	local quality = self:getQuality()
	local qualityIcon = EquipEnum.EquipD6Quality2IconNum[quality]

	return iconPrefix .. part .. qualityIcon
end

function M:getPart()
	return self._itemInfo.part
end

function M:getQuality()
	if self._itemInfo and self._itemInfo.quality and self._itemInfo.quality > 0 then
		return self._itemInfo.quality
	end

	local maxLevel = self:getMaxAttrLevel()
	local dataList = EquipmentConfig.instance:getConfigList(ConfigName.D6Lv2Quality)

	maxLevel = math.min(dataList[#dataList].level, maxLevel)

	local cfg = EquipmentConfig.instance:getConfigByKey(ConfigName.D6Lv2Quality, maxLevel)

	return cfg.quality
end

function M:getMaxAttrLevel()
	local maxLevel = 1

	for _, diceAttrMo in ipairs(self._attrs) do
		if maxLevel < diceAttrMo:getLevel() then
			maxLevel = diceAttrMo:getReallyLevel()
		end
	end

	return maxLevel
end

return M
