-- chunkname: @modules/versionactivitybase/mainfixed/VersionActivityMainFixedDungeonEnterView.lua

module("modules.versionactivitybase.mainfixed.VersionActivityMainFixedDungeonEnterView", package.seeall)

local VersionActivityMainFixedDungeonEnterView = class("VersionActivityMainFixedDungeonEnterView", BaseView)

function VersionActivityMainFixedDungeonEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btnboard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Board")
	self._txtpapernum = gohelper.findChildTextMesh(self.viewGO, "#btn_Board/#txt_num")
	self._goboardreddot = gohelper.findChild(self.viewGO, "#btn_Board/#go_reddot")
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

function VersionActivityMainFixedDungeonEnterView:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self.refreshPaperCount, self)
	self._btnboard:AddClickListener(self._btnboardOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function VersionActivityMainFixedDungeonEnterView:removeEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self.refreshPaperCount, self)
	self._btnboard:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

function VersionActivityMainFixedDungeonEnterView:_onUpdateDungeonInfo()
	if self._hasPreviewFlag then
		self:refreshPreviewStatus()
	end

	self:_updateBg()
end

function VersionActivityMainFixedDungeonEnterView:onRefreshActivity(actId)
	if self._hasPreviewFlag then
		self:refreshPreviewStatus()
	end

	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivityMainFixedDungeonEnterView:_btnboardOnClick()
	CommandStationController.instance:openCommandStationPaperView()
end

function VersionActivityMainFixedDungeonEnterView:_btnstoreOnClick()
	VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openStoreView()
end

function VersionActivityMainFixedDungeonEnterView:_btnenterOnClick()
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
				VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openVersionActivityDungeonMapView()
			end, nil, nil)

			return
		end
	end

	VersionActivityMainFixedHelper.getVersionActivityDungeonController().instance:openVersionActivityDungeonMapView()
end

function VersionActivityMainFixedDungeonEnterView:_btnFinishedOnClick()
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function VersionActivityMainFixedDungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	self.animComp = VersionActivityMainFixedHelper.getVersionActivitySubAnimatorComp().get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivityMainFixedHelper.getVersionActivityEnum().ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._gobg = gohelper.findChild(self.viewGO, "#simage_bg")
	self._videoComp = VersionActivityVideoComp.get(gohelper.findChild(self.viewGO, "#simage_bg"), self)

	self:_setDesc()
	self:refreshDot()
	self:_updateBg()
end

function VersionActivityMainFixedDungeonEnterView:_updateBg()
	local versionFormat3 = VersionActivityMainFixedHelper.getVersionActivityVerFormat3(3, 8)

	if DungeonModel.instance:hasPassLevelAndStory(11115) then
		self._simagebg:LoadImage(string.format("singlebg/%s_mainactivity_singlebg/%s_enterview_fullbg.png", versionFormat3, versionFormat3))
	else
		self._simagebg:LoadImage(string.format("singlebg/%s_mainactivity_singlebg/%s_enterview_fullbg.png", versionFormat3, versionFormat3))
	end
end

function VersionActivityMainFixedDungeonEnterView:refreshDot()
	RedDotController.instance:addRedDot(self._goreddot, VersionActivityMainFixedHelper.getDungeonEnterReddot())
end

function VersionActivityMainFixedDungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivityMainFixedDungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function VersionActivityMainFixedDungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivityMainFixedDungeonEnterView:onOpenFinish()
	self._videoPath = VersionActivityMainFixedHelper.getVersionActivityEnum().EnterLoopVideoName

	if self.viewParam and self.viewParam.playVideo and self.viewContainer then
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self._videoComp:loadMedia(self._videoPath)

		self._fullviewParent = nil

		local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if container and container:isOpen() and container.viewGO then
			self._fullviewParent = container.viewGO.transform.parent

			gohelper.addChildPosStay(self._gobg, container.viewGO)
		end
	else
		self._videoComp:play(self._videoPath, true)
	end
end

function VersionActivityMainFixedDungeonEnterView:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self._videoComp:play(self._videoPath, true)
end

function VersionActivityMainFixedDungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function VersionActivityMainFixedDungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
	self:refreshPreviewStatus()
	self:refreshPaperCount()
end

function VersionActivityMainFixedDungeonEnterView:refreshPaperCount()
	local paperList = CommandStationConfig.instance:getPaperList()
	local preTotalNum = 0
	local nowTotalNum = 0
	local nowVersion = CommandStationConfig.instance:getCurVersionId()

	for _, v in ipairs(paperList) do
		if v.versionId == nowVersion then
			nowTotalNum = v.allNum

			break
		end

		preTotalNum = preTotalNum + v.allNum
	end

	local nowNum = CommandStationConfig.instance:getCurPaperCount() - preTotalNum

	nowNum = Mathf.Clamp(nowNum, 0, nowTotalNum)
	self._txtpapernum.text = string.format("%d/%d", nowNum, nowTotalNum)
end

function VersionActivityMainFixedDungeonEnterView:refreshPreviewStatus()
	gohelper.setActive(self._gonewunlock, false)
end

function VersionActivityMainFixedDungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityMainFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivityMainFixedDungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivityMainFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivityMainFixedDungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(VersionActivityMainFixedHelper.getActivityCurrency())

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivityMainFixedDungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivityMainFixedDungeonEnterView:onDestroyView()
	self.animComp:destroy()
	self._videoComp:destroy()

	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and container:isOpen() and container.viewGO and self._fullviewParent then
		gohelper.addChildPosStay(self._fullviewParent, container.viewGO)
	end
end

return VersionActivityMainFixedDungeonEnterView
