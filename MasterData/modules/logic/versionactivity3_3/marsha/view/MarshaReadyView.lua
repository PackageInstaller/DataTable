-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaReadyView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaReadyView", package.seeall)

local MarshaReadyView = class("MarshaReadyView", BaseView)

function MarshaReadyView:onInitView()
	self._goCountdown = gohelper.findChild(self.viewGO, "#go_Countdown")
	self._goTarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Target/#btn_Next")
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "#go_Target/#txt_TargetDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MarshaReadyView:addEvents()
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
end

function MarshaReadyView:removeEvents()
	self._btnNext:RemoveClickListener()
end

function MarshaReadyView:_btnNextOnClick()
	if self.canSkip then
		self.canSkip = false

		TaskDispatcher.cancelTask(self.delay2, self)
		self:delay2()
	end
end

function MarshaReadyView:onClickModalMask()
	return
end

function MarshaReadyView:_editableInitView()
	self.animTarget = self._goTarget:GetComponent(gohelper.Type_Animator)
end

function MarshaReadyView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_renwu)

	local gameCo = MarshaConfig.instance:getGameConfig(self.viewParam)

	self._txtTargetDesc.text = gameCo.targetDesc

	TaskDispatcher.runDelay(self.delay1, self, 0.67)
end

function MarshaReadyView:delay1()
	self.canSkip = true

	TaskDispatcher.runDelay(self.delay2, self, 2)
end

function MarshaReadyView:delay2()
	AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_321)

	self.canSkip = false

	self.animTarget:Play("out", 0, 0)
	gohelper.setActive(self._goCountdown, true)
	TaskDispatcher.runDelay(self.closeThis, self, 3.34)
end

function MarshaReadyView:onClose()
	MarshaController.instance:dispatchEvent(MarshaEvent.GameStart)
end

return MarshaReadyView
