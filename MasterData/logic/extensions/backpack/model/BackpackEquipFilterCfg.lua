-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackEquipFilterCfg.lua

module("logic.extensions.backpack.model.BackpackEquipFilterCfg", package.seeall)

local M = class("BackpackEquipFilterCfg", CommonEquipFilterCfg)

function M:ctor()
	M.super.ctor(self)
end

function M:doFilter(list)
	local res = {}

	if not list then
		return res
	end

	local quality = self:getQualityFilterType()
	local part = self:getPartFilterType()
	local suitId = self:getSuitId()
	local hideNoOriginalD6 = self:getHideNoOriginalD6()
	local d6SimplePart = self:getD6PartFilter()
	local d6SimpleResonance = self:getD6ResonanceFilter()
	local d6SimpleAttr = self:getD6AttributeFilter()
	local diceAttrs = self:getDiceIds()

	for _, itemData in ipairs(list) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(part, itemData:getPart()) and (suitId == 0 or itemData:getSuitId() == suitId) and (not hideNoOriginalD6 and true or itemData:hasOriginalD6()) and FilterCfgUtil.checkEquipsD6Filter(itemData, d6SimplePart, d6SimpleResonance, d6SimpleAttr) and FilterCfgUtil.checkEquipDicesAttr(itemData, diceAttrs) then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	local quality = self:getQualityFilterType()
	local part = self:getPartFilterType()
	local suitId = self:getSuitId()
	local hideNoOriginalD6 = self:getHideNoOriginalD6()
	local d6SimplePart = self:getD6PartFilter()
	local d6SimpleResonance = self:getD6ResonanceFilter()
	local d6SimpleAttr = self:getD6AttributeFilter()

	return MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(part, itemData:getPart()) and (suitId == 0 or itemData:getSuitId() == suitId) and (not hideNoOriginalD6 and true or itemData:hasOriginalD6()) and FilterCfgUtil.checkEquipsD6Filter(itemData, d6SimplePart, d6SimpleResonance, d6SimpleAttr)
end

return M
