-- chunkname: @modules/logic/rouge/view/RougeActivityView.lua

module("modules.logic.rouge.view.RougeActivityView", package.seeall)

local RougeActivityView = class("RougeActivityView", BaseViewExtended)

function RougeActivityView:onInitView()
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._goRewardNew = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_new")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Right/#btn_reward/#txt_RewardNum")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_locked")
	self._txtUnlockedTips = gohelper.findChildText(self.viewGO, "Right/#btn_locked/#txt_UnLockedTips")
	self._gotitle = gohelper.findChild(self.viewGO, "Right/title")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "Right/title/normal")
	self._godlctitles = gohelper.findChild(self.viewGO, "Right/title/#go_dlctitles")

	self:addChildView(RougeActivityTaskEntryView.New("Right/#go_ActivityTask"))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeActivityView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnlock:AddClickListener(self._btnLockOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnGetVersionInfo, self._onUpdateVersion, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function RougeActivityView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function RougeActivityView:_btnEnterOnClick()
	RougeController.instance:openRougeMainView()
end

function RougeActivityView:_btnRewardOnClick()
	RougeController.instance:openRougeRewardView()
end

function RougeActivityView:_btnLockOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self._openId)

	GameFacade.showToastWithTableParam(toastId, toastParamList)
end

function RougeActivityView:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function RougeActivityView:onOpen()
	self._season = RougeOutsideModel.instance:season()
	self._openId = RougeOutsideModel.instance:openUnlockId()
	self._rpcId = RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(self._season)

	self._animator:Play("open", 0, 0)
	self:refreshUI()
end

function RougeActivityView:refreshUI()
	self:refreshLock()
	self:refreshReward()
	self:refreshDLCTitle()
end

function RougeActivityView:refreshLock()
	local isUnlock = RougeOutsideModel.instance:isUnlock()

	gohelper.setActive(self._btnlock, not isUnlock)
	gohelper.setActive(self._btnReward.gameObject, isUnlock)

	if not isUnlock then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(self._openId)
		local tip = ToastConfig.instance:getToastCO(toastId).tips

		tip = GameUtil.getSubPlaceholderLuaLang(tip, toastParamList)
		self._txtUnlockedTips.text = tip
	else
		self._txtUnlockedTips.text = ""
	end
end

function RougeActivityView:refreshReward()
	self._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local isNew = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(self._goRewardNew, isNew)
end

function RougeActivityView:refreshDLCTitle()
	local newVersionStr = RougeDLCHelper.getCurVersionString()
	local dlcTitleCount = self._godlctitles.transform.childCount

	for i = 1, dlcTitleCount do
		local goDLCTitle = self._godlctitles.transform:GetChild(i - 1).gameObject
		local goDLCName = goDLCTitle.name

		gohelper.setActive(goDLCTitle, goDLCName == newVersionStr)
	end

	local notAddDLC = string.nilorempty(newVersionStr)

	gohelper.setActive(self._gonormaltitle, notAddDLC)
end

function RougeActivityView:_onUpdateVersion()
	self:refreshDLCTitle()
end

function RougeActivityView:onDestroyView()
	if self._rpcId then
		RougeOutsideRpc.instance:removeCallbackById(self._rpcId)

		self._rpcId = nil
	end
end

return RougeActivityView
