local var_0_0 = g.core.const.ConstMgr
local WaitGameTipsLinePop = class("WaitGameTipsLinePop", require("app.fairyGUI.upgrade.UI_WaitGameTipsLinePop"), function()
	return fgui.GComponent:create({
		resName = "WaitGameTipsLinePop",
		pkgPath = "ui/upgrade/upgrade",
		pkgName = "upgrade"
	}, ...)
end)

function WaitGameTipsLinePop:ctor(arg_2_1)
	self:showAtCenter()
	self:init(arg_2_1)
end

function WaitGameTipsLinePop:init(arg_3_1)
	local var_3_0

	if arg_3_1 then
		var_3_0 = arg_3_1.isCountDown or false
	end

	self.m_isCountDownController:setSelectedIndex(var_3_0 and 1 or 0)

	self._closeCallBack = arg_3_1.callBack
	self._title = arg_3_1.title or ""

	if var_3_0 then
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_COUNTDOWN)
		self.m_countDownTransition:play(handler(self, self._endCountDown))
	else
		self:updateTips()
	end
end

function WaitGameTipsLinePop:updateTips()
	self.m_tagIcon:setWidth(display.width)
	self.m_bgIcon:setWidth(display.width)
	self.m_title:setText(self._title)
	g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_START)
	self.m_enterTransition:play(handler(self, self._onDelayClose))
end

function WaitGameTipsLinePop:_endCountDown()
	self.m_isCountDownController:setSelectedIndex(0)
	self:updateTips()
end

function WaitGameTipsLinePop:_onDelayClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

return WaitGameTipsLinePop
