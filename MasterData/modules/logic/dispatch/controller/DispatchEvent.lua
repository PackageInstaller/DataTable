-- chunkname: @modules/logic/dispatch/controller/DispatchEvent.lua

module("modules.logic.dispatch.controller.DispatchEvent", package.seeall)

local DispatchEvent = _M

DispatchEvent.AddDispatchInfo = 1
DispatchEvent.RemoveDispatchInfo = 2
DispatchEvent.ChangeSelectedHero = 3
DispatchEvent.OnDispatchFinish = 4
DispatchEvent.ChangeDispatchHeroContainerEvent = 5

return DispatchEvent
