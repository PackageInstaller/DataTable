-- chunkname: @modules/logic/versionactivity3_0/enter/view/subview/VersionActivity3_0_v2a1_ReactivityEnterview.lua

module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0_v2a1_ReactivityEnterview", package.seeall)

local VersionActivity3_0_v2a1_ReactivityEnterview = class("VersionActivity3_0_v2a1_ReactivityEnterview", ReactivityEnterview)

function VersionActivity3_0_v2a1_ReactivityEnterview:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "actbg/#txt_time")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "entrance/#btn_task/#go_reddot")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_0_v2a1_ReactivityEnterview:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btnreplay:AddClickListener(self._onClickReplay, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:removeEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_btntaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity3_0Enum.ActivityId.Reactivity)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_btnstoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity3_0Enum.ActivityId.Reactivity)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_btnenterOnClick()
	VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_btnFinishedOnClick()
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self.actId = VersionActivity2_1Enum.ActivityId.Dungeon
	self.animComp = VersionActivity2_1SubAnimatorComp.get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivity3_0Enum.ActivityId.Reactivity
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a1DungeonEnter)
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V2a1DungeonTask)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivity3_0_v2a1_ReactivityEnterview:onUpdateParam()
	self:refreshUI()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:onOpen()
	self:refreshUI()
	Activity165Model.instance:onInitInfo()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:everyMinuteCall()
	self:refreshUI()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
end

function VersionActivity3_0_v2a1_ReactivityEnterview:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self._txttime.text = actInfoMo:getRemainTimeStr3(false, false)

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_0Enum.ActivityId.ReactivityStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.ReactivityStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a1Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity3_0_v2a1_ReactivityEnterview:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivity3_0_v2a1_ReactivityEnterview:onDestroyView()
	self.animComp:destroy()
end

return VersionActivity3_0_v2a1_ReactivityEnterview
