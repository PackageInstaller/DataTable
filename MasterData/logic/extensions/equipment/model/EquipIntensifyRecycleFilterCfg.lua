-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/EquipIntensifyRecycleFilterCfg.lua

module("logic.extensions.equipment.model.EquipIntensifyRecycleFilterCfg", package.seeall)

local M = class("EquipIntensifyRecycleFilterCfg", CommonEquipFilterCfg)

function M:ctor()
	M.super.ctor(self)
end

function M:doFilter(list)
	local quality = self:getQualityFilterType()
	local part = self:getPartFilterType()
	local suitId = self:getSuitId()
	local hideNoOriginalD6 = self:getHideNoOriginalD6()
	local d6SimplePart = self:getD6PartFilter()
	local d6SimpleResonance = self:getD6ResonanceFilter()
	local d6SimpleAttr = self:getD6AttributeFilter()
	local res = {}

	for _, itemData in ipairs(list) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(part, itemData:getPart()) and (suitId == 0 or itemData:getSuitId() == suitId) and (not hideNoOriginalD6 and true or itemData:hasOriginalD6()) and FilterCfgUtil.checkEquipsD6Filter(itemData, d6SimplePart, d6SimpleResonance, d6SimpleAttr) then
			table.insert(res, itemData)
		end
	end

	return res
end

M.instance = M.New()

return M
