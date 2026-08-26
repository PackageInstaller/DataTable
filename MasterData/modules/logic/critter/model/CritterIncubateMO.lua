-- chunkname: @modules/logic/critter/model/CritterIncubateMO.lua

module("modules.logic.critter.model.CritterIncubateMO", package.seeall)

local CritterIncubateMO = pureTable("CritterIncubateMO")
local _TEMP_EMPTY_TB = {}

function CritterIncubateMO:init(info)
	info = info or _TEMP_EMPTY_TB
end

function CritterIncubateMO:getTempChildMOList()
	return
end

return CritterIncubateMO
