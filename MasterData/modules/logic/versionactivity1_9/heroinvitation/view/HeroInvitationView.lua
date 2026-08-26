-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationView.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationView", package.seeall)

local HeroInvitationView = class("HeroInvitationView", BaseView)

function HeroInvitationView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.btnMask = gohelper.findChildButtonWithAudio(self.viewGO, "mask")
	self.txtTotal = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Total")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Total/#txt_Num")
	self.btnPreview = gohelper.findChildButtonWithAudio(self.viewGO, "Left/skinname/txt_Dec2/#btn_preview")
	self.btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_claim")
	self.goEffect = gohelper.findChild(self.viewGO, "Left/#btn_claim/bg_effect1")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroInvitationView:addEvents()
	self.addClickCb(self, self.btnMask, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnPreview, self.onClickBtnPreview, self)
	self.addClickCb(self, self.btnClaim, self.onClickBtnClaim, self)
	self.addClickCb(self, self.btnFinish, self.onClickBtnFinish, self)
	self.addEventCb(self, HeroInvitationController.instance, HeroInvitationEvent.StateChange, self.refreshView, self)
	self.addEventCb(self, HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, self.refreshView, self)
end

function HeroInvitationView:removeEvents()
	return
end

function HeroInvitationView:_editableInitView()
	return
end

function HeroInvitationView:onClickBtnPreview()
	local rewardStr = CommonConfig.instance:getConstStr(ConstEnum.HeroInvitationReward)
	local rewardList = GameUtil.splitString2(rewardStr, true)
	local reward1 = rewardList[1]

	MaterialTipController.instance:showMaterialInfo(reward1[1], reward1[2], false, nil, false)
end

function HeroInvitationView:onClickBtnClaim()
	if HeroInvitationModel.instance.finalReward then
		return
	end

	if HeroInvitationListModel.instance.count > HeroInvitationListModel.instance.finishCount then
		return
	end

	HeroInvitationRpc.instance:sendGainFinalInviteRewardRequest()
end

function HeroInvitationView:onClickBtnFinish()
	return
end

function HeroInvitationView:onClickBtnClose()
	self:closeThis()
end

function HeroInvitationView:onUpdateParam()
	self:refreshView()
end

function HeroInvitationView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	self:refreshView()

	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByCheckFunc(function(mo)
		local state = HeroInvitationModel.instance:getInvitationState(mo.id)

		return state ~= HeroInvitationEnum.InvitationState.Finish
	end)
	scrollView:refreshScroll()
end

function HeroInvitationView:onClose()
	return
end

function HeroInvitationView:refreshView()
	HeroInvitationListModel.instance:refreshList()

	local count, finishCount = HeroInvitationModel.instance:getInvitationHasRewardCount()

	self.txtNum.text = finishCount
	self.txtTotal.text = count

	local finalReward = HeroInvitationModel.instance.finalReward

	gohelper.setActive(self.btnClaim, not finalReward)
	gohelper.setActive(self.btnFinish, finalReward)

	if not finalReward then
		local gray = finishCount < count

		ZProj.UGUIHelper.SetGrayscale(self.btnClaim.gameObject, gray)
		gohelper.setActive(self.goEffect, not gray)
	end
end

function HeroInvitationView:onDestroyView()
	return
end

return HeroInvitationView
