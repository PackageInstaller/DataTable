-- chunkname: @modules/logic/gm/controller/define/PerformanceRecordEvent.lua

module("modules.logic.gm.controller.define.PerformanceRecordEvent", package.seeall)

local PerformanceRecordEvent = _M
local _uid = 1

local function E(name)
	assert(PerformanceRecordEvent[name] == nil, "[PerformanceRecordEvent] error redefined PerformanceRecordEvent." .. name)

	PerformanceRecordEvent[name] = _uid
	_uid = _uid + 1
end

E("onRecordDone")

return PerformanceRecordEvent
