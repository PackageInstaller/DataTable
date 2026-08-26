-- chunkname: @modules/logic/critter/model/info/CritterAttributeMO.lua

module("modules.logic.critter.model.info.CritterAttributeMO", package.seeall)

local CritterAttributeMO = pureTable("CritterAttributeMO")
local _TEMP_EMPTY_TB = {}

function CritterAttributeMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.attributeId = info.attributeId or 0
	self.value = info.value and math.floor(info.value / 10000) or 0
end

function CritterAttributeMO:setAttr(attributeId, value)
	self.attributeId = attributeId
	self.value = value
end

function CritterAttributeMO:getValueNum()
	return self.value
end

return CritterAttributeMO
