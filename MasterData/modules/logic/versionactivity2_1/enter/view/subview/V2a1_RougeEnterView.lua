-- chunkname: @modules/logic/versionactivity2_1/enter/view/subview/V2a1_RougeEnterView.lua

module("modules.logic.versionactivity2_1.enter.view.subview.V2a1_RougeEnterView", package.seeall)

local V2a1_RougeEnterView = class("V2a1_RougeEnterView", BaseView)

function V2a1_RougeEnterView:onInitView()
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._goRewardNew = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_new")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Right/#btn_reward/#txt_RewardNum")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/txt_Descr")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_locked")
	self._txtUnlockedTips = gohelper.findChildText(self.viewGO, "Right/#btn_locked/#txt_UnLockedTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_RougeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnlock:AddClickListener(self._btnLockOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function V2a1_RougeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function V2a1_RougeEnterView:_btnEnterOnClick()
	RougeController.instance:openRougeMainView()
end

function V2a1_RougeEnterView:_btnRewardOnClick()
	RougeController.instance:openRougeRewardView()
end

function V2a1_RougeEnterView:_btnLockOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	GameFacade.showToastWithTableParam(toastId, toastParamList)
end

function V2a1_RougeEnterView:_editableInitView()
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V2a1_RougeEnterView:onOpen()
	self._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(self._season)
	self.animComp:playOpenAnim()

	self.config = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.RougeDlc1)
	self._txtDescr.text = self.config.actDesc

	self:refreshLock()
	self:refreshReward()
end

function V2a1_RougeEnterView:refreshLock()
	local openId = self.config.openId
	local isLock = openId ~= 0 and not OpenModel.instance:isFunctionUnlock(openId)

	gohelper.setActive(self._btnlock, isLock)
	gohelper.setActive(self._btnReward.gameObject, not isLock)

	if isLock then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)
		local tip = ToastConfig.instance:getToastCO(toastId).tips

		tip = GameUtil.getSubPlaceholderLuaLang(tip, toastParamList)
		self._txtUnlockedTips.text = tip
	else
		self._txtUnlockedTips.text = ""
	end
end

function V2a1_RougeEnterView:refreshReward()
	self._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local isNew = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(self._goRewardNew, isNew)
end

function V2a1_RougeEnterView:onDestroyView()
	self.animComp:destroy()
end

return V2a1_RougeEnterView
