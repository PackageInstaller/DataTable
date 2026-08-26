-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivity1_9EnterViewBaseTabItem.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewBaseTabItem", package.seeall)

local VersionActivity1_9EnterViewBaseTabItem = class("VersionActivity1_9EnterViewBaseTabItem", UserDataDispose)

function VersionActivity1_9EnterViewBaseTabItem:init(index, actMo, go)
	self:__onInit()

	self.index = index
	self.actMo = actMo
	self.rootGo = go
	self.redDotUid = actMo.redDotUid or 0
	self.storeId = actMo.storeId

	self:updateActId()
	gohelper.setActive(self.rootGo, true)

	self.rectTr = self.rootGo:GetComponent(gohelper.Type_RectTransform)
	self.goSelected = gohelper.findChild(self.rootGo, "#go_select")
	self.goUnselected = gohelper.findChild(self.rootGo, "#go_unselect")
	self.imageUnSelectTabIcon = gohelper.findChildImage(self.rootGo, "#go_unselect/#image_tabicon")
	self.imageSelectTabIcon = gohelper.findChildImage(self.rootGo, "#go_select/#image_tabicon")
	self.goTag = gohelper.findChild(self.rootGo, "#go_tag")
	self.goTagNewAct = gohelper.findChild(self.rootGo, "#go_tag/#go_newact")
	self.goTagNewLevel = gohelper.findChild(self.rootGo, "#go_tag/#go_newlevel")
	self.goTagTime = gohelper.findChild(self.rootGo, "#go_tag/#go_time")
	self.goTagLock = gohelper.findChild(self.rootGo, "#go_tag/#go_lock")
	self.txtTime = gohelper.findChildText(self.goTagTime, "bg/#txt_time")
	self.txtLock = gohelper.findChildText(self.goTagLock, "bg/#txt_lock")
	self.goRedDot = gohelper.findChild(self.rootGo, "#go_reddot")
	self.click = gohelper.getClickWithDefaultAudio(self.rootGo)

	self.click:AddClickListener(self.onClickSelf, self)

	self.animator = self.rootGo:GetComponent(gohelper.Type_Animator)

	self:_editableInitView()
end

function VersionActivity1_9EnterViewBaseTabItem:updateActId()
	local actId = VersionActivityEnterHelper.getActId(self.actMo)

	if actId == self.actId then
		return false
	end

	self.actId = actId
	self.activityCo = ActivityConfig.instance:getActivityCo(self.actId)

	return true
end

function VersionActivity1_9EnterViewBaseTabItem:_editableInitView()
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.refreshTag, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.refreshSelect, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TaskDispatcher.runRepeat(self.refreshTag, self, TimeUtil.OneMinuteSecond)
	self:refreshData()
end

function VersionActivity1_9EnterViewBaseTabItem:refreshData()
	local iconCoArr = string.split(self.activityCo.tabBgPath, "#")

	UISpriteSetMgr.instance:setV1a9MainActivitySprite(self.imageSelectTabIcon, iconCoArr[1])
	UISpriteSetMgr.instance:setV1a9MainActivitySprite(self.imageUnSelectTabIcon, iconCoArr[2])

	if self.redDotIcon then
		self.redDotIcon:setId(self.activityCo.redDotId, self.redDotUid)
	else
		self.redDotIcon = RedDotController.instance:addRedDot(self.goRedDot, self.activityCo.redDotId, self.redDotUid)
	end
end

function VersionActivity1_9EnterViewBaseTabItem:onClickSelf()
	if self.isSelect then
		return
	end

	if self.handleFunc then
		self.handleFunc(self.handleFuncObj, self)

		return
	end

	if not self.storeId then
		local checkActId = self.actId
		local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(checkActId)

		if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
			self.animator:Play("click", 0, 0)
			VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, self.actId, self)

			return
		end

		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
	end
end

function VersionActivity1_9EnterViewBaseTabItem:overrideOnClickHandle(handleFunc, handleFuncObj)
	self.handleFunc = handleFunc
	self.handleFuncObj = handleFuncObj
end

function VersionActivity1_9EnterViewBaseTabItem:refreshSelect(actId)
	self.isSelect = actId == self.actId

	gohelper.setActive(self.goSelected, self.isSelect)
	gohelper.setActive(self.goUnselected, not self.isSelect)
end

function VersionActivity1_9EnterViewBaseTabItem:refreshUI()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self.goRedDot, status == ActivityEnum.ActivityStatus.Normal)
	self:refreshTag()
end

function VersionActivity1_9EnterViewBaseTabItem:refreshTag()
	self:clearTag()

	local status = ActivityHelper.getActivityStatus(self.actId)

	if status == ActivityEnum.ActivityStatus.Normal then
		self:refreshNormalTag()
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		self:refreshNotUnlockTag()
	else
		self:refreshLockTag()
	end
end

function VersionActivity1_9EnterViewBaseTabItem:refreshLockTag()
	gohelper.setActive(self.goTagLock, true)

	local status = ActivityHelper.getActivityStatus(self.actId)

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

		self.txtLock.text = actInfoMo:getRemainTimeStr2ByOpenTime()
	else
		gohelper.setActive(self.goTagLock, false)
	end
end

function VersionActivity1_9EnterViewBaseTabItem:refreshNormalTag()
	if not ActivityEnterMgr.instance:isEnteredActivity(self.actId) then
		gohelper.setActive(self.goTagNewAct, true)

		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo and actInfoMo:isNewStageOpen() then
		gohelper.setActive(self.goTagNewLevel, true)

		return
	end

	if VersionActivity1_9Enum.ActId2ShowRemainTimeDict[self.actId] and actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > VersionActivity1_9Enum.MaxShowTimeOffset then
			return
		end

		gohelper.setActive(self.goTagTime, true)

		self.txtTime.text = actInfoMo:getRemainTimeStr2ByEndTime()
	end
end

function VersionActivity1_9EnterViewBaseTabItem:refreshNotUnlockTag()
	gohelper.setActive(self.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(self.actId) then
		gohelper.setActive(self.goTagNewAct, true)
	end
end

function VersionActivity1_9EnterViewBaseTabItem:clearTag()
	gohelper.setActive(self.goTagNewAct, false)
	gohelper.setActive(self.goTagNewLevel, false)
	gohelper.setActive(self.goTagTime, false)
	gohelper.setActive(self.goTagLock, false)
end

function VersionActivity1_9EnterViewBaseTabItem:onRefreshActivity(actId)
	if self.actId ~= actId then
		return
	end

	self:refreshTag()
end

function VersionActivity1_9EnterViewBaseTabItem:isShowRedDot()
	return self.redDotIcon and self.redDotIcon.show
end

function VersionActivity1_9EnterViewBaseTabItem:getAnchorY()
	return recthelper.getAnchorY(self.rectTr)
end

function VersionActivity1_9EnterViewBaseTabItem:dispose()
	TaskDispatcher.cancelTask(self.refreshTag, self)
	self.click:RemoveClickListener()
	self:__onDispose()
end

return VersionActivity1_9EnterViewBaseTabItem
