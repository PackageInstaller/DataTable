-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2ElementInfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2ElementInfoMO", package.seeall)

local WeekwalkVer2ElementInfoMO = pureTable("WeekwalkVer2ElementInfoMO")

function WeekwalkVer2ElementInfoMO:init(info)
	self.elementId = info.elementId
	self.finish = info.finish
	self.index = info.index
	self.visible = info.visible
end

return WeekwalkVer2ElementInfoMO
