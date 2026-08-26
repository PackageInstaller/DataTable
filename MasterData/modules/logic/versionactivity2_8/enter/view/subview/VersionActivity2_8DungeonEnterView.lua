-- chunkname: @modules/logic/versionactivity2_8/enter/view/subview/VersionActivity2_8DungeonEnterView.lua

module("modules.logic.versionactivity2_8.enter.view.subview.VersionActivity2_8DungeonEnterView", package.seeall)

local VersionActivity2_8DungeonEnterView = class("VersionActivity2_8DungeonEnterView", BaseView)

function VersionActivity2_8DungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._gonewunlock = gohelper.findChild(self.viewGO, "entrance/#go_newunlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8DungeonEnterView:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function VersionActivity2_8DungeonEnterView:removeEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

function VersionActivity2_8DungeonEnterView:_onUpdateDungeonInfo()
	if self._hasPreviewFlag then
		self:refreshPreviewStatus()
	end
end

function VersionActivity2_8DungeonEnterView:onRefreshActivity(actId)
	if self._hasPreviewFlag then
		self:refreshPreviewStatus()
	end

	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivity2_8DungeonEnterView:_btnstoreOnClick()
	VersionActivity2_8DungeonController.instance:openStoreView()
end

function VersionActivity2_8DungeonEnterView:_btnenterOnClick()
	if self._hasPreviewFlag then
		local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.DungeonPreviewChapter, self._chapterId)

		PlayerPrefsHelper.setNumber(key, 1)
		self:refreshPreviewStatus()
	end

	if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(DungeonMainStoryEnum.Guide.EarlyAccess) then
		DungeonMainStoryModel.instance:setJumpFocusChapterId(self._chapterId)
		DungeonController.instance:enterDungeonView(true, true)

		return
	end

	if self._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(self._chapterId) then
		local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, self._chapterId)

		if not PlayerPrefsHelper.hasKey(key) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				VersionActivity2_8DungeonController.instance:openVersionActivityDungeonMapView()
			end, nil, nil)

			return
		end
	end

	VersionActivity2_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity2_8DungeonEnterView:_btnFinishedOnClick()
	return
end

function VersionActivity2_8DungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	self.actId = VersionActivity2_8Enum.ActivityId.Dungeon
	self.animComp = VersionActivity2_8SubAnimatorComp.get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivity2_8Enum.ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	self:refreshDot()
end

function VersionActivity2_8DungeonEnterView:refreshDot()
	local showReddot = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a8DungeonEnter, 0)

	gohelper.setActive(self._goreddot, showReddot)
end

function VersionActivity2_8DungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivity2_8DungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity2_8DungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivity2_8DungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_8DungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
	self:refreshPreviewStatus()
end

function VersionActivity2_8DungeonEnterView:refreshPreviewStatus()
	if self._chapterId then
		local showPreview = DungeonMainStoryModel.instance:showPreviewChapterFlag(self._chapterId)

		self._hasPreviewFlag = self._chapterId and not DungeonMainStoryModel.hasKey(PlayerPrefsKey.DungeonPreviewChapter, self._chapterId)

		gohelper.setActive(self._gonewunlock, self._hasPreviewFlag)
	end
end

function VersionActivity2_8DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_8Enum.ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivity2_8DungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	if not isNormal then
		local enterStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView)

		isNormal = enterStatus == ActivityEnum.ActivityStatus.Normal
	end

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivity2_8DungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a8Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity2_8DungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivity2_8DungeonEnterView:onDestroyView()
	self.animComp:destroy()
end

return VersionActivity2_8DungeonEnterView
