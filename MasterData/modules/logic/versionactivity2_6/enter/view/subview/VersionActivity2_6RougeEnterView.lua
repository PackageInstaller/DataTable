-- chunkname: @modules/logic/versionactivity2_6/enter/view/subview/VersionActivity2_6RougeEnterView.lua

module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6RougeEnterView", package.seeall)

local VersionActivity2_6RougeEnterView = class("VersionActivity2_6RougeEnterView", BaseView)
local RougeDLCTipsId = 103

function VersionActivity2_6RougeEnterView:onInitView()
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._goRewardNew = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_new")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Right/#btn_reward/#txt_RewardNum")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_locked")
	self._txtUnlockedTips = gohelper.findChildText(self.viewGO, "Right/#btn_locked/#txt_UnLockedTips")
	self._btndlc = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_dlc")
	self._gostartreddot = gohelper.findChild(self.viewGO, "Right/#btn_start/#go_startreddot")
	self._goclosetipseffect = gohelper.findChild(self.viewGO, "Right/vx_glow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_6RougeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnlock:AddClickListener(self._btnLockOnClick, self)
	self._btndlc:AddClickListener(self._btndlcOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinishCallback, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function VersionActivity2_6RougeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btndlc:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshReward, self)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, self.refreshLock, self)
end

function VersionActivity2_6RougeEnterView:_btnEnterOnClick()
	RougeController.instance:openRougeMainView()
end

function VersionActivity2_6RougeEnterView:_btnRewardOnClick()
	RougeController.instance:openRougeRewardView()
end

function VersionActivity2_6RougeEnterView:_btnLockOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	GameFacade.showToastWithTableParam(toastId, toastParamList)
end

function VersionActivity2_6RougeEnterView:_btndlcOnClick()
	if not RougeDLCTipsId or RougeDLCTipsId == 0 then
		return
	end

	local params = {
		dlcId = RougeDLCTipsId
	}

	ViewMgr.instance:openView(ViewName.RougeDLCTipsView, params)
	gohelper.setActive(self._goclosetipseffect, false)
end

function VersionActivity2_6RougeEnterView:_editableInitView()
	RougeOutsideController.instance:initDLCReddotInfo()

	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)

	RedDotController.instance:addRedDot(self._gostartreddot, RedDotEnum.DotNode.RougeDLCNew)
end

function VersionActivity2_6RougeEnterView:onOpen()
	self._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(self._season)
	self.animComp:playOpenAnim()

	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)

	self:refreshLock()
	self:refreshReward()
	self:checkOpenDLCTipsView()
end

function VersionActivity2_6RougeEnterView:refreshLock()
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

function VersionActivity2_6RougeEnterView:refreshReward()
	self._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local isNew = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(self._goRewardNew, isNew)
end

function VersionActivity2_6RougeEnterView:checkOpenDLCTipsView()
	if not RougeDLCTipsId or RougeDLCTipsId == 0 then
		return
	end

	local key = string.format("%s#%s#%s", PlayerPrefsKey.RougePopUpDLCTipsId, PlayerModel.instance:getMyUserId(), RougeDLCTipsId)
	local canPopDLCTips = string.nilorempty(PlayerPrefsHelper.getString(key, ""))

	if canPopDLCTips then
		local params = {
			dlcId = RougeDLCTipsId
		}

		ViewMgr.instance:openView(ViewName.RougeDLCTipsView, params)
		PlayerPrefsHelper.setString(key, "true")
	end
end

function VersionActivity2_6RougeEnterView:_onCloseViewFinishCallback(viewName)
	if viewName ~= ViewName.RougeDLCTipsView then
		return
	end

	gohelper.setActive(self._goclosetipseffect, true)
end

function VersionActivity2_6RougeEnterView:onDestroyView()
	self.animComp:destroy()
end

return VersionActivity2_6RougeEnterView
