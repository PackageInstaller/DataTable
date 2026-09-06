-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallInviteView.lua

module("logic.extensions.recalltask.view.RecallInviteView", package.seeall)

local RecallInviteView = class("RecallInviteView", ViewComponent)

function RecallInviteView:ctor()
	RecallInviteView.super.ctor(self)
end

function RecallInviteView:bindEvents()
	RecallInviteView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
end

function RecallInviteView:unbindEvents()
	RecallInviteView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function RecallInviteView:buildUI()
	RecallInviteView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descTxt")
	self._headGo = self:getGo("headGo")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "nameTxt")
	self._taskNameTxt = goutil.findChildTextComponent(self.mainGO, "taskNameTxt")
	self._taskDescTxt = goutil.findChildTextComponent(self.mainGO, "taskDescTxt")
	self._sureBtn = self:getBtn("sureBtn")
	self._sureTxtGo = self:getGo("sureBtn/sureTxt")
	self._tipsGo = self:getGo("tipsGo")
	self._descTxt.text = ""
	self._nameTxt.text = ""
	self._taskNameTxt.text = ""
	self._taskDescTxt.text = ""

	self._tipsGo:SetActive(false)
end

function RecallInviteView:onExit()
	RecallInviteView.super.onExit(self)
	MaterialMgr.resetAll(self._headGo)
end

function RecallInviteView:destroyUI()
	RecallInviteView.super.destroyUI(self)
end

function RecallInviteView:onEnter()
	RecallInviteView.super.onEnter(self)
	MaterialMgr.resetAll(self._headGo)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.taskId == nil then
		return
	end

	local desc, str, title = RecallTaskModel.instance:getRecallTaskShare(self._params.taskId)

	if string.nilorempty(desc) or string.nilorempty(title) then
		return
	end

	local isMy = self._viewPresentor._openParam[2]

	self._taskNameTxt.text = title
	self._taskDescTxt.text = desc

	local cfg = RecallTaskConfig.instance:getRecallActivityCfg(RecallTaskModel.instance.openActivityId)

	if isMy then
		HeadItemController.instance:setMyHeadCell(self._headGo)

		self._nameTxt.text = RoleModel.instance:getUserName()

		self._tipsGo:SetActive(false)
		GameUtil.SetActive(self._sureBtn, false)

		self._descTxt.text = ""
	else
		HeadItemController.instance:setHeadCellByInfo(self._headGo, self._params.senderHeadInfo)

		self._nameTxt.text = self._params.senderHeadInfo.userName

		uGuiUtil.setImageGrayState(self._sureBtn.gameObject, not self._params.hasChanceComplete)
		uGuiUtil.setTextGrayState(self._sureTxtGo, not self._params.hasChanceComplete)

		self._sureBtn.btn.interactable = self._params.hasChanceComplete

		self._tipsGo:SetActive(not self._params.hasChanceComplete)

		self._descTxt.text = langPara("text_recall_desc_2", self._params.acceptTaskCount, cfg.dailyTaskCount)
	end
end

function RecallInviteView:_onClickSureBtn()
	RecallTaskController.instance:scGetAcceptTaskInviteReq(self._params.senderHeadInfo.userId, self._params.taskId)
	self:close()
end

return RecallInviteView
