-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicTipToastItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicTipToastItem", package.seeall)

local AtomicTipToastItem = class("AtomicTipToastItem", AtomicToastBaseItem)

function AtomicTipToastItem:ctor(param)
	self.toastView = param.toastView
	self.notSetX = param.notSetX
end

function AtomicTipToastItem:init(go)
	AtomicTipToastItem.super.init(self, go)

	self.goEmergency = gohelper.findChild(self.go, "pos/go_emergency")
	self.goWarning = gohelper.findChild(self.go, "pos/go_emergency/layout/go_warning")
	self.goTime = gohelper.findChild(self.go, "pos/go_emergency/layout/go_time")
	self.txtEmergency = gohelper.findChildText(self.go, "pos/go_emergency/layout/txt_emergency")
	self.goElement = gohelper.findChild(self.go, "pos/go_element")
	self.txtElement = gohelper.findChildText(self.go, "pos/go_element/layout/txt_element")
end

function AtomicTipToastItem:refreshUI(type)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_emergency_alarm)

	if type == AtomicDungeonEnum.TipToastType.EmergencyShow then
		gohelper.setActive(self.goElement, false)
		gohelper.setActive(self.goEmergency, true)
		gohelper.setActive(self.goTime, true)
		gohelper.setActive(self.goWarning, false)

		self.txtEmergency.text = luaLang("s02_atomic_emergencyShow")
	elseif type == AtomicDungeonEnum.TipToastType.AlarmChange then
		gohelper.setActive(self.goElement, false)
		gohelper.setActive(self.goEmergency, true)
		gohelper.setActive(self.goTime, false)
		gohelper.setActive(self.goWarning, true)

		local oldAlarmLevel = AtomicDungeonModel.instance:getOldAlarmLevel()
		local curAlamrLevel = AtomicDungeonModel.instance:getCurAlarmLevel()

		self.txtEmergency.text = oldAlarmLevel < curAlamrLevel and luaLang("s02_atomic_alarmAdd") or luaLang("s02_atomic_alarmReduce")

		AtomicDungeonModel.instance:setOldAlarmValue()
	elseif type == AtomicDungeonEnum.TipToastType.UnlockElement then
		gohelper.setActive(self.goElement, true)
		gohelper.setActive(self.goEmergency, false)

		self.txtElement.text = luaLang("s02_atomic_unlockElement")
	elseif type == AtomicDungeonEnum.TipToastType.EmergencyExpired then
		gohelper.setActive(self.goElement, false)
		gohelper.setActive(self.goEmergency, true)
		gohelper.setActive(self.goTime, false)
		gohelper.setActive(self.goWarning, true)

		self.txtEmergency.text = luaLang("s02_atomic_emergencyExpired")
	end
end

function AtomicTipToastItem:_delay()
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.RecycleTipToast, self)
end

return AtomicTipToastItem
