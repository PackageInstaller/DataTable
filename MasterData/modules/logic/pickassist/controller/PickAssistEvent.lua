-- chunkname: @modules/logic/pickassist/controller/PickAssistEvent.lua

module("modules.logic.pickassist.controller.PickAssistEvent", package.seeall)

local PickAssistEvent = _M

PickAssistEvent.SetCareer = 1
PickAssistEvent.RefreshSelectAssistHero = 2
PickAssistEvent.BeforeRefreshAssistList = 3

return PickAssistEvent
