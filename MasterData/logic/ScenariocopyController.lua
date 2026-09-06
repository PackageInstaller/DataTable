-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/controller/ScenariocopyController.lua

module("logic.extensions.scenariocopy.controller.ScenariocopyController", package.seeall)

local ScenariocopyController = class("ScenariocopyController", BaseController)

function ScenariocopyController:ctor()
	return
end

function ScenariocopyController:onInit()
	OperationPlotAgent.instance:setShowChangeSetFunc(function()
		return
	end)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	GlobalDispatcher:addListener(OperationPlotAgent.PM_OperationPlotChallengeEndRes, self._onNotifyAfterChallengeRes, self)
	GlobalDispatcher:addListener(OperationPlotAgent.PM_OperationPlotChallengeRes, self._OnChallengeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyRedPointUpdate, self.updateEntranceRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.SelectNPC, self.onSelectNpc, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataEnergyCount, self.ifNeedToShowTrialEnergyRedThenShow, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	self:onReset()
end

function ScenariocopyController:onReset()
	self._isListening = false
	self._StoryEndCallBack = nil
	self._listenMatIds = {}
end

function ScenariocopyController:loadScenariocopyInfo()
	if ScenariocopyModel.instance:refreshActIdandPlotId() then
		self:storeMatId()
		self:getInfo(function()
			self:updateEntranceRedPoint()
		end)
	end
end

function ScenariocopyController:storeMatId()
	local planId = ScenariocopyModel.instance:getPlotId()
	local storys

	if planId then
		storys = ScenariocopyConfig.instance:getStoryCfgs(planId)
	end

	if storys then
		for k, v in pairs(storys) do
			local strList = string.split(v.openCondition, ":")

			if strList[2] then
				local itemId = checknumber(strList[2])
				local exist = false

				for k, v in ipairs(self._listenMatIds) do
					if itemId == v then
						exist = true
					end
				end

				if not exist then
					table.insert(self._listenMatIds, itemId)
				end
			end
		end
	end
end

function ScenariocopyController:getInfo(callback)
	local isHasGainInfo = ScenariocopyModel.instance:getHasGetInfo()

	if not isHasGainInfo then
		local function handler(msg)
			forcePrint("=====RoleDataRequestor:_loadScenariocopyInfo===back")

			if msg.HasField ~= nil then
				for k, v in pairs(msg.stageInfo) do
					if v.HasField ~= nil then
						ScenariocopyModel.instance:setStagePass(v.chapterId, v.stageId, v.hasGainPerfectPrize)
					end
				end
			end

			ScenariocopyModel.instance:setHasGetInfo(true)
			ScenariocopyModel.instance:setBuffLevel(msg.buffLevel)
			ScenariocopyModel.instance:setHasGainBuffPrize(msg.hasGainBuffPrize)
			GameUtil.callBack(callback, msg)
			GlobalDispatcher:dispatch(GlobalNotify.ScenariocopyStageUpdate)
		end

		OperationPlotAgent.instance:sendPM_OperationPlotInfoReq(handler)
	else
		GameUtil.callBack(callback)
	end
end

function ScenariocopyController:getChapterList(storyId, type)
	local res = {}
	local chapterCfgs = ScenariocopyConfig.instance:getChapterCfgs(storyId)

	if chapterCfgs then
		for i, vCfg in pairs(chapterCfgs) do
			if checknumber(vCfg.chapterType) == type then
				table.insert(res, vCfg)
			end
		end
	end

	return res
end

function ScenariocopyController:openScmainView()
	if ScenariocopyModel.instance:refreshActIdandPlotId() then
		self:getInfo(function(msg)
			UIStateManager.instance:push(ViewName.ScmainView)
		end)
	end
end

function ScenariocopyController:openSclevelsView(target)
	local actId = checknumber(target.activityId) or 0
	local typeId = checknumber(target.typeId) or 0
	local chapterId = checknumber(target.chapterId) or 0
	local targetType = checknumber(target.targetType) or 0

	if not target.taskStep then
		local instruction = checknumber(target.instruction) or 0

		if not ScenariocopyModel.instance:isInActivityTime() then
			return
		end

		local scCfg = ScenariocopyConfig.instance:getActCfg(actId)

		if scCfg == nil then
			return
		end

		local sccParams = scCfg.sccParams

		if string.nilorempty(sccParams) then
			return
		end

		local sccArr = string.split(sccParams, "#")

		for k, dataStr in ipairs(sccArr) do
			local dataArr = string.split(dataStr, ":")
			local sccViewName, typeId1, typeId2 = dataArr[1], checknumber(dataArr[2]), checknumber(dataArr[3])

			if typeId1 <= typeId and typeId <= typeId2 then
				UIStateManager.instance:push(sccViewName, typeId)

				break
			end
		end
	end
end

function ScenariocopyController:openStageView(chapterId, stageId)
	local chapterCfg = CopyConfig.instance:getChapter(chapterId)
	local stageCfg = CopyConfig.instance:getStageById(chapterId, stageId)

	if not chapterCfg or not stageCfg then
		printError("进入关卡失败，副本id不存在 chapterId:stageId = ", chapterId, stageId, type(chapterId), type(stageId))

		return
	end

	UIStateManager.instance:push(ViewName.PlotStageView, chapterId, stageId)
end

function ScenariocopyController:openTrialView(viewName)
	local trialId = ScenariocopyModel.instance:getTrialId()
	local cfg = ScenariocopyConfig.instance:getTrialCfg(trialId)

	ScenariocopyModel.instance:setTypeId(cfg.typeId, true)
	self:setTrialRedPoint(trialId, 2)

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(ViewName.SctrialView, trialId, viewName)
	else
		UIStateManager.instance:push(ViewName.SctrialView, trialId)
	end
end

function ScenariocopyController:getStoryIfUnlockAndText(typeId)
	local unlock, resTxt = true, ""
	local planId = ScenariocopyModel.instance:getPlotId()
	local chapterCfg = ScenariocopyConfig.instance:getStoryCfgs(planId)
	local data = chapterCfg[typeId]

	if not data then
		printWarn("配置不存在 planId, typeId", planId, typeId)

		return false, "配置不存在"
	end

	local isTimeUnLock = ScenariocopyController.instance:getIfOpenByStartDay(data.openDay)
	local isPass = true
	local chapterName = ""
	local chapterOrder = ""
	local mainList = ScenariocopyController.instance:getChapterList(typeId, ScenariocopyModel.CHAPTER_TYPE_PLOT)

	table.sort(mainList, function(a, b)
		return a.chapterId < b.chapterId
	end)

	local mainUnlockCondition = mainList[1].unlockCondition

	if mainUnlockCondition and #mainUnlockCondition > 0 then
		local needUnlockStoryId = mainUnlockCondition[1]
		local chapterId = mainUnlockCondition[2]
		local stageId = mainUnlockCondition[3]

		isPass = ScenariocopyModel.instance:getStagePass(chapterId, stageId)

		local chapterCfg = ScenariocopyConfig.instance:getChapterCfg(needUnlockStoryId, chapterId)

		if chapterCfg then
			chapterName = chapterCfg.chapterName
			chapterOrder = chapterCfg.orderNumber
		end
	end

	local itemCondition = data.openCondition
	local needNum, matName
	local enoughItem = true

	if not string.nilorempty(itemCondition) then
		local itemStr = string.split(itemCondition, ":")
		local itemType = checknumber(itemStr[1])
		local itemId = checknumber(itemStr[2])

		needNum = checknumber(itemStr[3])

		local haveNum = MaterialModel.instance:getMaterialsNumber(itemType, itemId)

		matName = MaterialModel.instance:getMaterialsName(itemType, itemId)

		if haveNum < needNum then
			enoughItem = false
		end
	end

	if not isTimeUnLock then
		local openMon, openDay = ScenariocopyController.instance:parseOpenTime(data.openDay)

		resTxt = langPara("%s月%s日 5:00 解锁", openMon, openDay)
		unlock = false
	elseif not isPass then
		resTxt = langPara("通关 %s %s 后解锁", chapterOrder, chapterName)
		unlock = false
	elseif not enoughItem then
		resTxt = langPara("集齐%s*%s后开启", matName, needNum)
		unlock = false
	end

	return unlock, resTxt
end

function ScenariocopyController:pushOneStackView(chapterId, stageId, viewName)
	if not string.nilorempty(viewName) then
		UIJumper.instance:pushOneStack(viewName, true)
	else
		UIJumper.instance:pushOneStack(ViewName.ScmainView, true)
	end

	local typeId = ScenariocopyModel.instance:getTypeId()
	local chapterCfg = ScenariocopyConfig.instance:getChapterCfg(typeId, chapterId)

	if checknumber(chapterCfg.chapterType) == ScenariocopyModel.CHAPTER_TYPE_PLOT then
		if string.nilorempty(viewName) then
			UIJumper.instance:pushOneStack(ViewName.SclevelsView, true)
		end
	else
		local trialId = ScenariocopyModel.instance:getTrialId()
		local cfg = ScenariocopyConfig.instance:getTrialCfg(trialId)

		ScenariocopyModel.instance:setTypeId(typeId, true)
		UIJumper.instance:pushOneStack(ViewName.SctrialView, true, trialId, viewName)
	end
end

function ScenariocopyController:parseOpenTime(openDay)
	local activityId = ScenariocopyModel.instance:getActivityId()
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.OperationPlot, activityId)

	if actCfg then
		local openTimeStamp = GameUtil.string2time(actCfg.startTime) + openDay * 24 * 60 * 60
		local openDate = GameUtil.time2date(openTimeStamp)

		return openDate.month, openDate.day
	end
end

function ScenariocopyController:getIfOpenByStartDay(openDay)
	local activityId = ScenariocopyModel.instance:getActivityId()
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.OperationPlot, activityId)

	if actCfg then
		local openTimeStamp = GameUtil.string2time(actCfg.startTime) + openDay * 24 * 60 * 60

		return openTimeStamp <= ServerTime.now()
	end
end

function ScenariocopyController:getStageName(storyId, chapterId, stageId, hasDegree)
	local chapterCfg
	local res = ""

	if checknumber(storyId) == 0 then
		storyId = ScenariocopyModel.instance:getTypeId()
	else
		local planId = ScenariocopyModel.instance:getPlotId()
		local storyCfg = ScenariocopyConfig.instance:getStoryCfg(planId, storyId)

		if storyCfg then
			res = storyCfg.storyName .. " "
		end
	end

	chapterCfg = checknumber(chapterId) > 0 and ScenariocopyConfig.instance:getChapterCfg(storyId, chapterId) or ScenariocopyModel.instance:getChapterCfg()

	if chapterCfg then
		res = res .. chapterCfg.orderNumber .. " " .. chapterCfg.chapterName
	end

	return res
end

function ScenariocopyController:startBattle()
	local activityId = ScenariocopyModel.instance:getActivityId()
	local storyId = ScenariocopyModel.instance:getTypeId()
	local chapterId = ScenariocopyModel.instance:getChapterId()
	local stageId = 1
	local modelForm = ScenariocopyModel.instance:getFormation()
	local form = modelForm:createFormPb()

	BattleFacade.instance:startSCCopy(activityId, storyId, chapterId)
	OperationPlotAgent.instance:sendPM_OperationPlotChallengeReq(activityId, storyId, chapterId, stageId, form, function(status, msg)
		return
	end, nil, function()
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end)
end

function ScenariocopyController:challegePurePlot()
	local activityId = ScenariocopyModel.instance:getActivityId()
	local storyId = ScenariocopyModel.instance:getTypeId()
	local chapterId = ScenariocopyModel.instance:getChapterId()
	local stageId = ScenariocopyModel.instance:getStageId()
	local modelForm = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local form = modelForm:createFormPb()

	OperationPlotAgent.instance:sendPM_OperationPlotChallengeReq(activityId, storyId, chapterId, stageId, form, function(status, msg)
		ScenariocopyModel.instance:setStagePass(chapterId, stageId)
		GlobalDispatcher:dispatch(GlobalNotify.ScenariocopyStageUpdate)
	end, nil, nil)
end

function ScenariocopyController:isFinishTask(chapterCfg)
	if chapterCfg and chapterCfg.preconditions and #chapterCfg.preconditions > 0 then
		local taskId = checknumber(chapterCfg.preconditions[1])
		local stepId = checknumber(chapterCfg.preconditions[2])
		local isFinishTask = TaskFacade.instance:isTaskStepFinished(taskId, stepId)
		local cfgTask = TaskConfig.instance:getTaskCo(taskId)
		local taskStep = TaskController.instance:getTaskStepByTaskId(taskId)

		if not isFinishTask then
			if TaskFacade.instance:isTaskStepCompeleted(taskId, (stepId == 0 or nil) and 1) then
				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("需要完成前置任务才可解锁，是否前往完成？", cfgTask.name), function()
					TaskController.instance:foreceClearState()
					TaskController.instance:startAutoAction(taskStep, true)
				end)
			else
				taskStep = self:getTraceBackTaskStep(taskStep)

				if taskStep then
					if taskStep:getState() == TaskConst.TSTEP_S_UNAVAILABLE or taskStep:getState() == TaskConst.TSTEP_S_ACCEPTED or taskStep:getState() == TaskConst.TSTEP_S_COMPELETED then
						TipsFacade.instance:openPopupWindow(lang("tip"), langPara("需要完成前置任务才可解锁，是否前往完成？", cfgTask.name), function()
							if taskStep:getState() ~= TaskConst.TSTEP_S_COMPELETED then
								UIStateManager.instance:clear()
							end

							TaskController.instance:foreceClearState()
							TaskController.instance:startAutoAction(taskStep, true)
						end)
					end
				else
					FloatWordMgr.instance:show(langPara("需要完成任务【%s】", cfgTask.name))
				end
			end

			return false
		end
	end

	return true
end

function ScenariocopyController:getTraceBackTaskStep(taskStep)
	if taskStep and taskStep.task and taskStep.task.taskCo then
		local taskCo = taskStep.task.taskCo

		taskCo = self:getTraceBackTaskCo(taskCo)

		if taskCo then
			return TaskController.instance:getTaskStepByTaskId(taskCo.taskId)
		end
	end

	return nil
end

function ScenariocopyController:getTraceBackTaskCo(taskCo)
	if not TaskModel.instance:isPreTaskesFinished(taskCo) then
		local taskes = TaskModel.instance:getUnFinishedPreTaskes(taskCo)

		if #taskes == 1 then
			taskCo = TaskConfig.instance:getTaskCo(taskes[1])

			return self:getTraceBackTaskCo(taskCo)
		end

		return nil
	else
		return taskCo
	end
end

function ScenariocopyController:openMission(viewName)
	local chapterCfg = ScenariocopyModel.instance:getChapterCfg()

	if not self:isFinishTask(chapterCfg) then
		return
	end

	local stageCfg = ScenariocopyModel.instance:getStageCfg()
	local creepIds = {}
	local supportCfgs = {}

	if stageCfg.supportId > 0 then
		supportCfgs = ScenariocopyConfig.instance:getSupportCfgs(stageCfg.supportId)

		for k, v in pairs(supportCfgs) do
			table.insert(creepIds, v.creepsId)
		end
	end

	ScenariocopyModel.instance:setSupportCfgs(supportCfgs)
	ScenariocopyModel.instance:setCreepsIds(creepIds)
	ScenariocopyModel.instance:setFormation()
	UIStateManager.instance:push(ViewName.SccopyMissionView, viewName)
end

function ScenariocopyController:_OnChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

	local chapterId = ScenariocopyModel.instance:getChapterId()
	local stageId = ScenariocopyModel.instance:getStageId()

	local function handler(isWin)
		if isWin then
			self:_playStoryAfterBattle(chapterId, stageId)
		end
	end

	BattleFacade.instance:setBattleEndRoundFromStoryHandler(handler)
end

function ScenariocopyController:_playStoryAfterBattle(chapterId, stageId)
	local cfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)

	if cfg and cfg.afterBattleId > 0 then
		if self:getIfhasPlayStory(chapterId, stageId, OperationCopyConst.playStoryInBattle) then
			return
		end

		local storyData = {
			storyId = cfg.afterBattleId,
			mode = TaskConst.BattleStoryTrigger_End
		}

		BattleModel.instance:setStoryData(storyData)
		self:setIfhasPlayStory(chapterId, stageId, OperationCopyConst.playStoryInBattle)
	end
end

function ScenariocopyController:_onNotifyAfterChallengeRes(status, msg)
	if status == 0 then
		if msg.isWin then
			ScenariocopyModel.instance:setStagePass(msg.chapterId, msg.stageId, msg.isFirstPerfectPass)
			GlobalDispatcher:dispatch(GlobalNotify.ScenariocopyStageUpdate)
		end

		self:_setBattleSettlement(msg)
		BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId, nil)
	end
end

function ScenariocopyController:_setBattleSettlement(msg)
	local params = {}
	local cfg = ScenariocopyConfig.instance:getStageCfg(msg.chapterId, msg.stageId)

	if msg.isWin then
		params.isWin = msg.isWin
	else
		params.isHideStrength = string.nilorempty(cfg.energyConsume)
		params.giveBackItem = cfg.energyConsume
	end

	params.chapterId = msg.chapterId
	params.stageId = msg.stageId
	params.isPerfectPassBefore = msg.isFirstPerfectPass

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Scenariocopy, params)
end

function ScenariocopyController:startNpcStory()
	local npcCfg = ScenariocopyConfig.instance:getNpcCfg(ScenariocopyModel.instance:getChapterId())
	local npcId = checknumber(npcCfg.npcId)

	if npcId > 0 then
		if checknumber(self.npcId) > 0 then
			SceneNpcsMgr.instance:removeNpc(self.npcId)
		end

		self.npcId = npcId

		SceneNpcsMgr.instance:createNpc(self.npcId)
		GotoMgr.gotoByString("npc#" .. npcId)
	end
end

function ScenariocopyController:onSelectNpc(npcId)
	if not npcId then
		return
	end

	if self.npcId == npcId then
		local curStageCfg = ScenariocopyModel.instance:getStageCfg()

		self:enterMissionOrStory(curStageCfg, self._dungeonViewName, self._stageViewName, self._rollbackViewName)
	end
end

function ScenariocopyController:setViewName(dungeonViewName, stageViewName, rollbackViewName)
	self._stageViewName = stageViewName
	self._dungeonViewName = dungeonViewName
	self._rollbackViewName = rollbackViewName
end

function ScenariocopyController:enterMissionOrStory(stageCfg, dungeonView, stageView, rollbackViewName)
	local chapterCfg = ScenariocopyModel.instance:getChapterCfg()

	if checknumber(chapterCfg.chapterType) > 1 then
		-- block empty
	elseif not string.nilorempty(dungeonView) then
		if dungeonView == ViewName.OnePeopleCopyView then
			ViewMgr.instance:close(ViewName.OnePeopleStageView)
		elseif dungeonView == ViewName.AnLongCopyView then
			ViewMgr.instance:close(ViewName.AnLongStageView)
		elseif dungeonView == ViewName.MoYanCopyView then
			ViewMgr.instance:close(ViewName.MoYanStageView)
		elseif dungeonView == ViewName.NoahCopyView then
			ViewMgr.instance:close(ViewName.NoahStageView)
		elseif dungeonView == ViewName.HeartSoulDungeonView then
			ViewMgr.instance:close(ViewName.HeartSoulStageView)
		elseif not string.nilorempty(stageView) then
			ViewMgr.instance:close(stageView)
		end
	else
		ViewMgr.instance:close(ViewName.ScmainStageView)
	end

	ScenariocopyModel.instance:setStageCfg(stageCfg)

	local viewName = string.nilorempty(rollbackViewName) and dungeonView or rollbackViewName

	if stageCfg.pureAnimId > 0 then
		local isPass = ScenariocopyModel.instance:getStagePass(stageCfg.chapterId, stageCfg.stageId)
		local _this = self

		self:playStory(stageCfg.pureAnimId, function()
			if not isPass then
				_this:challegePurePlot()
			end

			if not string.nilorempty(viewName) then
				UIStateManager.instance:push(viewName)
			end
		end)
	else
		local isEnough, matType, id, matNum

		if not string.nilorempty(stageCfg.energyConsume) then
			local var_41_0, var_41_1, var_41_2 = MaterialMgr.getMatParams(stageCfg.energyConsume)

			id = var_41_1
			matType = var_41_0
			isEnough = var_41_2 <= EnergyModel.instance:getCurEnergy(var_41_1)
		else
			isEnough = true
		end

		if not isEnough then
			EnergyController.instance:openBuyView(id)

			return
		end

		if not self:getIfhasPlayStory(stageCfg.chapterId, stageCfg.stageId, OperationCopyConst.playStoryBeforeFmt) then
			if stageCfg.beforeBattleId > 0 then
				self:playStory(stageCfg.beforeBattleId, function()
					self:setIfhasPlayStory(stageCfg.chapterId, stageCfg.stageId, OperationCopyConst.playStoryBeforeFmt)
					self:openMission(viewName)
				end)
			else
				self:openMission(viewName)
			end
		else
			self:openMission(viewName)
		end
	end
end

function ScenariocopyController:getIfhasPlayStory(chapterId, stageId, key)
	local name = RoleModel.instance:getUserId() .. key .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	if nameValue == 0 then
		return false
	else
		return true
	end
end

function ScenariocopyController:setIfhasPlayStory(chapterId, stageId, key)
	local name = RoleModel.instance:getUserId() .. key .. chapterId .. stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)

	UnityEngine.PlayerPrefs.SetInt(name, 1)
end

function ScenariocopyController:_onEndStory(storyId)
	if self._isListening then
		local chapterId = ScenariocopyModel.instance:getChapterId()
		local stageId = ScenariocopyModel.instance:getStageId()
		local cfg = ScenariocopyModel.instance:getStageCfg()

		if cfg then
			if storyId == cfg.beforeBattleId then
				printInfo("剧情动画播完了！")
			elseif storyId == cfg.afterBattleId then
				-- block empty
			elseif storyId == cfg.pureAnimId then
				-- block empty
			end
		end

		if self._StoryEndCallBack then
			GameUtil.callBack(self._StoryEndCallBack)
		end

		self._isListening = false
		self._StoryEndCallBack = nil
	end
end

function ScenariocopyController:playStory(storyId, callback)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)

	self._StoryEndCallBack = callback
	self._isListening = true
end

function ScenariocopyController:getStoryRedPoint(storyId)
	return
end

function ScenariocopyController:setStoryRedPoint(storyId, state)
	return
end

function ScenariocopyController:getTrialedPoint(storyId)
	return
end

function ScenariocopyController:setTrialRedPoint(storyId, state)
	return
end

function ScenariocopyController:getStoryMainPass(storyId)
	local chapterCfgs = ScenariocopyConfig.instance:getChapterCfgs(storyId)
	local unlock = true

	for i, vCfg in pairs(chapterCfgs) do
		if vCfg.chapterType == 1 then
			local open = ScenariocopyModel.instance:getStagePass(vCfg.chapterId, 1)

			if not open then
				unlock = false
			end
		end
	end

	return unlock
end

function ScenariocopyController:getChapterPass(chapterId)
	local pass1 = ScenariocopyModel.instance:getStagePass(chapterId, 1)
	local pass2 = ScenariocopyModel.instance:getStagePass(chapterId, 2)
	local pass3 = ScenariocopyModel.instance:getStagePass(chapterId, 3)

	return pass1 and pass2 and pass3
end

function ScenariocopyController:refreshRedPointData()
	local planId = ScenariocopyModel.instance:getPlotId()

	if planId then
		local storys

		if planId then
			storys = ScenariocopyConfig.instance:getStoryCfgs(planId)
		end

		if storys then
			for k, v in pairs(storys) do
				local isUnlock = self:getStoryIfUnlockAndText(v.typeId)
				local state = self:getStoryRedPoint(v.typeId)

				if isUnlock and state == 0 then
					self:setStoryRedPoint(v.typeId, 1)
				end
			end

			local trialId = ScenariocopyModel.instance:getTrialId()
			local state = self:getTrialedPoint(trialId)

			if state == 0 then
				self:setTrialRedPoint(trialId, 1)
			end
		end
	end
end

function ScenariocopyController:updateEntranceRedPoint()
	local res = self:isMoYanCopyShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY, res)

	res = self:isNuoYaCopyShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_NUOYA, res)

	res = self:isHeartSoulShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_ONE, res)

	res = self:isFirstClickShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_ONE, res)

	res = self:isDreamyouthShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DREAMYOUTH, res)

	res = self:isCopyViewShopDayFirstClickShowRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_SHOP, res)

	res = self:isNeedToShowTrialBuffRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_SCTRIAL_BUFF, res)
	self:ifNeedToShowTrialEnergyRedThenShow()
end

function ScenariocopyController:dailyRefresh()
	if ScenariocopyModel.instance:refreshActIdandPlotId() then
		ScenariocopyModel.instance:setHasGainBuffPrize(false)
		ScenariocopyController.instance:setCopyViewShopDayFirstClickRedPoint(false)
	end

	self:updateEntranceRedPoint()
	self:notify(GlobalNotify.ScmainDailyRefresh)
end

function ScenariocopyController:getBuffCfg(planId)
	local cfgs = ScenariocopyConfig.instance:getBuffCfg(planId)
	local level = ScenariocopyModel.instance:getBuffLevel()

	return cfgs[level]
end

function ScenariocopyController:getTrialName(chapterCfg)
	return chapterCfg.chapterName
end

function ScenariocopyController:markOnePeopleCopyRedPoint()
	GameUtil.saveUserData(ViewName.OnePeopleCopyView, true)
end

function ScenariocopyController:isOnePeopleCopyShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.OnePeopleCopyView)

	return not isRecorded
end

function ScenariocopyController:markAnLongCopyRedPoint()
	GameUtil.saveUserData(ViewName.AnLongCopyView, true)
end

function ScenariocopyController:isAnLongCopyShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.AnLongCopyView)

	return not isRecorded
end

function ScenariocopyController:markMoYanCopyRedPoint()
	GameUtil.saveUserData(ViewName.MoYanCopyView, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY, false)
end

function ScenariocopyController:isMoYanCopyShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.MoYanCopyView)

	return not isRecorded
end

function ScenariocopyController:markNuoYaCopyRedPoint()
	GameUtil.saveUserData(ViewName.NoahCopyView, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_NUOYA, false)
end

function ScenariocopyController:isNuoYaCopyShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.NoahCopyView)

	return not isRecorded
end

function ScenariocopyController:markHeartSoulRedPoint()
	GameUtil.saveUserData(ViewName.HeartSoulStageView, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_ONE, false)
end

function ScenariocopyController:isHeartSoulShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.HeartSoulStageView)

	return not isRecorded
end

function ScenariocopyController:markDreamyouthShowRedPoint()
	GameUtil.saveUserData(ViewName.DreamyouthView, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DREAMYOUTH, false)
end

function ScenariocopyController:isDreamyouthShowRedPoint()
	local isRecorded = GameUtil.getUserData(ViewName.DreamyouthView)

	return not isRecorded
end

function ScenariocopyController:getFirstClickRedPointKey()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.OperationPlot)

	if cfg == nil then
		return nil
	end

	return ScenariocopyModel.DUNGEONMAINHUDFIRSTCLICKREDPOINT .. cfg.activityId
end

function ScenariocopyController:markFirstClickRedPoint()
	local key = self:getFirstClickRedPointKey()

	if not string.nilorempty(key) then
		GameUtil.saveUserData(key, true)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_ONE, false)
	end
end

function ScenariocopyController:isFirstClickShowRedPoint()
	local key = self:getFirstClickRedPointKey()

	return not ((not string.nilorempty(key) or nil) and GameUtil.getUserData(key))
end

function ScenariocopyController:getCopyViewShopDayFirstClickRedPointKey()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.OperationPlot)

	if actCfg == nil then
		return nil
	end

	return ScenariocopyModel.COPYVIEWSHOPDAYFIRSTCLICKREDPOINT .. actCfg.activityId
end

function ScenariocopyController:setCopyViewShopDayFirstClickRedPoint(isActivated)
	isActivated = isActivated or false

	local key = self:getCopyViewShopDayFirstClickRedPointKey()

	if not string.nilorempty(key) then
		GameUtil.saveUserData(key, not isActivated)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_SHOP, isActivated)
	end
end

function ScenariocopyController:isCopyViewShopDayFirstClickShowRedPoint()
	local key = self:getCopyViewShopDayFirstClickRedPointKey()

	return not ((not string.nilorempty(key) or nil) and GameUtil.getUserData(key))
end

function ScenariocopyController:isNeedToShowTrialBuffRedPoint()
	local hasGainBuff = ScenariocopyModel.instance:getHasGainBuffPrize()

	return not hasGainBuff
end

function ScenariocopyController:ifNeedToShowTrialEnergyRedThenShow(id)
	local actId = ScenariocopyModel.instance:getActivityId()
	local scCfg = ScenariocopyConfig.instance:getActCfg(checknumber(actId))

	if scCfg == nil then
		return
	end

	local energyMat = scCfg.energy
	local energyMatArr = string.splitToNumber(energyMat, ":")
	local energyType, energyId = energyMatArr[1], energyMatArr[2]
	local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)

	if energyCfg == nil then
		return
	end

	if id ~= nil and energyId ~= id then
		return
	end

	local totalCount = EnergyModel.instance:getCurEnergy(energyId)
	local isEnoughEnergy = totalCount >= 80
	local isInActivityTime = ActivityDefineController:isInActivityTimeById(energyCfg.activityType, energyCfg.activityId)
	local isNeedShowRed = isEnoughEnergy and isInActivityTime

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_SCTRIAL_ENERGY, isNeedShowRed)
end

ScenariocopyController.instance = ScenariocopyController.New()

return ScenariocopyController
