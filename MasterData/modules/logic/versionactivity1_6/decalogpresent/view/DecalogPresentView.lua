-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/view/DecalogPresentView.lua

module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentView", package.seeall)

local DecalogPresentView = class("DecalogPresentView", BaseView)

function DecalogPresentView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecalogPresentView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshReceiveStatus, self)
end

function DecalogPresentView:removeEvents()
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshReceiveStatus, self)
end

function DecalogPresentView:_btnClaimOnClick()
	DecalogPresentController.instance:receiveDecalogPresent()
end

function DecalogPresentView:_btnCloseOnClick()
	self:closeThis()
end

function DecalogPresentView:_editableInitView()
	return
end

function DecalogPresentView:onUpdateParam()
	return
end

function DecalogPresentView:onOpen()
	self:refreshReceiveStatus()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function DecalogPresentView:refreshRemainTime()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

function DecalogPresentView:refreshReceiveStatus()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local index = DecalogPresentModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	gohelper.setActive(self._goNormal, canReceive)
	gohelper.setActive(self._goHasReceived, not canReceive)
end

function DecalogPresentView:onClose()
	return
end

function DecalogPresentView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return DecalogPresentView
