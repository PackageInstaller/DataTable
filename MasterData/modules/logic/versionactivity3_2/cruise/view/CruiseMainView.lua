-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseMainView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseMainView", package.seeall)

local CruiseMainView = class("CruiseMainView", BaseView)

function CruiseMainView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "Title/image_timebg/#txt_time")
	self._goopen = gohelper.findChild(self.viewGO, "#go_open")
	self._godoll = gohelper.findChild(self.viewGO, "#go_open/#go_doll")
	self._golevel1 = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level1")
	self._golevel2 = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level2")
	self._golevel3 = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level3")
	self._golevel4 = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level4")
	self._golevel5 = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level5")
	self._gochange = gohelper.findChild(self.viewGO, "#go_open/#go_doll/node_change")
	self._gocompleteeff = gohelper.findChild(self.viewGO, "simage_dec")
	self._btnceremony = gohelper.findChildButtonWithAudio(self.viewGO, "#go_open/#btn_ceremony")
	self._goceremonylock = gohelper.findChild(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonylock")
	self._txtceremonylockrewardnum = gohelper.findChildText(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonylock/numbg/#txt_ceremonylockrewardnum")
	self._txtceremonylocktime = gohelper.findChildText(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonylock/image_timebg/#txt_ceremonylocktime")
	self._goceremonyunlock = gohelper.findChild(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonyunlock")
	self._txtceremonyunlockrewardnum = gohelper.findChildText(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonyunlock/numbg/#txt_ceremonyunlockrewardnum")
	self._txtceremonyunlocktime = gohelper.findChildText(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonyunlock/image_timebg/#txt_ceremonyunlocktime")
	self._goceremonyreceive = gohelper.findChild(self.viewGO, "#go_open/#btn_ceremony/#go_ceremonyunlock/#go_ceremonyreceive")
	self._goreddotceremony = gohelper.findChild(self.viewGO, "#go_open/#btn_ceremony/#go_reddotceremony")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_replay")
	self._btnglobaltask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_globaltask")
	self._goflowerRoot = gohelper.findChild(self.viewGO, "#btn_globaltask/simage_dec")
	self._goglobaltasklock = gohelper.findChild(self.viewGO, "#btn_globaltask/#go_globaltasklock")
	self._txtglobaltasklocktime = gohelper.findChildText(self.viewGO, "#btn_globaltask/#go_globaltasklock/image_timebg/#txt_globaltasklocktime")
	self._goglobaltaskunlock = gohelper.findChild(self.viewGO, "#btn_globaltask/#go_globaltaskunlock")
	self._txtglobaltaskunlocktime = gohelper.findChildText(self.viewGO, "#btn_globaltask/#go_globaltaskunlock/image_timebg/#txt_globaltaskunlocktime")
	self._goglobaltaskfinish = gohelper.findChild(self.viewGO, "#btn_globaltask/#go_globaltaskfinish")
	self._goreddotglobaltask = gohelper.findChild(self.viewGO, "#btn_globaltask/#go_reddotglobaltask")
	self._btnselftask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_selftask")
	self._goselftasklock = gohelper.findChild(self.viewGO, "#btn_selftask/#go_selftasklock")
	self._txtselftasklocktime = gohelper.findChildText(self.viewGO, "#btn_selftask/#go_selftasklock/image_timebg/#txt_selftasklocktime")
	self._goselftaskunlock = gohelper.findChild(self.viewGO, "#btn_selftask/#go_selftaskunlock")
	self._txtselftaskunlocktime = gohelper.findChildText(self.viewGO, "#btn_selftask/#go_selftaskunlock/image_timebg/#txt_selftaskunlocktime")
	self._goreddotselftask = gohelper.findChild(self.viewGO, "#btn_selftask/#go_reddotselftask")
	self._btngame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_game")
	self._gogamelock = gohelper.findChild(self.viewGO, "#btn_game/#go_gamelock")
	self._txtgamelocktime = gohelper.findChildText(self.viewGO, "#btn_game/#go_gamelock/image_timebg/#txt_gamelocktime")
	self._gogameunlock = gohelper.findChild(self.viewGO, "#btn_game/#go_gameunlock")
	self._txtgameunlocktime = gohelper.findChildText(self.viewGO, "#btn_game/#go_gameunlock/image_timebg/#txt_gameunlocktime")
	self._gogamefinish = gohelper.findChild(self.viewGO, "#btn_game/#go_gamefinish")
	self._goreddotgame = gohelper.findChild(self.viewGO, "#btn_game/#go_reddotgame")
	self._btndungeon = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_dungeon")
	self._godungeonlock = gohelper.findChild(self.viewGO, "#btn_dungeon/#go_dungeonlock")
	self._txtdungeonlocktime = gohelper.findChildText(self.viewGO, "#btn_dungeon/#go_dungeonlock/image_timebg/#txt_dungeonlocktime")
	self._godungeonunlock = gohelper.findChild(self.viewGO, "#btn_dungeon/#go_dungeonunlock")
	self._txtdungeonunlocktime = gohelper.findChildText(self.viewGO, "#btn_dungeon/#go_dungeonunlock/image_timebg/#txt_dungeonunlocktime")
	self._godungeonfinish = gohelper.findChild(self.viewGO, "#btn_dungeon/#go_dungeonfinish")
	self._goreddotdungeon = gohelper.findChild(self.viewGO, "#btn_dungeon/#go_reddotdungeon")
	self._btnguest = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_guest")
	self._txtguesttime = gohelper.findChildText(self.viewGO, "#btn_guest/image_timebg/#txt_guesttime")
	self._goguestcanget = gohelper.findChild(self.viewGO, "#btn_guest/#go_guestcanget")
	self._goguestreceive = gohelper.findChild(self.viewGO, "#btn_guest/#go_guestreceive")
	self._goreddotguest = gohelper.findChild(self.viewGO, "#btn_guest/#go_reddotguest")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseMainView:addEvents()
	self._btnceremony:AddClickListener(self._btnceremonyOnClick, self)
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnglobaltask:AddClickListener(self._btnglobaltaskOnClick, self)
	self._btnselftask:AddClickListener(self._btnselftaskOnClick, self)
	self._btngame:AddClickListener(self._btngameOnClick, self)
	self._btndungeon:AddClickListener(self._btndungeonOnClick, self)
	self._btnguest:AddClickListener(self._btnguestOnClick, self)
end

function CruiseMainView:removeEvents()
	self._btnceremony:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btnglobaltask:RemoveClickListener()
	self._btnselftask:RemoveClickListener()
	self._btngame:RemoveClickListener()
	self._btndungeon:RemoveClickListener()
	self._btnguest:RemoveClickListener()
end

function CruiseMainView:_btnceremonyOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	CruiseController.instance:openCruiseOpenCeremonyView()
end

function CruiseMainView:_btnreplayOnClick()
	local storyId = CommonConfig.instance:getConstNum(ConstEnum.CruiseMainStory)

	StoryController.instance:playStory(storyId)
end

function CruiseMainView:_btnglobaltaskOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	CruiseController.instance:openCruiseGlobalTaskView()
end

function CruiseMainView:_btnselftaskOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	CruiseController.instance:openCruiseSelfTaskView()
end

function CruiseMainView:_btngameOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	CruiseController.instance:openCruiseGameView()
end

function CruiseMainView:_btndungeonOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseTripleDrop
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	CruiseController.instance:openCruiseTripleDropView()
end

function CruiseMainView:_btnguestOnClick()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	CruiseController.instance:openCruiseSummonNewCustomPickFullView()
end

function CruiseMainView:_onOpenView(viewName)
	if viewName == ViewName.SummonView then
		gohelper.setActive(self.viewGO, false)
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	end
end

function CruiseMainView:_onCloseView(viewName)
	if viewName == ViewName.SummonView then
		gohelper.setActive(self.viewGO, true)
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	end
end

function CruiseMainView:_editableInitView()
	self:_checkPlayStory()

	self._actId = VersionActivity3_2Enum.ActivityId.CruiseMain
	self._golvs = {}

	for i = 1, 5 do
		local go = gohelper.findChild(self.viewGO, "#go_open/#go_doll/#go_level" .. tostring(i))

		table.insert(self._golvs, go)
	end

	self._globalTaskAnim = self._goflowerRoot:GetComponent(typeof(UnityEngine.Animator))

	self:_addSelfEvents()
end

function CruiseMainView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnMsgInfoChange, self._refresh, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnReceiveAcceptRewardReply, self._refresh, self)
	self.addEventCb(self, Activity216Controller.instance, Activity216Event.onInfoChanged, self._refresh, self)
	self.addEventCb(self, Activity216Controller.instance, Activity216Event.onTaskInfoUpdate, self._refresh, self)
	self.addEventCb(self, Activity216Controller.instance, Activity216Event.onBonusStateChange, self._refresh, self)
	self.addEventCb(self, Activity215Controller.instance, Activity215Event.onItemSubmitCountChange, self._refresh, self)
	self.addEventCb(self, Activity215Controller.instance, Activity215Event.OnInfoChanged, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseMainView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.removeEventCb(self, Activity218Controller.instance, Activity218Event.OnMsgInfoChange, self._refresh, self)
	self.removeEventCb(self, Activity218Controller.instance, Activity218Event.OnReceiveAcceptRewardReply, self._refresh, self)
	self.removeEventCb(self, Activity216Controller.instance, Activity216Event.onInfoChanged, self._refresh, self)
	self.removeEventCb(self, Activity216Controller.instance, Activity216Event.onTaskInfoUpdate, self._refresh, self)
	self.removeEventCb(self, Activity216Controller.instance, Activity216Event.onBonusStateChange, self._refresh, self)
	self.removeEventCb(self, Activity215Controller.instance, Activity215Event.onItemSubmitCountChange, self._refresh, self)
	self.removeEventCb(self, Activity215Controller.instance, Activity215Event.OnInfoChanged, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function CruiseMainView:_onCheckActState()
	self:_refresh()

	local guestActId = ActivityEnum.Activity.V3a2_SummonCustomPickNew
	local guestStatus = ActivityHelper.getActivityStatus(guestActId)

	if guestStatus == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	local actId = VersionActivity3_2Enum.ActivityId.CruiseMain
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function CruiseMainView:onUpdateParam()
	return
end

function CruiseMainView:onOpen()
	RedDotController.instance:addRedDot(self._goreddotgame, RedDotEnum.DotNode.CruiseGameRoot)
	RedDotController.instance:addRedDot(self._goreddotglobaltask, RedDotEnum.DotNode.CruiseGlobalTaskBtn)
	RedDotController.instance:addRedDot(self._goreddotselftask, RedDotEnum.DotNode.CruiseSelfTaskBtn)
	RedDotController.instance:addRedDot(self._goreddotceremony, RedDotEnum.DotNode.CruiseCeremonyBtn)
	RedDotController.instance:addRedDot(self._goreddotguest, RedDotEnum.DotNode.CruiseGuestBtn)

	local isGlobalTaskComplete = CruiseModel.instance:getCurDollStage() == 4

	if isGlobalTaskComplete then
		AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_shengyan_box_open)
	else
		self:_onCheckRefreshTaskInfo()
		TaskDispatcher.runRepeat(self._onCheckRefreshTaskInfo, self, TimeUtil.OneMinuteSecond)
		AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_note_course_unlock)
	end

	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()
end

function CruiseMainView:_onCheckRefreshTaskInfo()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, self._onCheckGetActivityInfo, self)
end

function CruiseMainView:_onCheckGetActivityInfo()
	ActivityRpc.instance:sendGetActivityInfosRequest(self._onSendTaskBack, self)
end

function CruiseMainView:_onSendTaskBack()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.CruiseGlobalStage1,
		RedDotEnum.DotNode.CruiseGlobalStage2,
		RedDotEnum.DotNode.CruiseGlobalStage3,
		RedDotEnum.DotNode.CruiseGlobalStage4,
		RedDotEnum.DotNode.CruiseMainBtn,
		RedDotEnum.DotNode.CruiseGlobalTaskBtn
	})
end

function CruiseMainView:_checkPlayStory()
	local storyId = CommonConfig.instance:getConstNum(ConstEnum.CruiseMainStory)
	local isPlayed = StoryModel.instance:isStoryFinished(storyId)

	if isPlayed then
		return
	end

	StoryController.instance:playStory(storyId, nil, self._onStoryFinished, self)
end

function CruiseMainView:_onStoryFinished()
	gohelper.setActive(self._btnreplay.gameObject, true)
end

function CruiseMainView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)

	local isGameUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseGame)

	if isGameUnlock then
		self._txtgameunlocktime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseGame)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseGame) / 1000 - ServerTime.now()

		self._txtgamelocktime.text = self:_getLockStr(second)
	end

	local isTripleDropUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseTripleDrop)

	if isTripleDropUnlock then
		self._txtdungeonunlocktime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseTripleDrop)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseTripleDrop) / 1000 - ServerTime.now()

		self._txtdungeonlocktime.text = self:_getLockStr(second)
	end

	local isGlobalTaskUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseGlobalTask)

	if isGlobalTaskUnlock then
		self._txtglobaltaskunlocktime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseGlobalTask)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseGlobalTask) / 1000 - ServerTime.now()

		self._txtglobaltasklocktime.text = self:_getLockStr(second)
	end

	local isSelfTaskUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseSelfTask)

	if isSelfTaskUnlock then
		self._txtselftaskunlocktime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseSelfTask)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseSelfTask) / 1000 - ServerTime.now()

		self._txtselftasklocktime.text = self:_getLockStr(second)
	end

	local isCeremonyUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony)

	if isCeremonyUnlock then
		self._txtceremonyunlocktime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony) / 1000 - ServerTime.now()

		self._txtceremonylocktime.text = self:_getLockStr(second)
	end

	self._txtguesttime.text = ActivityModel.getRemainTimeStr(ActivityEnum.Activity.V3a2_SummonCustomPickNew)
end

function CruiseMainView:_getLockStr(second)
	return string.format(luaLang("seasonmainview_timeopencondition"), string.format("%s%s", TimeUtil.secondToRoughTime2(second)))
end

function CruiseMainView:_refresh()
	self:_refreshUI()
	self:_refreshBtns()
end

local lvChangeInterverTime = 0.2
local lvChangeTime = 0.8

function CruiseMainView:_refreshUI()
	local storyId = CommonConfig.instance:getConstNum(ConstEnum.CruiseMainStory)
	local isPlayed = StoryModel.instance:isStoryFinished(storyId)

	gohelper.setActive(self._btnreplay.gameObject, isPlayed)

	local stage = CruiseModel.instance:getCurDollStage()

	self._stageLv = self._stageLv or stage
	self._changeAnim = self._changeAnim or self._godoll:GetComponent(typeof(UnityEngine.Animator))

	if stage > self._stageLv then
		UIBlockMgr.instance:startBlock("changeLv")
		self._changeAnim:Play("change", 0, 0)
		TaskDispatcher.runDelay(self._refreshStageLv, self, lvChangeInterverTime)
		TaskDispatcher.runDelay(self._changeLvFinished, self, lvChangeTime)

		self._stageLv = stage
	else
		self._changeAnim:Play("idle", 0, 0)
		self:_refreshStageLv()
	end
end

function CruiseMainView:_refreshStageLv()
	local stage = CruiseModel.instance:getCurDollStage()

	for index, golv in pairs(self._golvs) do
		gohelper.setActive(golv, index == stage + 1)
	end

	gohelper.setActive(self._gocompleteeff, stage == 4)
end

function CruiseMainView:_changeLvFinished()
	UIBlockMgr.instance:endBlock("changeLv")
end

function CruiseMainView:_refreshBtns()
	self:_refreshGameBtn()
	self:_refreshDungeonBtn()
	self:_refreshGlobalTaskBtn()
	self:_refreshSelfTaskBtn()
	self:_refreshOpenCeremonyBtn()
	self:_refreshGuest()
end

function CruiseMainView:_refreshGameBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._gogamefinish, true)
		gohelper.setActive(self._gogameunlock, false)
		gohelper.setActive(self._gogamelock, false)

		return
	end

	gohelper.setActive(self._gogamefinish, false)

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isUnlock then
		self._txtgameunlocktime.text = ActivityModel.getRemainTimeStr(actId)
	else
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtgamelocktime.text = self:_getLockStr(second)
	end

	self._gameUnlock = self._gameUnlock or isUnlock
	self._gamelockAnim = self._gamelockAnim or self._gogamelock:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gogameunlock, isUnlock)

	if isUnlock and not self._gameUnlock then
		self._gamelockAnim:Play("unlock", 0, 0)
		UIBlockMgr.instance:startBlock("startUnlock")
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("startUnlock")
			gohelper.setActive(self._gogamelock, false)
		end, self, 0.5)
	else
		gohelper.setActive(self._gogamelock, not isUnlock)
		self._gamelockAnim:Play("idle", 0, 0)
	end

	self._gameUnlock = isUnlock
end

function CruiseMainView:_refreshDungeonBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseTripleDrop
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._godungeonfinish, true)
		gohelper.setActive(self._godungeonunlock, false)
		gohelper.setActive(self._godungeonlock, false)

		return
	end

	gohelper.setActive(self._godungeonfinish, false)

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isUnlock then
		self._txtdungeonunlocktime.text = ActivityModel.getRemainTimeStr(actId)
	else
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtdungeonlocktime.text = self:_getLockStr(second)
	end

	self._dungeonUnlock = self._dungeonUnlock or isUnlock
	self._dungeonlockAnim = self._dungeonlockAnim or self._godungeonlock:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._godungeonunlock, isUnlock)

	if isUnlock and not self._dungeonUnlock then
		self._dungeonlockAnim:Play("unlock", 0, 0)
		UIBlockMgr.instance:startBlock("startUnlock")
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("startUnlock")
			gohelper.setActive(self._godungeonlock, false)
		end, self, 0.5)
	else
		gohelper.setActive(self._godungeonlock, not isUnlock)
		self._dungeonlockAnim:Play("idle", 0, 0)
	end

	self._dungeonUnlock = isUnlock
end

function CruiseMainView:_refreshGlobalTaskBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGlobalTask
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goglobaltaskfinish, true)
		gohelper.setActive(self._goglobaltaskunlock, false)
		gohelper.setActive(self._goglobaltasklock, false)

		return
	end

	gohelper.setActive(self._goglobaltaskfinish, false)

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isUnlock then
		self._globalTaskAnim:Play("loop")

		self._txtglobaltaskunlocktime.text = ActivityModel.getRemainTimeStr(actId)
	else
		self._globalTaskAnim:Play("idle")

		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtglobaltasklocktime.text = self:_getLockStr(second)
	end

	self._globalTaskUnlock = self._globalTaskUnlock or isUnlock
	self._globalTasklockAnim = self._globalTasklockAnim or self._goglobaltasklock:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goglobaltaskunlock, isUnlock)

	if isUnlock and not self._globalTaskUnlock then
		self._globalTasklockAnim:Play("unlock", 0, 0)
		UIBlockMgr.instance:startBlock("startUnlock")
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("startUnlock")
			gohelper.setActive(self._goglobaltasklock, false)
		end, self, 0.5)
	else
		gohelper.setActive(self._goglobaltasklock, not isUnlock)
		self._globalTasklockAnim:Play("idle", 0, 0)
	end

	self._globalTaskUnlock = isUnlock
end

function CruiseMainView:_refreshSelfTaskBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask
	local isUnlock = ActivityModel.instance:isActOnLine(actId)

	if isUnlock then
		self._txtselftaskunlocktime.text = ActivityModel.getRemainTimeStr(actId)
	else
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtselftasklocktime.text = self:_getLockStr(second)
	end

	self._selfTaskUnlock = self._selfTaskUnlock or isUnlock
	self._selfTasklockAnim = self._selfTasklockAnim or self._goselftasklock:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goselftaskunlock, isUnlock)

	if isUnlock and not self._selfTaskUnlock then
		self._selfTasklockAnim:Play("unlock", 0, 0)
		UIBlockMgr.instance:startBlock("startUnlock")
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("startUnlock")
			gohelper.setActive(self._goselftasklock, false)
		end, self, 0.5)
	else
		gohelper.setActive(self._goselftasklock, not isUnlock)
		self._selfTasklockAnim:Play("idle", 0, 0)
	end

	self._selfTaskUnlock = isUnlock
end

function CruiseMainView:_refreshOpenCeremonyBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	local isUnlock = ActivityModel.instance:isActOnLine(actId)
	local hasRewardCouldGet = CruiseModel.instance:isCeremonyHasReward()
	local isReceived = isUnlock and not hasRewardCouldGet

	gohelper.setActive(self._goceremonyreceive, isReceived)

	if isUnlock then
		self._txtceremonyunlocktime.text = ActivityModel.getRemainTimeStr(actId)
	else
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtceremonylocktime.text = self:_getLockStr(second)
	end

	self._ceremonyUnlock = self._ceremonyUnlock or isUnlock
	self._ceremonylockAnim = self._ceremonylockAnim or self._goceremonylock:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goceremonyunlock, isUnlock)

	if isUnlock and not self._ceremonyUnlock then
		self._ceremonylockAnim:Play("unlock", 0, 0)
		UIBlockMgr.instance:startBlock("startUnlock")
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("startUnlock")
			gohelper.setActive(self._goceremonylock, false)
		end, self, 0.5)
	else
		gohelper.setActive(self._goceremonylock, not isUnlock)
		self._ceremonylockAnim:Play("idle", 0, 0)
	end

	self._ceremonyUnlock = isUnlock
end

function CruiseMainView:_refreshGuest()
	local actId = ActivityEnum.Activity.V3a2_SummonCustomPickNew
	local isOpen = SummonNewCustomPickViewModel.instance:isActivityOpen(actId)
	local isGet = SummonNewCustomPickViewModel.instance:isGetReward(actId)

	gohelper.setActive(self._goguestcanget, isOpen and not isGet)
	gohelper.setActive(self._goguestreceive, isOpen and isGet)

	self._txtguesttime.text = ActivityModel.getRemainTimeStr(actId)
end

function CruiseMainView:onClose()
	return
end

function CruiseMainView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.cancelTask(self._onCheckRefreshTaskInfo, self)
	self:_removeSelfEvents()
end

return CruiseMainView
