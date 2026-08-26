-- chunkname: @modules/logic/versionactivity3_5/schoolstart/controller/V3a5_SchoolStartEvent.lua

module("modules.logic.versionactivity3_5.schoolstart.controller.V3a5_SchoolStartEvent", package.seeall)

local V3a5_SchoolStartEvent = _M
local _get = GameUtil.getUniqueTb()

V3a5_SchoolStartEvent.OnGetInfoReply = _get()
V3a5_SchoolStartEvent.OnFlipGridGridReply = _get()
V3a5_SchoolStartEvent.OnGetBigRewardReply = _get()

return V3a5_SchoolStartEvent
