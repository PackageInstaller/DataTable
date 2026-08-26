-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainActExtraDisplay.lua

module("modules.logic.mainuiswitch.view.SwitchMainActExtraDisplay", package.seeall)

local SwitchMainActExtraDisplay = class("SwitchMainActExtraDisplay", BaseView)

function SwitchMainActExtraDisplay:onInitView()
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._btnrolestory = gohelper.findChildButton(self.viewGO, "right/#btn_rolestory")
	self._simagerolestory = gohelper.findChildSingleImage(self.viewGO, "right/#btn_rolestory/#simage_rolestory")
	self._imagerolestory = gohelper.findChildImage(self.viewGO, "right/#btn_rolestory/#simage_rolestory")
	self._gorolestoryred = gohelper.findChild(self.viewGO, "right/#btn_rolestory/#go_activityreddot")
	self._txtrolestory = gohelper.findChildTextMesh(self.viewGO, "right/#btn_rolestory/txt")
	self._gorolestorynew = gohelper.findChild(self.viewGO, "right/#btn_rolestory/new")
	self._btnreactivity = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_activityreprint")
	self._imagereactivity = gohelper.findChildImage(self.viewGO, "right/#btn_activityreprint/image_activityreprint")
	self._goreactivityred = gohelper.findChild(self.viewGO, "right/#btn_activityreprint/#go_activityreprintreddot")
	self._txtreactivity = gohelper.findChildTextMesh(self.viewGO, "right/#btn_activityreprint/txt")
	self._goreactivitynew = gohelper.findChild(self.viewGO, "right/#btn_activityreprint/new")
	self._goreactivitylocked = gohelper.findChild(self.viewGO, "right/#btn_activityreprint/#go_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SwitchMainActExtraDisplay:addEvents()
	return
end

function SwitchMainActExtraDisplay:removeEvents()
	return
end

function SwitchMainActExtraDisplay:_editableInitView()
	local seasonActivityConfig = ActivityConfig.instance:getSesonActivityConfig()
	local var_4_0

	if seasonActivityConfig then
		var_4_0 = seasonActivityConfig.id

		if not seasonActivityConfig.id then
			var_4_0 = Season123Model.instance:getCurSeasonId()
			var_4_0 = var_4_0 or Season166Model.instance:getCurSeasonId()
		end
	end

	self._seasonActId = var_4_0

	local rougeActivityConfig = ActivityConfig.instance:getRougeActivityConfig()

	self._rougeActId = rougeActivityConfig and rougeActivityConfig.id
	self._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	self._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	self._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	self:_initActs()
end

function SwitchMainActExtraDisplay:_initActs()
	self._actHandler = {}
	self._actGetStartTimeHandler = {}
	self._actClickHandler = {}
	self._actRefreshBtnHandler = {}

	self:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, self._getRoleStoryActivityStatus, self._getRoleStoryActivityStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Survival, self._getSurvivalStatus, self._getSurvivalStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, self._getReactivityStatus, self._getReactivityStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, self._getSeasonActivityStatus, self._getSeasonActivityStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, self._getRougeStatus, self._getRougeStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, self._getDouQuQuStatus, self._getDouQuQuStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Act178, self._getAct178Status, self._getAct178StartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Act182, self._getAct182Status, self._getAct182StartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, self._getWeekWalkHeartStatus, self._getWeekWalkHeartStartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Act191, self._getAct191Status, self._getAct191StartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Rouge2, self._getRouge2Status, self._getRouge2StartTime)
	self:_addActHandler(ActivityEnum.MainViewActivityState.Arcade, self._getArcadeStatus, self._getArcadeStartTime)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, self.refreshRoleStoryBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Survival, self.refreshSurvivalBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, self.refreshSeasonBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, self.refreshRougeBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, self.refreshDouQuQuBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, self.refreshAct178Btn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, self.refreshAct182Btn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, self.refreshWeekWalkHeartBtn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act191, self.refreshAct191Btn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge2, self.refreshRouge2Btn)
	self:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Arcade, self.refreshArcadeBtn)
	self:_initDefaultHandler()
end

function SwitchMainActExtraDisplay:_initDefaultHandler()
	for _, id in pairs(ActivityEnum.MainViewActivityState) do
		if id >= ActivityEnum.MainViewActivityState.PartyGame then
			self._actHandler[id] = self._actHandler[id] or self._getCommonActStatus
			self._actGetStartTimeHandler[id] = self._actGetStartTimeHandler[id] or self._getCommonActStartTime
			self._actClickHandler[id] = self._actClickHandler[id] or self._onCommonActClick
			self._actRefreshBtnHandler[id] = self._actRefreshBtnHandler[id] or self._refreshCommonActBtn
		end
	end
end

function SwitchMainActExtraDisplay:_addRefreshBtnHandler(id, handler)
	self._actRefreshBtnHandler[id] = handler
end

function SwitchMainActExtraDisplay:_addClickHandler(id, handler)
	self._actClickHandler[id] = handler
end

function SwitchMainActExtraDisplay:_addActHandler(id, getActStatusHandler, getStartTimeHandler)
	self._actHandler[id] = getActStatusHandler
	self._actGetStartTimeHandler[id] = getStartTimeHandler
end

function SwitchMainActExtraDisplay:_getSeasonActivityStatus()
	local seasonActId = self._seasonActId
	local status = seasonActId and ActivityHelper.getActivityStatus(seasonActId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getSeasonActivityStartTime()
	local seasonActId = self._seasonActId

	return seasonActId and ActivityModel.instance:getActStartTime(seasonActId)
end

function SwitchMainActExtraDisplay:_getReactivityStatus()
	local reactivityActId = ReactivityController.instance:getCurReactivityId()
	local define = reactivityActId and ReactivityEnum.ActivityDefine[reactivityActId]
	local storeActId = define and define.storeActId
	local reactivityStatus = storeActId and ActivityHelper.getActivityStatus(storeActId)

	return reactivityStatus == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getReactivityStartTime()
	local reactivityActId = ReactivityController.instance:getCurReactivityId()
	local define = ReactivityEnum.ActivityDefine[reactivityActId]
	local storeActId = define and define.storeActId

	if storeActId then
		::label_13_0::

		local reactivityMo = ActivityModel.instance:getActMO(storeActId)

		return reactivityMo and reactivityMo:getRealStartTimeStamp() * 1000
	end
end

function SwitchMainActExtraDisplay:_getRoleStoryActivityStatus()
	local storyId = RoleStoryModel.instance:getCurActStoryId()

	return storyId and storyId > 0 or false
end

function SwitchMainActExtraDisplay:_getRoleStoryActivityStartTime()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local hasStory = storyId and storyId > 0 or false

	if hasStory then
		::label_15_0::

		local storyMo = RoleStoryModel.instance:getMoById(storyId)

		return storyMo and storyMo:getActTime() * 1000
	end
end

function SwitchMainActExtraDisplay:_getRougeStatus()
	local actId = self._rougeActId
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getRougeStartTime()
	local actId = self._rougeActId
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getSurvivalStatus()
	local actId = SurvivalModel.instance:getCurVersionActivityId()
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getSurvivalStartTime()
	local actId = SurvivalModel.instance:getCurVersionActivityId()
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getDouQuQuStatus()
	local actId = self._douququActId
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getDouQuQuStartTime()
	local actId = self._douququActId
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getAct178Status()
	local actId = self._act178ActId
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getAct178StartTime()
	local actId = self._act178ActId
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getAct182Status()
	local actId = self._act182ActId
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getAct182StartTime()
	local actId = self._act182ActId
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getWeekWalkHeartStatus()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getWeekWalkHeartStartTime()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getAct191Status()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getAct191StartTime()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getRouge2Status()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Rouge2)
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getRouge2StartTime()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Rouge2)
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getArcadeStatus()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Arcade)
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getArcadeStartTime()
	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Arcade)
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_getCommonActStatus(id)
	local actId = self:_getBindActivityId(id)
	local status = actId and ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Normal
end

function SwitchMainActExtraDisplay:_getCommonActStartTime(id)
	local actId = self:_getBindActivityId(id)
	local actMo = ActivityModel.instance:getActMO(actId)

	return actMo and actMo:getRealStartTimeStamp() * 1000
end

function SwitchMainActExtraDisplay:_onStoryChange()
	self:onRefreshActivityState()
end

function SwitchMainActExtraDisplay:_onStoryNewChange()
	self:refreshRoleStoryRed()
end

function SwitchMainActExtraDisplay:_roleStoryLoadImage(path, callback, callbackTarget)
	if string.nilorempty(path) then
		logError("SwitchMainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	self._simagerolestory:LoadImage(path, callback, callbackTarget)
end

function SwitchMainActExtraDisplay:refreshRougeBtn()
	gohelper.setActive(self._btnrolestory, true)

	local activityConfig = ActivityConfig.instance:getRougeActivityConfig()

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("mainview_rougeactextradisplay"), activityConfig.tabName)
end

function SwitchMainActExtraDisplay:refreshDouQuQuBtn()
	gohelper.setActive(self._btnrolestory, true)

	local activityConfig = ActivityConfig.instance:getActivityCo(self._douququActId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshSurvivalBtn()
	gohelper.setActive(self._btnrolestory, true)

	local curVersionActivityId = SurvivalModel.instance:getCurVersionActivityId()
	local activityConfig = ActivityConfig.instance:getActivityCo(curVersionActivityId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshAct178Btn()
	gohelper.setActive(self._btnrolestory, true)

	local activityConfig = ActivityConfig.instance:getActivityCo(self._act178ActId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshAct182Btn()
	gohelper.setActive(self._btnrolestory, true)

	local activityConfig = ActivityConfig.instance:getActivityCo(self._act182ActId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshWeekWalkHeartBtn()
	gohelper.setActive(self._btnrolestory, true)

	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	local config = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.WeekWalkHeartShow)

	self._txtrolestory.text = config.name
end

function SwitchMainActExtraDisplay:refreshAct191Btn()
	gohelper.setActive(self._btnrolestory, true)

	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshRouge2Btn()
	gohelper.setActive(self._btnrolestory, true)

	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Rouge2)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""
end

function SwitchMainActExtraDisplay:refreshArcadeBtn()
	gohelper.setActive(self._btnrolestory, true)

	local actId = self:_getBindActivityId(ActivityEnum.MainViewActivityState.Arcade)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = ""

	local activityCo = ActivityConfig.instance:getActivityCo(actId)

	RedDotController.instance:addRedDot(self._gorolestoryred, activityCo.redDotId)

	local hasNew = ActivityStageHelper.checkOneActivityStageHasChange(actId)

	gohelper.setActive(self._gorolestorynew, hasNew)
	gohelper.setActive(self._gorolestoryred, not hasNew)
end

function SwitchMainActExtraDisplay:onLoadImage()
	self._imagerolestory:SetNativeSize()
end

function SwitchMainActExtraDisplay:refreshSeasonBtn()
	gohelper.setActive(self._btnrolestory, true)

	local activityConfig = ActivityConfig.instance:getSesonActivityConfig()

	self._roleStoryLoadImage(self, activityConfig.extraDisplayIcon, self.onLoadImage, self)

	self._txtrolestory.text = activityConfig.name

	local actId = self._seasonActId
	local activityCo = ActivityConfig.instance:getActivityCo(actId)

	RedDotController.instance:addRedDot(self._gorolestoryred, activityCo.redDotId)

	local hasNew = ActivityStageHelper.checkOneActivityStageHasChange(actId)

	gohelper.setActive(self._gorolestorynew, hasNew)
	gohelper.setActive(self._gorolestoryred, not hasNew)
end

function SwitchMainActExtraDisplay:refreshRoleStoryBtn()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local hasStory = storyId > 0

	gohelper.setActive(self._btnrolestory, hasStory)

	if hasStory then
		local co = RoleStoryConfig.instance:getStoryById(storyId)

		self._roleStoryLoadImage(self, string.format("singlebg/dungeon/rolestory_singlebg/%s.png", co.main_pic), self.onLoadImage, self)

		local storyName = co.mainviewName

		if string.nilorempty(storyName) then
			storyName = co.name
		end

		self._txtrolestory.text = storyName

		RedDotController.instance:addRedDot(self._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	self:refreshRoleStoryRed()
end

function SwitchMainActExtraDisplay:refreshRoleStoryRed()
	if self.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local hasStory = storyId > 0

	if not hasStory then
		return
	end

	local storyMo = RoleStoryModel.instance:getMoById(storyId)
	local actId = storyMo.cfg.activityId
	local hasNew = ActivityStageHelper.checkOneActivityStageHasChange(actId)

	gohelper.setActive(self._gorolestorynew, hasNew)
	gohelper.setActive(self._gorolestoryred, not hasNew)
end

function SwitchMainActExtraDisplay:refreshReactivityBtn()
	local actId = ReactivityController.instance:getCurReactivityId()
	local status = actId and ActivityHelper.getActivityStatusAndToast(actId)
	local reactivityShow = self.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(self._btnreactivity, reactivityShow)

	if reactivityShow then
		local actCo = ActivityConfig.instance:getActivityCo(actId)

		if actCo then
			self._txtreactivity.text = actCo.name or ""
		end

		local hasNew = status == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(actId)

		gohelper.setActive(self._goreactivityred, not hasNew)
		gohelper.setActive(self._goreactivitynew, hasNew)
		gohelper.setActive(self._goreactivitylocked, status == ActivityEnum.ActivityStatus.NotUnlock)
		self:addReactivityRed()
	end
end

function SwitchMainActExtraDisplay:addReactivityRed()
	local actId = ReactivityController.instance:getCurReactivityId()

	if actId then
		local actCo = ActivityConfig.instance:getActivityCo(actId)

		if actCo and actCo.redDotId > 0 then
			RedDotController.instance:addRedDot(self._goreactivityred, actCo.redDotId)
		end
	end
end

function SwitchMainActExtraDisplay:checkShowActivityEnter()
	local showState = ActivityEnum.MainViewActivityState.None

	self._curActDisplayConfig = nil

	local lastStartTime = 0
	local actList = ActivityConfig.instance:getMainActExtraDisplayList()

	for i, v in ipairs(actList) do
		local handler = self._actHandler[v.id]

		if not handler then
			logError("SwitchMainActExtraDisplay 活动没有对应的handler id:" .. tostring(v.id))
		end

		if handler and handler(self) then
			local getStartTimeHandler = self._actGetStartTimeHandler[v.id]
			local time = getStartTimeHandler(self)

			if lastStartTime <= time then
				lastStartTime = time
				showState = v.id
				self._curActDisplayConfig = v
			end
		end
	end

	self.activityShowState = showState

	recthelper.setAnchorY(self._goright.transform, self.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)

	if SLFramework.FrameworkSettings.IsEditor then
		logNormal("SwitchMainActExtraDisplay:checkShowActivityEnter showState:" .. tostring(showState))
	end
end

function SwitchMainActExtraDisplay:check2_0DungeonReddot()
	local status = ActivityHelper.getActivityStatus(VersionActivity2_0Enum.ActivityId.Dungeon)

	if status == ActivityEnum.ActivityStatus.Normal then
		Activity161Controller.instance:checkHasUnDoElement()
	end
end

function SwitchMainActExtraDisplay:_getCurBindActivityId()
	return self:_getBindActivityId(self.activityShowState)
end

function SwitchMainActExtraDisplay:_getBindActivityId(showState)
	local config = ActivityConfig.instance:getActivityByExtraDisplayId(showState)

	return config and config.id
end

function SwitchMainActExtraDisplay:onRefreshActivityState()
	self:checkShowActivityEnter()
	self:refreshReactivityBtn()
	self:_refreshBtns()
	self:check2_0DungeonReddot()
end

function SwitchMainActExtraDisplay:_refreshBtns()
	gohelper.setActive(self._btnrolestory, false)

	if not self._curActDisplayConfig then
		return
	end

	local handler = self._actRefreshBtnHandler[self.activityShowState]

	if handler then
		handler(self)
	end
end

function SwitchMainActExtraDisplay:onOpen()
	local isHide = self.viewParam.hideExtraDisPlay

	self:hideExtraDisPlay(isHide)

	if isHide then
		return
	end

	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.StoryNewChange, self._onStoryNewChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.onRefreshActivityState, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.ChangeActivityStage, self.onRefreshActivityState, self)

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(self._goright, false)
	end

	self:onRefreshActivityState()
	self:showKeyTips()
end

function SwitchMainActExtraDisplay:hideExtraDisPlay(isHide)
	gohelper.setActive(self._btnrolestory.gameObject, not isHide)
	gohelper.setActive(self._btnreactivity.gameObject, not isHide)
end

function SwitchMainActExtraDisplay:showKeyTips()
	self._keytipsReactivity = gohelper.findChild(self._btnreactivity.gameObject, "#go_pcbtn")
	self._keytipsRoleStory = gohelper.findChild(self._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(self._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(self._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function SwitchMainActExtraDisplay:onClose()
	return
end

function SwitchMainActExtraDisplay:onDestroyView()
	if self._simagerolestory then
		self._simagerolestory:UnLoadImage()
	end

	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.StoryNewChange, self._onStoryNewChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self.onRefreshActivityState, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.ChangeActivityStage, self.onRefreshActivityState, self)
end

return SwitchMainActExtraDisplay
