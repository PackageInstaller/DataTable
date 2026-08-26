-- chunkname: @modules/logic/summonuiswitch/controller/SummonUISwitchEvent.lua

module("modules.logic.summonuiswitch.controller.SummonUISwitchEvent", package.seeall)

local SummonUISwitchEvent = _M
local _get = GameUtil.getUniqueTb()

SummonUISwitchEvent.UseSceneUI = GameUtil.getEventId()
SummonUISwitchEvent.SwitchSceneUI = GameUtil.getEventId()
SummonUISwitchEvent.StartSwitchScene = GameUtil.getEventId()
SummonUISwitchEvent.SwitchSceneFinish = GameUtil.getEventId()
SummonUISwitchEvent.SwitchVisible = GameUtil.getEventId()
SummonUISwitchEvent.PreviewSceneSwitchUIVisible = GameUtil.getEventId()
SummonUISwitchEvent.SwitchPreviewSceneUI = GameUtil.getEventId()

return SummonUISwitchEvent
