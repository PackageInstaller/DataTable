-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/controller/ChuangkongunionController.lua

module("logic.extensions.chuangkongunion.controller.ChuangkongunionController", package.seeall)

local ChuangkongunionController = class("ChuangkongunionController", BaseController)

ChuangkongunionController.DATA_CHANGE = "chuangkongunion_data_change"

function ChuangkongunionController:ctor()
	return
end

function ChuangkongunionController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
	ChuangKongUnionAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onAgentChangeSet, self))
end

function ChuangkongunionController:onReset()
	self._lastTabOpen = 0
end

function ChuangkongunionController:getLastTabOpen()
	self._lastTabOpen = 0

	return self._lastTabOpen
end

function ChuangkongunionController:setLastTabOpen(value)
	self._lastTabOpen = value
end

function ChuangkongunionController:_checkRefreshTime()
	self:getTaskInfo()
end

function ChuangkongunionController:getTrialInfo()
	local activityId = self:getActId()

	ChuangKongUnionAgent.instance:sendPM_CKUGetBreachFormInfoReq(activityId)
end

function ChuangkongunionController:getTaskInfo()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CHUANG_KONG_UNION)

	if cfg ~= nil then
		local actId = self:getActId()

		if actId <= 0 then
			ChuangkongunionModel.instance:setActId(cfg.activityId)

			actId = cfg.activityId
		end

		ChuangKongUnionAgent.instance:sendPM_CKUGetDailyTaskInfoReq(actId)
	end
end

function ChuangkongunionController:getActId()
	return ChuangkongunionModel.instance:getActId()
end

function ChuangkongunionController:sweepTask(taskId)
	local activityId = self:getActId()

	ChuangKongUnionAgent.instance:sendPM_CKUDoDailyTaskReq(activityId, taskId, true)
end

function ChuangkongunionController:onDataChange(msg)
	self:updateRedPoint()
	self:notify(ChuangkongunionController.DATA_CHANGE)
end

function ChuangkongunionController:startTask(taskId)
	local isFinish = ChuangkongunionModel.instance:isFinishTask(taskId)
	local isOpen = ChuangkongunionModel.instance:isOpenTask(taskId)
	local isCanDo = ChuangkongunionModel.instance:isCanDoTask(taskId)

	if isOpen and isCanDo then
		local cfg = ChuangkongunionConfig.instance:getTaskCfg(ChuangkongunionModel.instance:getActId())[taskId]
		local activityId = self:getActId()

		if cfg.taskType == 1 then
			self:openChuangkongDailyTaskMission(taskId, activityId)
		elseif cfg.taskType == 2 then
			self:openAnswerQuestionView(taskId, activityId)
		elseif cfg.taskType == 3 then
			self:openPickAPetView(taskId, activityId)
		end
	end

	if not isOpen then
		FloatWordMgr.instance:show("任务未开启")
	elseif isFinish then
		FloatWordMgr.instance:show("任务已完成")
	elseif not isCanDo then
		FloatWordMgr.instance:show("请先完成上一个关卡")
	end
end

function ChuangkongunionController:openShop()
	UIStateManager.instance:push(ViewName.ActivityshopexchangeView, GameEnum.ActivityType.CHUANG_KONG_UNION, ChuangkongunionModel.instance:getActId())
end

function ChuangkongunionController:openChuangkongMission(stageCfg, activityId)
	ChuangkongunionModel.instance:setSupport(stageCfg.petPlan)
	UIStateManager.instance:push(ViewName.ChuangkongunionMissionView, stageCfg, activityId)
end

function ChuangkongunionController:openChuangkongDailyTaskMission(taskId, activityId)
	UIStateManager.instance:push(ViewName.ChuangkongunionMissionView, taskId, activityId, ChuangkongunionModel.instance:getTeamId(taskId))
end

function ChuangkongunionController:isTaskUnlock(taskIds)
	for i, v in ipairs(taskIds) do
		local unlock = ChuangkongunionModel.instance:isOpenTask(v) and ChuangkongunionModel.instance:isCanDoTask(v)

		if unlock then
			return true
		end
	end

	return false
end

function ChuangkongunionController:isTaskFinished(taskIds)
	for i, v in ipairs(taskIds) do
		local isFinish = ChuangkongunionModel.instance:isFinishTask(v)

		if not isFinish then
			return false
		end
	end

	return true
end

function ChuangkongunionController:openTaskView(taskIds)
	for i, v in ipairs(taskIds) do
		local isOpen = ChuangkongunionModel.instance:isOpenTask(v)
		local isCanDo = ChuangkongunionModel.instance:isCanDoTask(v)
		local isFinish = ChuangkongunionModel.instance:isFinishTask(v)

		if isOpen and isCanDo and not isFinish then
			self:startTask(v)

			return
		end
	end
end

function ChuangkongunionController:openPickAPetView(taskId, activityId)
	local mo = ChuangkongPickAPet.New()

	mo:setActivityId(activityId)
	mo:setTaskId(taskId)
	mo:setGateId(3)
	mo:setOnCloseCallback(function()
		printInfo("test 找茬小游戏")
		UIStateManager.instance:push(ViewName.ChuangkongunionView, 3)
	end)
	UIStateManager.instance:push(ViewName.PickAPetView, mo)
end

function ChuangkongunionController:openAnswerQuestionView(taskId, activityId)
	local mo = CkUnionAnswerMO.New()

	mo:setActivityId(activityId)
	mo:setTaskId(taskId)
	mo:setOnCloseCallback(function()
		printInfo("test 问答小游戏")
		UIStateManager.instance:push(ViewName.ChuangkongunionView, 3)
	end)
	UIStateManager.instance:push(ViewName.CKAnswerQuestionView, mo)
end

ChuangkongunionController.TAB_KEY = "chuangkongunion_tab"

function ChuangkongunionController:updateRedPoint()
	local tab = 1

	GameUtil.getUserData(ChuangkongunionController.TAB_KEY .. tab, function(hasOpenTab1)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_CHUANG_KONG_PLOT, not hasOpenTab1)
	end)

	tab = 2

	GameUtil.getUserDayData(ChuangkongunionController.TAB_KEY .. 2, function(hasOpenTab2Today)
		local trialRedPointFromServer = RedPointModel.instance:isActive(RedPointModel.ID_CHUANG_KONG_TRIAL_SERVER)

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_CHUANG_KONG_TRIAL, not hasOpenTab2Today and trialRedPointFromServer)
	end)

	tab = 3

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CHUANG_KONG_TASK, ChuangkongunionModel.instance:hasAnyTaskCanDo())
end

function ChuangkongunionController:markShowTab(tab)
	if tab == 1 then
		GameUtil.saveUserData(ChuangkongunionController.TAB_KEY .. tab, true)
	end

	if tab == 2 then
		GameUtil.saveUserDayData(ChuangkongunionController.TAB_KEY .. tab, true)
	end

	self:setLastTabOpen(tab)
	self:updateRedPoint()
end

function ChuangkongunionController:onAgentChangeSet(changeSetId, msgName)
	if msgName == "handlePM_CKUBreachFormEndRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

ChuangkongunionController.instance = ChuangkongunionController.New()

return ChuangkongunionController
