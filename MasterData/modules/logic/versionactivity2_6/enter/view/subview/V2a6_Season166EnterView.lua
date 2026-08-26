-- chunkname: @modules/logic/versionactivity2_6/enter/view/subview/V2a6_Season166EnterView.lua

module("modules.logic.versionactivity2_6.enter.view.subview.V2a6_Season166EnterView", package.seeall)

local V2a6_Season166EnterView = class("V2a6_Season166EnterView", VersionActivityEnterBaseSubView)

function V2a6_Season166EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goDesc = gohelper.findChild(self.viewGO, "#simage_FullBG/Dec")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Normal")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnInformation = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_information")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "#btn_information/#txt_coinNum")
	self._goinfoReddot = gohelper.findChild(self.viewGO, "#btn_information/#go_infoReddot")
	self._goinfoNewReddot = gohelper.findChild(self.viewGO, "#btn_information/#go_infoNewReddot")
	self._goinfoTime = gohelper.findChildText(self.viewGO, "#btn_information/#go_infoTime")
	self._txtinfoTime = gohelper.findChildText(self.viewGO, "#btn_information/#go_infoTime/#txt_time")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Normal/#image_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#btn_Locked/txt_Locked")
	self._txtLockedEn = gohelper.findChildText(self.viewGO, "#btn_Locked/txt_LockedEn")
	self._txtUnlockedTips = gohelper.findChildText(self.viewGO, "#btn_Locked/#txt_UnLockedTips")
	self._btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_End")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_Season166EnterView:addEvents()
	self._btnnormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnEnd:AddClickListener(self._btnEndOnClick, self)
	self._btnInformation:AddClickListener(self._btnInformationOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshInformationCoin, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function V2a6_Season166EnterView:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
	self._btnInformation:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshInformationCoin, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V2a6_Season166EnterView:_btnNormalOnClick()
	if self.actId ~= nil then
		local actMO = ActivityModel.instance:getActMO(self.actId)

		if actMO and actMO:isOpen() then
			local param = {}

			param.actId = self.actId

			Season166Controller.instance:openSeasonView(param)

			return
		end
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function V2a6_Season166EnterView:_btnLockedOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.Expired and toastId then
		GameFacade.showToast(toastId, toastParam)
	end
end

function V2a6_Season166EnterView:_btnEndOnClick()
	if self.isCloseEnter then
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function V2a6_Season166EnterView:_btnInformationOnClick()
	Activity166Rpc.instance:sendGet166InfosRequest(self.actId, function()
		ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
			actId = self.actId
		})
	end, self)
end

function V2a6_Season166EnterView:_editableInitView()
	self.descTab = self:getUserDataTb_()

	for i = 1, 3 do
		local desc = gohelper.findChildText(self.viewGO, "#simage_FullBG/Dec/go_desc" .. i .. "/txt_desc")

		table.insert(self.descTab, desc)
	end
end

function V2a6_Season166EnterView:onUpdateParam()
	return
end

function V2a6_Season166EnterView:onOpen()
	V2a6_Season166EnterView.super.onOpen(self)

	self.actId = VersionActivity2_6Enum.ActivityId.Season
	self.infoCoinId = Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.InfoCostId)

	local status = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		Activity166Rpc.instance:sendGet166InfosRequest(self.actId)
	end

	self.closeEnterTimeOffset = Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.CloseSeasonEnterTime)

	local bgUrl = Season166Config.instance:getSeasonConstStr(self.actId, Season166Enum.EnterViewBgUrl)

	self._simageFullBG:LoadImage(bgUrl)
	self:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, self.actId, self)
end

function V2a6_Season166EnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshEnterBtn()
	self:refreshDesc()
	self:refreshInformationCoin()
	self:refreshReddot()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function V2a6_Season166EnterView:refreshDesc()
	local actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	if not actConfig then
		gohelper.setActive(self._goDesc, false)
	else
		gohelper.setActive(self._goDesc, true)

		local descList = string.split(actConfig.actDesc, "#")

		for i = 1, #descList do
			if not self.descTab[i] then
				return
			end

			gohelper.setActive(self.descTab[i].gameObject, true)

			self.descTab[i].text = descList[i]
		end

		for i = #descList + 1, #self.descTab do
			gohelper.setActive(self.descTab[i].gameObject, false)
		end
	end
end

function V2a6_Season166EnterView:refreshEnterBtn()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isLock = status ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self._btnnormal.gameObject, not isLock and not self.isCloseEnter)
	gohelper.setActive(self._btnEnd.gameObject, not isLock and self.isCloseEnter)
	gohelper.setActive(self._btnLocked.gameObject, isLock)

	if toastId then
		local tip = ToastConfig.instance:getToastCO(toastId).tips

		tip = GameUtil.getSubPlaceholderLuaLang(tip, toastParam)
		self._txtUnlockedTips.text = tip
	else
		self._txtUnlockedTips.text = ""
	end

	gohelper.setActive(self._txtUnlockedTips.gameObject, status ~= ActivityEnum.ActivityStatus.Expired)

	self._txtLocked.text = luaLang("notOpen")
	self._txtLockedEn.text = "LOCKED"
end

function V2a6_Season166EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		self._txtLimitTime.text = ""

		gohelper.setActive(self._goinfoTime, false)

		return
	end

	self.isCloseEnter = self:checkIsCloseEnter(actInfoMo)

	local offsetSecond = self.enterCloseTime - ServerTime.now()
	local actRemainTime = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtLimitTime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")

	gohelper.setActive(self._goinfoTime, actRemainTime > 0)

	self._txtinfoTime.text = actInfoMo:getRemainTimeStr2ByEndTime(true)
end

function V2a6_Season166EnterView:checkIsCloseEnter(actInfoMo)
	local endTimeStamp = actInfoMo:getRealEndTimeStamp()
	local startTimeStamp = actInfoMo:getRealStartTimeStamp()
	local isActivityOline = endTimeStamp - ServerTime.now() > 0

	if self.closeEnterTimeOffset == 0 then
		self.enterCloseTime = endTimeStamp

		return false
	end

	self.enterCloseTime = startTimeStamp + self.closeEnterTimeOffset * TimeUtil.OneDaySecond

	local isEnterClose = ServerTime.now() > self.enterCloseTime

	return isActivityOline and isEnterClose
end

function V2a6_Season166EnterView:refreshInformationCoin()
	local currencyMO = CurrencyModel.instance:getCurrency(self.infoCoinId)

	self._txtcoinNum.text = GameUtil.numberDisplay(currencyMO.quantity)
end

function V2a6_Season166EnterView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Season166InformationMainView then
		self:refreshReddot()
	end
end

function V2a6_Season166EnterView:refreshReddot()
	RedDotController.instance:addRedDot(self._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, self.checkReddotShow, self)
end

function V2a6_Season166EnterView:checkReddotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local canShowNew = Season166Model.instance:checkHasNewUnlockInfo()

	if canShowNew then
		gohelper.setActive(self._goinfoNewReddot, true)
		gohelper.setActive(self._goinfoReddot, false)
	else
		gohelper.setActive(self._goinfoNewReddot, false)
		gohelper.setActive(self._goinfoReddot, true)
		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function V2a6_Season166EnterView:onDestroyView()
	V2a6_Season166EnterView.super.onDestroyView(self)
	self._simageFullBG:UnLoadImage()
end

return V2a6_Season166EnterView
