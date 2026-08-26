-- chunkname: @modules/logic/versionactivity1_9/enter/view/subview/V1a9_Season123EnterView.lua

module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_Season123EnterView", package.seeall)

local V1a9_Season123EnterView = class("V1a9_Season123EnterView", BaseView)

function V1a9_Season123EnterView:onInitView()
	self._goDesc = gohelper.findChild(self.viewGO, "Dec")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Normal")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#go_store/#btn_store")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "Store/#go_taglimit/#txt_limit")
	self._txtstoreCoinNum = gohelper.findChildText(self.viewGO, "Store/#go_store/#txt_num")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Normal/#image_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#btn_Locked/txt_Locked")
	self._txtLockedEn = gohelper.findChildText(self.viewGO, "#btn_Locked/txt_LockedEn")
	self._txtUnlockedTips = gohelper.findChildText(self.viewGO, "#btn_Locked/#txt_UnLockedTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a9_Season123EnterView:addEvents()
	self._btnnormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnstore:AddClickListener(self._btnStoreOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCoin, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
end

function V1a9_Season123EnterView:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCoin, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V1a9_Season123EnterView:_btnNormalOnClick()
	if self.actId ~= nil then
		local actMO = ActivityModel.instance:getActMO(self.actId)

		if actMO and actMO:isOpen() then
			Season123Controller.instance:openSeasonEntry({
				actId = self.actId
			})

			return
		end
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function V1a9_Season123EnterView:_btnLockedOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and toastId then
		GameFacade.showToast(toastId, toastParam)
	end
end

function V1a9_Season123EnterView:_btnStoreOnClick()
	Season123Controller.instance:openSeasonStoreView(self.actId)
end

function V1a9_Season123EnterView:_editableInitView()
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
	self.descTab = self:getUserDataTb_()

	for i = 1, 4 do
		local desc = gohelper.findChildText(self.viewGO, "Dec/txt_dec" .. i)

		table.insert(self.descTab, desc)
	end
end

function V1a9_Season123EnterView:onUpdateParam()
	return
end

function V1a9_Season123EnterView:onOpen()
	self.animComp:playOpenAnim()

	self.actId = VersionActivity1_9Enum.ActivityId.Season

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Season123Enter)
	self:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, self.actId, self)
end

function V1a9_Season123EnterView:refreshUI()
	self:refreshEnterBtn()
	self:refreshDesc()
	self:refreshStoreCoin()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function V1a9_Season123EnterView:refreshDesc()
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

function V1a9_Season123EnterView:refreshStoreCoin()
	local storeCoinId = Season123Config.instance:getSeasonConstNum(self.actId, Activity123Enum.Const.StoreCoinId)
	local currencyMO = CurrencyModel.instance:getCurrency(storeCoinId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstoreCoinNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function V1a9_Season123EnterView:refreshEnterBtn()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isLock = status ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self._btnnormal.gameObject, not isLock)
	gohelper.setActive(self._btnLocked.gameObject, isLock)

	if toastId then
		local tip = ToastConfig.instance:getToastCO(toastId).tips

		tip = GameUtil.getSubPlaceholderLuaLang(tip, toastParam)
		self._txtUnlockedTips.text = tip
	else
		self._txtUnlockedTips.text = ""
	end

	gohelper.setActive(self._txtUnlockedTips.gameObject, status ~= ActivityEnum.ActivityStatus.Expired)

	self._txtLocked.text = status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	self._txtLockedEn.text = status == ActivityEnum.ActivityStatus.Expired and "ENDED" or "LOCKED"
end

function V1a9_Season123EnterView:refreshRemainTime()
	self:refreshMainTime()
	self:refreshStoreTime()
end

function V1a9_Season123EnterView:refreshMainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		self._txtLimitTime.text = ""

		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtLimitTime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function V1a9_Season123EnterView:refreshStoreTime()
	local storeActId = Season123Config.instance:getSeasonConstNum(self.actId, Activity123Enum.Const.StoreActId)
	local actInfoMo = ActivityModel.instance:getActMO(storeActId)

	if not actInfoMo then
		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(storeActId)

	self._txtstoretime.text = status ~= ActivityEnum.ActivityStatus.Normal and toastId and (status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")) or actInfoMo:getRemainTimeStr2ByEndTime(true)
end

function V1a9_Season123EnterView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V1a9_Season123EnterView:onDestroyView()
	self.animComp:destroy()
end

return V1a9_Season123EnterView
