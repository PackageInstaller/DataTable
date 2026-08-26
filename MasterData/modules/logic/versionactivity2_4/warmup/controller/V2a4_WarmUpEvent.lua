-- chunkname: @modules/logic/versionactivity2_4/warmup/controller/V2a4_WarmUpEvent.lua

module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpEvent", package.seeall)

local V2a4_WarmUpEvent = _M
local _uid = 1

local function E(name)
	assert(V2a4_WarmUpEvent[name] == nil, "[V2a4_WarmUpEvent] error redefined V2a4_WarmUpEvent." .. name)

	V2a4_WarmUpEvent[name] = _uid
	_uid = _uid + 1
end

E("onWaveStart")
E("onRoundStart")
E("onMoveStep")
E("onFlush")
E("onWaveEnd")

return V2a4_WarmUpEvent
