-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/controller/OpSummaryController.lua

module("logic.extensions.activitypopup.controller.OpSummaryController", package.seeall)

local OpSummaryController = class("OpSummaryController", BaseController)

OpSummaryController.SummaryTaskStroy = "summarytaskstroy"

function OpSummaryController:ctor()
	return
end

function OpSummaryController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenStart, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	GlobalDispatcher:addListener(OpSummaryController.SummaryTaskStroy, self._onPlayStroy, self)
	GlobalDispatcher:addListener(ActivitySummaryAgent.PM_ActivitySummaryInviteInfoRes, self.onActInfoRes, self)
	GlobalDispatcher:addListener("activitydreamsummaryview", self._tryOpenActivitydreamsummaryview, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener("admiremoonview", self._tryPlayFireworkEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self.lightAdmiremoonRd, self)
	self:onReset()
end

function OpSummaryController:onReset()
	self._isPlayingBgm = false
	self.sendList = {}

	self:updateRedIdAsAllTabNew()

	if self._fireworkEffect then
		for _, effect in ipairs(self._fireworkEffect) do
			UIEffectManager.instance:stopEffect(effect)
		end
	end

	self._fireworkEffect = nil
end

function OpSummaryController:_resetRedPoint()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, 17043)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_OP220701_1)
	end

	activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, 17045)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_OP220701_2)
	end
end

function OpSummaryController:sendGetAllTask(summaryId)
	OpSummaryModel.instance:sendGetAllTask(summaryId)
end

function OpSummaryController:sendGetPrize(summaryId, data)
	OpSummaryModel.instance:sendGetPrize(summaryId, data.id)
end

function OpSummaryController:sendGetTaskPrize(summaryId, data)
	OpSummaryModel.instance:sendGetTaskPrize(summaryId, data.id)
end

function OpSummaryController:sendLotteryReq(summaryId, handler, handlerObj, errHandler)
	OpSummaryModel.instance:sendLotteryReq(summaryId, handler, handlerObj, errHandler)
end

function OpSummaryController:sendGainLotteryProgressPrize(summaryId, prizeId)
	OpSummaryModel.instance:sendGainLotteryProgressPrize(summaryId, prizeId)
end

function OpSummaryController:sendPM_GetActivityPluginProgressInfoReq(activityId)
	ActivitySummaryAgent.instance:sendPM_GetActivityPluginProgressInfoReq(activityId)
end

function OpSummaryController:handlePM_GetActivityPluginProgressInfoRes(status, msg)
	OpSummaryModel.instance:setAdmireMoonInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GetActivityPluginProgressInfoRes, msg)
end

function OpSummaryController:sendPM_GainActivityPluginProgressPrizeReq(activityId, progressId, prizeId)
	ActivitySummaryAgent.instance:sendPM_GainActivityPluginProgressPrizeReq(activityId, progressId, prizeId)
end

function OpSummaryController:handlePM_GainActivityPluginProgressPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.GainActivityPluginProgressPrizeRes, msg)
end

function OpSummaryController:dailyRefresh()
	local startUpCfg = OperationSummaryConfig.instance:getSummaryStartUpCfg()

	for _, data in pairs(startUpCfg) do
		if not string.nilorempty(data.activityId) then
			self:setDayAnimPlayData(data.activityId, false)
		end
	end
end

function OpSummaryController:isUnlockAsTab(id)
	return self:isInShowTimeAsTab(id) and self:isInActTimeAsTab(id)
end

function OpSummaryController:isInShowTimeAsTab(id)
	return self:getShowTimePeriodAsTab(id) == GameUtil.inTimePeriod
end

function OpSummaryController:isInActTimeAsTab(id)
	return self:isInActTimeAsSummary(id) and self:isInActTimeAsTabEntrance(id)
end

function OpSummaryController:isInActTimeAsSummary(id)
	return self:getActTimePeriodAsTab(id) == GameUtil.inTimePeriod
end

function OpSummaryController:isInActTimeAsTabEntrance(id)
	return self:getActTimePeriodAsTab(id) == GameUtil.inTimePeriod
end

function OpSummaryController:getShowTimePeriodAsTab(id)
	local data = OperationSummaryConfig.instance:getTaskItemsData(id)

	return GameUtil.getTimePeriod(data.startTime, data.endTime)
end

function OpSummaryController:getActTimePeriodAsSummary(id)
	local data = OperationSummaryConfig.instance:getTaskItemsData(id)

	return ActivityDefineController.instance:getActTimePeriod(GameEnum.ActivityType.Summary, data.planId)
end

function OpSummaryController:getActTimePeriodAsTab(id)
	local data = OperationSummaryConfig.instance:getTaskItemsData(id)

	return (data.activityType ~= 0 and data.activityId ~= 0 or nil) and ActivityDefineController.instance:getActTimePeriod(data.activityType, data.activityId)
end

function OpSummaryController:getRedIdAsTabNew(id)
	return OpSummaryModel.REDID_NEWTAB .. id
end

function OpSummaryController:updateRedIdAsAllTabNew()
	local startUpDataList = OperationSummaryConfig.instance:getSummaryStartUpDataList()

	for _, updata in pairs(startUpDataList) do
		local itemsCfg = OperationSummaryConfig.instance:getTaskItemsCfg(updata.activityId)
		local redId = checknumber(updata.redId)

		if redId ~= 0 then
			for _, data in pairs(itemsCfg) do
				local function callBack(value)
					RedPointController.instance:setRedPointInfo(redId, (checknumber(updata.redId) ~= 0 and checknumber(value) == 0 and self:_isInTimeToShowAsTabNew(data.id) or nil) and true, false)
				end

				GameUtil.getUserData(self:_getNewTabUserDataKey(data.id), callBack)
			end
		end
	end
end

function OpSummaryController:updateRedIdAsTabNew(id)
	local function callBack(value)
		local isNeedRed = checknumber(value) == 0 and self:_isInTimeToShowAsTabNew(id)

		RedPointController.instance:setRedPointInfo(self:getRedIdAsTabNew(id), isNeedRed, false)
	end

	GameUtil.getUserData(self:_getNewTabUserDataKey(id), callBack)
	self:updateRedIdAsAllTabNew()
end

function OpSummaryController:saveRedIdAsTabNew(id)
	local key = self:_getNewTabUserDataKey(id)

	if GameUtil.getUserData(key) ~= "1" then
		GameUtil.saveUserData(key, "1")
		RedPointController.instance:setRedPointInfo(self:getRedIdAsTabNew(id), false)
		self:updateRedIdAsAllTabNew()
	end
end

function OpSummaryController:_getNewTabUserDataKey(id)
	return OpSummaryModel.KEY_ABOUTNEW .. id
end

function OpSummaryController:_isInTimeToShowAsTabNew(id)
	if not self:isUnlockAsTab(id) then
		return false
	end

	local data = OperationSummaryConfig.instance:getTaskItemsData(id)
	local sumActCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, data.planId)
	local tabActCfg = ActivityDefineConfig.instance:getCfgById(data.activityType, data.activityId)

	if sumActCfg == nil then
		printError(string.format("缺失活动配置: activityType = %d, activityId = %d", GameEnum.ActivityType.Summary, data.planId))

		return false
	end

	if tabActCfg == nil then
		return false
	end

	local sumStartStamp, tabStartStamp = GameUtil.string2time(sumActCfg.startTime), GameUtil.string2time(tabActCfg.startTime)

	if tabStartStamp <= sumStartStamp then
		return false
	end

	return true
end

function OpSummaryController:isCanGetPrizeAsTask(taskId)
	return self:isEnoughGetPrizeAsTask(taskId) and not self:isHasGainPrizeAsTask(taskId)
end

function OpSummaryController:isEnoughGetPrizeAsTask(taskId)
	local data = OperationSummaryConfig.instance:getTaskDetailData(taskId)

	if data == nil then
		return false
	end

	local curProgress = OpSummaryModel.instance:getTaskProgress(taskId)
	local maxProgress = data.maxProgress

	return maxProgress <= curProgress
end

function OpSummaryController:isHasGainPrizeAsTask(taskId)
	return OpSummaryModel.instance:isHasGainPrizeAsTask(taskId)
end

function OpSummaryController:reqOpenInvitationData()
	local isFuncOpen = FuncOpenModel.instance:getFuncIsOpen(193)

	if not isFuncOpen then
		return
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.InvitationCard)

	for _, item in pairs(cfgs) do
		self:getInvitationInfo(item.activityId)
	end
end

function OpSummaryController:getInvitationInfo(activityId)
	activityId = checknumber(activityId)

	local isActive = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.InvitationCard, activityId)

	if isActive then
		table.insert(self.sendList, activityId)
		self:trySendMsg()
	end
end

function OpSummaryController:trySendMsg()
	if self.curSummaryId == nil and self.sendList and #self.sendList > 0 then
		self.curSummaryId = table.remove(self.sendList)

		ActivitySummaryAgent.instance:sendPM_ActivitySummaryInviteInfoReq(self.curSummaryId)
	end
end

function OpSummaryController:onActInfoRes(status, msg)
	if status == 0 then
		if msg.isHasAccept == nil or msg.isHasAccept == false then
			OpSummaryModel.instance:setHaveGetInvitation(self.curSummaryId, 0)
		else
			OpSummaryModel.instance:setHaveGetInvitation(self.curSummaryId, 1)
		end
	end

	self.curSummaryId = nil

	self:trySendMsg()
end

function OpSummaryController:acceptInvite(activityId, actCfg)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryAcceptInviteReq(activityId, function()
		ViewAutoShowController.instance:saveSelfTypeDone(actCfg)
		OpSummaryModel.instance:setHaveGetInvitation(activityId, 1)
		self:notify(GlobalNotify.OperationInvitation, activityId)
	end)
end

function OpSummaryController:isPlayingBgm()
	return self._isPlayingBgm
end

function OpSummaryController:getBgmMusicId()
	return 11000
end

function OpSummaryController:playBgmMusic()
	if self._isPlayingBgm then
		return
	end

	self._isPlayingBgm = true

	AudioPlayerEx.instance:playMusic(self:getBgmMusicId())
end

function OpSummaryController:clearBgmStatus()
	self._isPlayingBgm = false
end

function OpSummaryController:stopBgmMusic()
	if not self._isPlayingBgm then
		return
	end

	self._isPlayingBgm = false

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function OpSummaryController:_onViewOpened(view)
	if view.viewName == ViewName.ScratchView then
		self:stopBgmMusic()

		return
	end

	if view.viewName == ViewName.NuoyaSummaryView or view.viewName == ViewName.SccopyMissionView or view.viewName == ViewName.SclevelsView or view.viewName == ViewName.SctrialView or view.viewName == ViewName.ScmainView or view.viewName == ViewName.MiyaMainView or view.viewName == ViewName.MiyaDetailView or view.viewName == ViewName.ActivitySummaryView then
		self:playBgmMusic()
	end
end

function OpSummaryController:_onViewClosed(view)
	if not UIStateManager.instance:isInStack(ViewName.NuoyaSummaryView) and not UIStateManager.instance:isInStack(ViewName.ScmainView) and not UIStateManager.instance:isInStack(ViewName.ActivitySummaryView) then
		self:stopBgmMusic()
	end
end

function OpSummaryController:_onPlayStroy(params)
	local summaryId = checknumber(params[1])
	local taskId = checknumber(params[2])
	local storyId = checknumber(params[3])

	OpSummaryModel.instance:sendPlayStroy(summaryId, taskId)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function OpSummaryController:isCanLottery(activityId)
	local isEnoughScores = self:isEnoughLotteryScores(activityId)
	local isInScoresLimit = self:isInLotteryScoresLimit(activityId)

	return isEnoughScores and isInScoresLimit
end

function OpSummaryController:isEnoughLotteryScores(activityId)
	local cfg_base = OperationSummaryConfig.instance:getTaskBaseCfg(activityId)
	local lotteryScores = OpSummaryModel.instance.lotteryScores
	local lotteryCostNum = cfg_base.lotteryCostNum

	return lotteryScores - lotteryCostNum >= 0
end

function OpSummaryController:isInLotteryScoresLimit(activityId)
	local cfg_base = OperationSummaryConfig.instance:getTaskBaseCfg(activityId)
	local hasLotteryTimes = OpSummaryModel.instance.hasLotteryTimes
	local weekLength = #cfg_base.lotteryWeekTimesLimit
	local nowWeekIdx = self:getWeekFromActStart(activityId)

	nowWeekIdx = math.min(nowWeekIdx, weekLength)

	return hasLotteryTimes < cfg_base.lotteryWeekTimesLimit[nowWeekIdx]
end

function OpSummaryController:getDayFromActStart(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, activityId)

	return (GameUtil.getDaysByTimestamp(startTime, ServerTime.nowServerLook()))
end

function OpSummaryController:getWeekFromActStart(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.nowServerLook())
	local quotient, remainder = math.modf(day / 7)

	return quotient + (remainder == 0 and 0 or 1)
end

function OpSummaryController:ifNeedDayAnimThenPlay(activityId, path, onBeforePlay, onAnimPlayFinish, onAnimPlayStart, handleObject)
	local function handler(value)
		if string.nilorempty(path) then
			printError("动画播放路径为空")

			return
		end

		local isRecorded = value ~= nil and value ~= false
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Summary, activityId)
		local isNeedPlay = not isRecorded and isInTime

		if isNeedPlay then
			GameUtil.callBack(onBeforePlay)
			AnimationPlayer.play(path, onAnimPlayFinish, onAnimPlayStart, handleObject)

			isRecorded = true

			OpSummaryController.instance:setDayAnimPlayData(activityId, true)
		end
	end

	local key = self:getDayAnimPlayKey(activityId)

	GameUtil.getUserWeekData(key, handler)
end

function OpSummaryController:setDayAnimPlayData(activityId, isRecorded)
	if string.nilorempty(activityId) then
		printError("错误:传入activityId为空")

		return
	end

	local key = self:getDayAnimPlayKey(activityId)

	GameUtil.saveUserWeekData(key, isRecorded)
end

function OpSummaryController:getDayAnimPlayKey(activityId)
	if string.nilorempty(activityId) then
		printError("错误:传入activityId为空")

		return
	end

	return "SummaryWeeklyAnimPlay" .. activityId
end

function OpSummaryController:pluginProgressId(activityId)
	local progressInfos = OpSummaryModel.instance:getAdmireMoonInfo()

	if TableUtil.isTableEmpty(progressInfos) then
		return 0
	end

	for _, info in ipairs(progressInfos) do
		for i, v in ipairs(info) do
			-- block empty
		end

		if info.activityId == activityId then
			return checknumber(info.progress)
		end
	end

	return 0
end

function OpSummaryController:isGainPrize(activityId, prizeId)
	local progressInfos = OpSummaryModel.instance:getAdmireMoonInfo()

	if TableUtil.isTableEmpty(progressInfos) then
		return false
	end

	for _, info in ipairs(progressInfos) do
		if info.activityId == activityId then
			if TableUtil.isTableEmpty(info.gainPrizeIds) then
				return false
			end

			return TableUtil.isHad(info.gainPrizeIds, prizeId)
		end
	end

	return false
end

function OpSummaryController:_tryOpenActivitydreamsummaryview(params)
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ActivitydreamsummaryView) then
		UIStateManager.instance:popByName(ViewName.ActivitydreamsummaryView)
	end

	UIStateManager.instance:push(ViewName.ActivitydreamsummaryView, activityId)
end

function OpSummaryController:_tryPlayFireworkEffect(params)
	local activityId = checknumber(params[1])
	local progressId = checknumber(params[2])

	if activityId <= 0 and progressId <= 0 then
		return
	end

	local itemStr = OperationSummaryConfig.instance:getPluginProgressPlanCfg(activityId, progressId).materialId
	local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
	local hasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasCount <= 0 then
		FloatWordMgr.instance:show("数量不足，无法使用")
	end

	if hasCount > 0 then
		local count = Mathf.Clamp(hasCount, 1, 99999)

		MaterialFacade.instance:useItem(matType, matId, count, nil, nil, MaterialController.CI_SHOW_TYPE_FLY)

		self._fireworkEffect = {}

		self:_playFireworkEffect(-0.62, -0.68)
		self:_playFireworkEffect(-0.1, -0.34)
		self:_playFireworkEffect(0.8, -0.28)
	end
end

function OpSummaryController:_playFireworkEffect(x, y)
	local effPath = {
		"effect/prefabs/scene/fx_scene_aoqicheng_1zhounian/prefab/fx_scene_fangyanhua.prefab"
	}
	local pmEff = UIEffectManager.instance:playScreenEffect(effPath, Vector2.New(), false, nil, function(finishHandler, eff)
		UIEffectManager.instance:stopEffect(eff)
	end, function(loadedHandler, eff)
		eff:setScale(0.24)
		eff:setLocalPos(x, y, 1.1)
	end, self)

	table.insert(self._fireworkEffect, pmEff)
end

function OpSummaryController:lightAdmiremoonRd()
	local itemStr = OperationSummaryConfig.instance:getPluginProgressPlanCfg(17126, 1).materialId
	local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
	local hasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasCount > 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_ADMIREMOON, true)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_ADMIREMOON, false)
	end
end

OpSummaryController.instance = OpSummaryController.New()

return OpSummaryController
