-- chunkname: @modules/logic/versionactivity/define/VersionActivityEvent.lua

module("modules.logic.versionactivity.define.VersionActivityEvent", package.seeall)

local VersionActivityEvent = _M

VersionActivityEvent.OnBuy107GoodsSuccess = 1
VersionActivityEvent.AddTaskActivityBonus = 2
VersionActivityEvent.OnReceiveFinishTaskReply = 3
VersionActivityEvent.OnGet107GoodsInfo = 4
VersionActivityEvent.VersionActivity112Update = 11201
VersionActivityEvent.VersionActivity112TaskGetBonus = 11202
VersionActivityEvent.VersionActivity112TaskUpdate = 11203

return VersionActivityEvent
