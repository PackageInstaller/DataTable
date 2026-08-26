-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2CupInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2CupInfoMO", package.seeall)

local WeekwalkVer2CupInfoMO = pureTable("WeekwalkVer2CupInfoMO")

function WeekwalkVer2CupInfoMO:init(info)
	self.id = info.id
	self.result = info.result
	self.config = lua_weekwalk_ver2_cup.configDict[self.id]
	self.index = self.config.cupNo
end

return WeekwalkVer2CupInfoMO
