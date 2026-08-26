-- chunkname: @modules/logic/mainuiswitch/view/MainBirdAnimView.lua

module("modules.logic.mainuiswitch.view.MainBirdAnimView", package.seeall)

local MainBirdAnimView = class("MainBirdAnimView", BaseView)

function MainBirdAnimView:onInitView()
	self._go = gohelper.findChild(self.viewGO, "right/go_fight/4")
	self._btnBird = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/4/click/#btn_bird")
	self._animBird = self._go:GetComponent(typeof(UnityEngine.Animator))
end

function MainBirdAnimView:addEvents()
	self._btnBird:AddClickListener(self._btnBirdOnClick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.ClickBird, self._onPlayBirdAnim, self)
end

function MainBirdAnimView:removeEvents()
	self._btnBird:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.ClickBird, self._onPlayBirdAnim, self)
end

function MainBirdAnimView:_btnBirdOnClick()
	self:_onPlayBirdAnim(self.viewName)
end

function MainBirdAnimView:_editableInitView()
	return
end

function MainBirdAnimView:onOpen()
	self._clickCount = 0

	self._animBird:Play("idle", 0, 0)
end

function MainBirdAnimView:_onPlayBirdAnim(viewName)
	if self.viewName ~= viewName then
		return
	end

	if self._isPlayingClick2 then
		return
	end

	if self._clickCount == 0 then
		self._clickSustainTime = self._clickSustainTime or MainUISwitchConfig.instance:getConstValue(MainUISwitchEnum.ConstId.BirdClickSustainTime, true) * 0.001

		TaskDispatcher.runDelay(self._resetClickTime, self, self._clickSustainTime)
	end

	self._clickCount = self._clickCount + 1

	local needClickCount = MainUISwitchConfig.instance:getConstValue(MainUISwitchEnum.ConstId.BirdClickCount, true)
	local animName

	if needClickCount > self._clickCount then
		animName = "click01"
	else
		self._isPlayingClick2 = true
		animName = "click2"

		TaskDispatcher.runDelay(self._playFinishClick2, self, 1.633)
		MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.TiggerMainUICaiDanAnim, "click", false, self.viewName)
	end

	self._animBird.enabled = true

	self._animBird:Play(animName, 0, 0)
end

function MainBirdAnimView:_resetClickTime()
	self._clickCount = 0
end

function MainBirdAnimView:_playFinishClick2()
	self._isPlayingClick2 = false
end

function MainBirdAnimView:onClose()
	TaskDispatcher.cancelTask(self._resetClickTime, self)
	TaskDispatcher.cancelTask(self._playFinishClick2, self)
end

function MainBirdAnimView:onDestroyView()
	return
end

return MainBirdAnimView
