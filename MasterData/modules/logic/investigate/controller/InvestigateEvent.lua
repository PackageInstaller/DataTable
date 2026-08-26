-- chunkname: @modules/logic/investigate/controller/InvestigateEvent.lua

module("modules.logic.investigate.controller.InvestigateEvent", package.seeall)

local InvestigateEvent = _M
local _get = GameUtil.getUniqueTb()

InvestigateEvent.ClueUpdate = _get()
InvestigateEvent.ShowGetEffect = _get()
InvestigateEvent.LinkedOpinionSuccess = _get()
InvestigateEvent.ChangeArrow = _get()

return InvestigateEvent
