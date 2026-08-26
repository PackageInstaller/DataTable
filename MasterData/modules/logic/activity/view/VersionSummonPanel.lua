-- chunkname: @modules/logic/activity/view/VersionSummonPanel.lua

module("modules.logic.activity.view.VersionSummonPanel", package.seeall)

local VersionSummonPanel = class("VersionSummonPanel", VersionSummon_BaseView)

function VersionSummonPanel:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#simage_Role")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionSummonPanel:addEvents()
	VersionSummonPanel.super.addEvents(self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnMask:AddClickListener(self._btnCloseOnClick, self)
end

function VersionSummonPanel:removeEvents()
	VersionSummonPanel.super.removeEvents(self)
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function VersionSummonPanel:_btnCloseOnClick()
	self:closeThis()
end

function VersionSummonPanel:_btnClaimOnClick()
	self.viewContainer:sendGet101BonusRequest(self._onSendGet101BonusRequestCb, self)
end

function VersionSummonPanel:_btnGoToOnClick()
	GameFacade.jump(self._jumpId)
end

function VersionSummonPanel:_editableInitView()
	self._txtNormal = gohelper.findChildText(self.viewGO, "#btn_Claim/#go_Normal/txt_Claim")
	self._txtNormalEn = gohelper.findChildText(self.viewGO, "#btn_Claim/#go_Normal/txt_ClaimEn")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "prop/image_Prop")
	self._gohasget = gohelper.findChild(self.viewGO, "prop/go_hasget")
	self._txtTips = gohelper.findChildText(self.viewGO, "txtbg/txt_Tips")
	self._btnMask = gohelper.findChildButton(self.viewGO, "Mask")
	self._txtremainTime.text = ""
end

function VersionSummonPanel:onOpen()
	self._config = ActivityConfig.instance:getActivityCo(self.viewParam.actId)

	local var_8_0 = self._config

	if self._config then
		var_8_0 = self._config.patFaceParam

		if self._config.patFaceParam then
			local patFaceParam = string.split(self._config.patFaceParam, "#")

			self._jumpId = patFaceParam and patFaceParam[2]
			self._txtremainTime.text = ""

			self:internal_set_actId(self.viewParam.actId)
			self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
			self:internal_onOpen()
			TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
		end
	end
end

function VersionSummonPanel:onUpdateParam()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
	self:onRefresh()
end

function VersionSummonPanel:onRefresh()
	self:_refreshTimeTick()

	local isCanGet = self.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(self._goNormal, isCanGet)
	gohelper.setActive(self._goHasReceived, not isCanGet)
	gohelper.setActive(self._gohasget, not isCanGet)
end

function VersionSummonPanel:_refreshTimeTick()
	self._txtremainTime.text = self.viewContainer:getActRemainTimeStr()
end

function VersionSummonPanel:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function VersionSummonPanel:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function VersionSummonPanel:onClickModalMask()
	self:closeThis()
end

function VersionSummonPanel:_onSendGet101BonusRequestCb()
	MainController.instance:dispatchEvent(MainEvent.OnRefreshSummonTuziRed)
end

return VersionSummonPanel
