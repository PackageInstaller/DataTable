-- chunkname: @modules/logic/clickuiswitch/controller/ClickUISwitchEvent.lua

module("modules.logic.clickuiswitch.controller.ClickUISwitchEvent", package.seeall)

local ClickUISwitchEvent = _M

ClickUISwitchEvent.UseClickUI = GameUtil.getEventId()
ClickUISwitchEvent.SwitchClickUI = GameUtil.getEventId()
ClickUISwitchEvent.SwitchVisible = GameUtil.getEventId()
ClickUISwitchEvent.PreviewSwitchVisible = GameUtil.getEventId()
ClickUISwitchEvent.CancelReddot = GameUtil.getEventId()
ClickUISwitchEvent.LoadUIPrefabs = GameUtil.getEventId()

return ClickUISwitchEvent
