-- chunkname: @modules/logic/activity/view/VersionSummonFull.lua

module("modules.logic.activity.view.VersionSummonFull", package.seeall)

local VersionSummonFull = class("VersionSummonFull", VersionSummon_BaseView)

function VersionSummonFull:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_PanelBG")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#simage_Role")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "prop/#btn_play")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionSummonFull:addEvents()
	VersionSummonFull.super.addEvents(self)
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function VersionSummonFull:removeEvents()
	VersionSummonFull.super.removeEvents(self)
	self._btnplay:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function VersionSummonFull:_btnCloseOnClick()
	self:closeThis()
end

function VersionSummonFull:_btnplayOnClick()
	local storyId = PatFaceConfig.instance:getPatFaceStoryId(30700)

	if not storyId or storyId == 0 then
		storyId = 800007
	end

	StoryController.instance:playStory(storyId)
end

function VersionSummonFull:_btnClaimOnClick()
	self.viewContainer:sendGet101BonusRequest(self._onSendGet101BonusRequestCb, self)
end

function VersionSummonFull:_btnGoToOnClick()
	GameFacade.jump(self._jumpId)
end

function VersionSummonFull:_editableInitView()
	self._txtNormal = gohelper.findChildText(self.viewGO, "#btn_Claim/#go_Normal/txt_Claim")
	self._txtNormalEn = gohelper.findChildText(self.viewGO, "#btn_Claim/#go_Normal/txt_ClaimEn")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "prop/image_Prop")
	self._gohasget = gohelper.findChild(self.viewGO, "prop/go_hasget")
	self._txtTips = gohelper.findChildText(self.viewGO, "txtbg/txt_Tips")
	self._txtremainTime.text = ""
end

function VersionSummonFull:onUpdateParam()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
	self:onRefresh()
end

function VersionSummonFull:onOpen()
	self:internal_set_actId(self.viewParam.actId)

	local activityCo = self:getActivityCo()

	if activityCo then
		local patFaceParam = activityCo.patFaceParam

		if not string.nilorempty(patFaceParam) then
			local strList = string.split(patFaceParam, "#")

			if strList then
				self._jumpId = strList[2]
			end
		end
	end

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
end

function VersionSummonFull:onRefresh()
	self:_refreshTimeTick()

	local isCanGet = self.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(self._goNormal, isCanGet)
	gohelper.setActive(self._goReceived, not isCanGet)
	gohelper.setActive(self._gohasget, not isCanGet)
end

function VersionSummonFull:_refreshTimeTick()
	self._txtremainTime.text = self.viewContainer:getActRemainTimeStr()
end

function VersionSummonFull:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function VersionSummonFull:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function VersionSummonFull:_onSendGet101BonusRequestCb()
	MainController.instance:dispatchEvent(MainEvent.OnRefreshSummonTuziRed)
end

return VersionSummonFull
