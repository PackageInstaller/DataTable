-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/CommonEquipFilterCfg.lua

module("logic.extensions.charactersystem.config.CommonEquipFilterCfg", package.seeall)

local CommAll = CommEnum.CommonAll
local M = class("CommonEquipFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._filterWhiteList = nil
	self._qualityFilterType = CommAll
	self._partFilterType = CommAll
	self._suitId = CommAll
	self._d6Part = CommAll
	self._d6Resonance = CommAll
	self._d6Attribute = {
		CommAll
	}
	self._hideNoOriginalD6 = false
end

function M:resetEquipBase()
	self._qualityFilterType = CommAll
	self._partFilterType = CommAll
	self._suitId = CommAll
	self._diceIds = nil
end

function M:resetEquipD6()
	self._d6Part = CommAll
	self._d6Resonance = CommAll
	self._d6Attribute = {
		CommAll
	}
end

function M:reset()
	self._filterWhiteList = nil

	self:resetEquipBase()
	self:resetEquipD6()
end

function M:addFilterWhiteList(...)
	local arg = {
		...
	}

	if not self._filterWhiteList then
		self._filterWhiteList = 0
	end

	for _, v in pairs(arg) do
		local newWhite = MultipleEnumUtil.getOneMultipleValue(v)

		self._filterWhiteList = MultipleEnumUtil.multipleEnumAdd(self._filterWhiteList, newWhite)
	end
end

function M:removeFilterWhiteList(...)
	if not self._filterWhiteList then
		return
	end

	local arg = {
		...
	}

	for _, v in pairs(arg) do
		local newWhite = MultipleEnumUtil.getOneMultipleValue(v)

		self._filterWhiteList = MultipleEnumUtil.multipleEnumSub(self._filterWhiteList, newWhite)
	end
end

function M:containFilterWhiteList(EquipFilterKind)
	if not self._filterWhiteList then
		return false
	end

	local newWhite = MultipleEnumUtil.getOneMultipleValue(EquipFilterKind)

	return MultipleEnumUtil.multipleEnumContain(self._filterWhiteList, newWhite)
end

function M:setQualityFilterType(filterType)
	self._qualityFilterType = filterType
end

function M:getQualityFilterType()
	return self._qualityFilterType
end

function M:setPartFilterType(filterType)
	self._partFilterType = filterType
end

function M:getPartFilterType()
	return self._partFilterType
end

function M:setSuitId(suitId)
	self._suitId = suitId
end

function M:getSuitId()
	return self._suitId
end

function M:setDiceIds(diceIds)
	self._diceIds = diceIds
end

function M:getDiceIds()
	return self._diceIds
end

function M:setD6PartFilter(d6Part)
	self._d6Part = d6Part
end

function M:getD6PartFilter()
	return self._d6Part
end

function M:setD6ResonanceFilter(d6Resonance)
	self._d6Resonance = d6Resonance
end

function M:getD6ResonanceFilter()
	return self._d6Resonance
end

function M:setD6AttributeFilter(d6Attribute)
	self._d6Attribute = clone(d6Attribute)
end

function M:getD6AttributeFilter()
	return self._d6Attribute
end

function M:setHideNoOriginD6(hideNoOriginalD6)
	self._hideNoOriginalD6 = hideNoOriginalD6
end

function M:getHideNoOriginalD6()
	return self._hideNoOriginalD6
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
