-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummonPanel.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummonPanel", package.seeall)

local V2a9_VersionSummonPanel = class("V2a9_VersionSummonPanel", V2a9_VersionSummon_BaseView)

function V2a9_VersionSummonPanel:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnMask = gohelper.findChildButton(self.viewGO, "Mask")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#simage_Role")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "prop/image_Prop")
	self._txtTips = gohelper.findChildText(self.viewGO, "txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_VersionSummonPanel:addEvents()
	V2a9_VersionSummonPanel.super.addEvents(self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnMask:AddClickListener(self._btnCloseOnClick, self)
end

function V2a9_VersionSummonPanel:removeEvents()
	V2a9_VersionSummonPanel.super.removeEvents(self)
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function V2a9_VersionSummonPanel:_btnCloseOnClick()
	self:closeThis()
end

function V2a9_VersionSummonPanel:_btnClaimOnClick()
	self.viewContainer:sendGet101BonusRequest()
end

function V2a9_VersionSummonPanel:onOpen()
	self._txtremainTime.text = ""

	self:internal_set_actId(self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
end

function V2a9_VersionSummonPanel:onUpdateParam()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
	self:onRefresh()
end

function V2a9_VersionSummonPanel:onRefresh()
	self:_refreshTimeTick()

	local isCanGet = self.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(self._goNormal, isCanGet)
	gohelper.setActive(self._goHasReceived, not isCanGet)
end

function V2a9_VersionSummonPanel:_refreshTimeTick()
	self._txtremainTime.text = self.viewContainer:getActRemainTimeStr()
end

function V2a9_VersionSummonPanel:onClose()
	return
end

function V2a9_VersionSummonPanel:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a9_VersionSummonPanel:onClickModalMask()
	self:closeThis()
end

return V2a9_VersionSummonPanel
