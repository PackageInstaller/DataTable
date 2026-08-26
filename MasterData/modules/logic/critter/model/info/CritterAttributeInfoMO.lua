-- chunkname: @modules/logic/critter/model/info/CritterAttributeInfoMO.lua

module("modules.logic.critter.model.info.CritterAttributeInfoMO", package.seeall)

local CritterAttributeInfoMO = pureTable("CritterAttributeInfoMO")
local _TEMP_EMPTY_TB = {}

function CritterAttributeInfoMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.attributeId = info.attributeId or 0
	self.value = info.value and math.floor(info.value / 10000) or 0
	self.rate = info.rate or 0
	self._addRate = info.addRate or 0
end

function CritterAttributeInfoMO:setAttr(attributeId, value)
	self.attributeId = attributeId
	self.value = value
end

function CritterAttributeInfoMO:getConfig()
	return CritterConfig.instance:getCritterAttributeCfg(self.attributeId)
end

function CritterAttributeInfoMO:getName()
	local co = self:getConfig()

	return co.name
end

function CritterAttributeInfoMO:getIcon()
	local co = self:getConfig()

	return co.icon
end

function CritterAttributeInfoMO:getValueNum()
	return self.value
end

function CritterAttributeInfoMO:getAdditionRate()
	return self._addRate
end

function CritterAttributeInfoMO:getIsAddition()
	return self._addRate and self._addRate ~= 0
end

function CritterAttributeInfoMO:getRate()
	if self.rate then
		local rate = math.floor(self.rate * 0.01)

		return rate * 0.01
	end
end

function CritterAttributeInfoMO:getRateStr()
	local rate = self:getRate()

	if rate then
		local lang = luaLang("critter_attr_rate")

		return GameUtil.getSubPlaceholderLuaLangOneParam(lang, rate)
	end

	return ""
end

function CritterAttributeInfoMO:getaddRateStr()
	if self:getIsAddition() then
		local lang = luaLang("room_critter_Attribute_Addition")

		return GameUtil.getSubPlaceholderLuaLangOneParam(lang, math.floor(self._addRate * 0.01))
	end

	return ""
end

return CritterAttributeInfoMO
