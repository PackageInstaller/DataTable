-- chunkname: @modules/logic/mainuiswitch/controller/MainUISwitchEvent.lua

module("modules.logic.mainuiswitch.controller.MainUISwitchEvent", package.seeall)

local MainUISwitchEvent = _M

MainUISwitchEvent.UseMainUI = GameUtil.getEventId()
MainUISwitchEvent.SwitchMainUI = GameUtil.getEventId()
MainUISwitchEvent.SwitchUIVisible = GameUtil.getEventId()
MainUISwitchEvent.PreviewSwitchUIVisible = GameUtil.getEventId()
MainUISwitchEvent.ClickMainViewBtn = GameUtil.getEventId()
MainUISwitchEvent.ClickEagle = GameUtil.getEventId()
MainUISwitchEvent.ClickBird = GameUtil.getEventId()
MainUISwitchEvent.TiggerMainUIFirstAnim = GameUtil.getEventId()
MainUISwitchEvent.TiggerMainUICaiDanAnim = GameUtil.getEventId()

return MainUISwitchEvent
