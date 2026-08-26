-- chunkname: @modules/logic/versionactivity2_4/enter/view/subview/VersionActivity2_4DungeonEnterView.lua

module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4DungeonEnterView", package.seeall)

local VersionActivity2_4DungeonEnterView = class("VersionActivity2_4DungeonEnterView", BaseView)

function VersionActivity2_4DungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "entrance/#btn_task/#go_reddot")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._imagestoreicon = gohelper.findChildSingleImage(self.viewGO, "entrance/#btn_store/normal/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4DungeonEnterView:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function VersionActivity2_4DungeonEnterView:removeEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

function VersionActivity2_4DungeonEnterView:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivity2_4DungeonEnterView:_btntaskOnClick()
	VersionActivity2_4DungeonController.instance:openTaskView()
end

function VersionActivity2_4DungeonEnterView:_btnstoreOnClick()
	VersionActivity2_4DungeonController.instance:openStoreView()
end

function VersionActivity2_4DungeonEnterView:_btnenterOnClick()
	VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity2_4DungeonEnterView:_btnFinishedOnClick()
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function VersionActivity2_4DungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self.actId = VersionActivity2_4Enum.ActivityId.Dungeon
	self.animComp = VersionActivity2_4SubAnimatorComp.get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivity2_4Enum.ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a4DungeonEnter)
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V2a4DungeonTask)
	gohelper.setActive(self._btntask.gameObject, false)

	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if currencyCfg then
		local currencyName = currencyCfg and currencyCfg.icon

		self._imagestoreicon:LoadImage(ResUrl.getCurrencyItemIcon(currencyName))
	end
end

function VersionActivity2_4DungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivity2_4DungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity2_4DungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivity2_4DungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_4DungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
end

function VersionActivity2_4DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivity2_4DungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivity2_4DungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity2_4DungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivity2_4DungeonEnterView:onDestroyView()
	self._imagestoreicon:UnLoadImage()
	self.animComp:destroy()
end

return VersionActivity2_4DungeonEnterView
