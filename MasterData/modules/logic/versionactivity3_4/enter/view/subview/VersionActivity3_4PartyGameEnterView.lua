-- chunkname: @modules/logic/versionactivity3_4/enter/view/subview/VersionActivity3_4PartyGameEnterView.lua

module("modules.logic.versionactivity3_4.enter.view.subview.VersionActivity3_4PartyGameEnterView", package.seeall)

local VersionActivity3_4PartyGameEnterView = class("VersionActivity3_4PartyGameEnterView", VersionActivityEnterBaseSubView)

function VersionActivity3_4PartyGameEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "logo/#simage_title")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_achievementpreview")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtshop = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._gotips = gohelper.findChild(self.viewGO, "entrance/#btn_store/tips")
	self._txttips = gohelper.findChildText(self.viewGO, "entrance/#btn_store/tips/#txt_tips")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goopen = gohelper.findChild(self.viewGO, "entrance/#btn_enter/go_open")
	self._gounopen = gohelper.findChild(self.viewGO, "entrance/#btn_enter/go_unopen")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")
	self._gonewunlock = gohelper.findChild(self.viewGO, "entrance/#go_newunlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_4PartyGameEnterView:addEvents()
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function VersionActivity3_4PartyGameEnterView:removeEvents()
	self._btnachievementpreview:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function VersionActivity3_4PartyGameEnterView:_btnachievementpreviewOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local curVersionActivityId = self.actId
		local config = ActivityConfig.instance:getActivityCo(curVersionActivityId)
		local jumpId = config.achievementJumpId

		JumpController.instance:jump(jumpId)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function VersionActivity3_4PartyGameEnterView:_btnstoreOnClick()
	PartyGameLobbyController.instance:enterStore(self:getPartyGameStoreId())
end

function VersionActivity3_4PartyGameEnterView:_btnenterOnClick()
	if self:_checkOpen() then
		if PartyGameLobbyController.instance:enterGameLobbyGuide() then
			return
		end

		PartyGameLobbyController.instance:enterGameLobby()
	else
		GameFacade.showToast(ToastEnum.PartyGameNotOpen)
	end
end

function VersionActivity3_4PartyGameEnterView:_checkOpen()
	if PartyGameLobbyEnum.FakeInCloseTime then
		logError("PartyGameLobbyEnum.FakeInCloseTime")

		return false
	end

	return OpenModel.instance:isFunctionUnlock(PartyGameLobbyEnum.DailyOpenId)
end

function VersionActivity3_4PartyGameEnterView:_btnFinishedOnClick()
	return
end

function VersionActivity3_4PartyGameEnterView:_btnLockedOnClick()
	return
end

function VersionActivity3_4PartyGameEnterView:getStoreActInfoMo()
	return ActivityModel.instance:getActivityInfo()[self:getPartyGameStoreId()]
end

function VersionActivity3_4PartyGameEnterView:getPartyGameStoreId()
	return VersionActivity3_4Enum.ActivityId.PartyGameStore
end

function VersionActivity3_4PartyGameEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId

	local storeActInfoMo = self:getStoreActInfoMo()

	self._txtshop.text = storeActInfoMo.config.name

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:refreshStoreCurrency()
	gohelper.setActive(self._gotips, false)
	PartyOutSideRpc.instance:sendGetPartyOutSideInfoRequest(self.actId, self._getOutSideInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity3_4PartyGameEnterView:_onCloseView(viewName)
	if viewName == ViewName.PartyGameLobbyLoadingView then
		local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if viewAnimator then
			viewAnimator:Play(UIAnimationName.Open, 0, 0)
		end
	end
end

function VersionActivity3_4PartyGameEnterView:_getOutSideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local configStr = PartyGameConfig.instance:getConstValue(17)
	local paramList = string.split(configStr, "|")
	local maxCount = tonumber(paramList[2])
	local haveExtraBonusCount = msg.haveExtraBonusCount

	if maxCount and haveExtraBonusCount < maxCount then
		self._txttips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("partygame_act_reward_tip"), haveExtraBonusCount, maxCount)

		gohelper.setActive(self._gotips, true)
	end
end

function VersionActivity3_4PartyGameEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity3_4PartyGameEnterView:everySecondCall()
	self:_refreshTime()

	local isOpen = self:_checkOpen()

	gohelper.setActive(self._goopen, isOpen)
	gohelper.setActive(self._gounopen, not isOpen)
end

function VersionActivity3_4PartyGameEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txttime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

function VersionActivity3_4PartyGameEnterView:onOpen()
	VersionActivity3_4PartyGameEnterView.super.onOpen(self)
	PartyGameLobbyController.instance:forceUpdateOpenInfo()
end

return VersionActivity3_4PartyGameEnterView
