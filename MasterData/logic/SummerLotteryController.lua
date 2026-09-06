-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/controller/SummerLotteryController.lua

module("logic.extensions.summerlottery.controller.SummerLotteryController", package.seeall)

local SummerLotteryController = class("SummerLotteryController", BaseController)

SummerLotteryController.E_GetInfoRes = "E_GetInfoRes"
SummerLotteryController.E_GainTaskInfoRes = "E_GainTaskInfoRes"
SummerLotteryController.E_GainTaskPrizeRes = "E_GainTaskPrizeRes"
SummerLotteryController.E_GainTaskProgressPrize = "E_GainTaskProgressPrize"

function SummerLotteryController:ctor()
	self.bDrawing = false
end

function SummerLotteryController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	self:_resetRedPoint()
end

function SummerLotteryController:_TickDailyRefreshData()
	self:reqGainTaskInfo()
	self:_resetRedPoint()
end

function SummerLotteryController:_resetRedPoint()
	local activityId = SummerLotteryModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.SUMMER_LOTTERY, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMER_LOTTERY_LOGIN, true)
	end
end

function SummerLotteryController:onReset()
	SummerLotteryModel.instance:onReset()

	self.bDrawing = false
end

function SummerLotteryController:isItemEnough()
	local model = SummerLotteryModel.instance
	local _, _, matNum = MaterialMgr.getMatParams(model.poolConfig.lotteryCost)
	local haveCount = MaterialMgr.getMatCount(model.poolConfig.lotteryCost)

	return matNum <= haveCount
end

function SummerLotteryController:reqGetInfo()
	local activityId = SummerLotteryModel.instance:getActivityId()

	SummerLotteryAgent.instance:sendPM_SummerLotteryGetInfoReq(activityId)
end

function SummerLotteryController:handleGetInfo(status, msg)
	if status == 0 then
		SummerLotteryModel.instance:handleGetInfo(msg)
		self:localNotify(SummerLotteryController.E_GetInfoRes)
	end
end

function SummerLotteryController:reqDraw(times)
	self.bDrawing = true

	local activityId = SummerLotteryModel.instance:getActivityId()

	SummerLotteryAgent.instance:sendPM_SummerLotteryDrawReq(activityId, times)
end

function SummerLotteryController:_playLottery(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	local prizeIds = msg.prizeIds
	local qualities = {}
	local configInstance = SummerLotteryConfig.instance
	local poolPrizePlanId = SummerLotteryModel.instance.poolConfig.poolPrizePlanId
	local bKoi = (msg.koiPrizeId or 0) > 0

	if bKoi then
		table.insert(qualities, 4)
	end

	for i = 1, #prizeIds do
		local prizeId = prizeIds[i]
		local prizeConf = configInstance:getSummerLotteryPrizeConfig(poolPrizePlanId, prizeId)

		table.insert(qualities, prizeConf.quality or 1)
	end

	table.sort(qualities, function(a, b)
		return b < a
	end)
	UIStateManager.instance:push(ViewName.SummerLotteryEffectView, {
		qualities = qualities,
		onEffectPlayFinishedFunc = function()
			self.bDrawing = false

			MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
		end
	})
end

function SummerLotteryController:handleDraw(status, msg)
	if status == 0 then
		SummerLotteryModel.instance:handleDraw(msg)
		self:_playLottery(msg)
	else
		self.bDrawing = false
	end
end

function SummerLotteryController:reqGainTaskInfo()
	local activityId = SummerLotteryModel.instance:getActivityId()

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SUMMER_LOTTERY, activityId) == true then
		SummerLotteryAgent.instance:sendPM_SummerLotteryGetTaskInfoReq(activityId)
	end
end

function SummerLotteryController:handleGainTaskInfo(status, msg)
	if status == 0 then
		SummerLotteryModel.instance:handleGetTaskInfo(msg)
		self:localNotify(SummerLotteryController.E_GainTaskInfoRes)
	end
end

function SummerLotteryController:reqGainTaskPrize(taskIds)
	if TableUtil.isTableEmpty(taskIds) then
		return
	end

	local activityId = SummerLotteryModel.instance:getActivityId()

	SummerLotteryAgent.instance:sendPM_SummerLotteryGainTaskPrizeReq(activityId, taskIds)
end

function SummerLotteryController:handleGainTaskPrize(status, msg)
	if status == 0 then
		local model = SummerLotteryModel.instance

		if not msg.taskId then
			local gainScore = 0

			for _, taskId in ipairs(msg.taskId) do
				if not model:isTaskPrizeGain(taskId) then
					local conf = SummerLotteryConfig.instance:getTaskConf(model.poolConfig.taskPlanId, taskId)

					gainScore = gainScore + checknumber(conf and conf.score)
				end
			end

			model:handleGainTaskPrize(msg.taskId, gainScore)

			if checknumber(msg.changeSetId) > 0 then
				MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
				MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
			end

			self:localNotify(SummerLotteryController.E_GainTaskPrizeRes)
		end
	end
end

function SummerLotteryController:reqGainTaskProgressPrize()
	local activityId = SummerLotteryModel.instance:getActivityId()

	SummerLotteryAgent.instance:sendPM_SummerLotteryGainProgressPrizeReq(activityId)
end

function SummerLotteryController:handleGainTaskProgressPrize(status, msg)
	if status == 0 then
		SummerLotteryModel.instance:handleGainTaskProgressPrize(msg.progressPrizeId)

		if checknumber(msg.changeSetId) > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
		end

		self:localNotify(SummerLotteryController.E_GainTaskProgressPrize)
	end
end

function SummerLotteryController:getTagIdList(activityId)
	local actCfg = SummerLotteryConfig.instance:getSummerLotteryConfig(activityId)
	local poolPlanId = actCfg and actCfg.poolPlanId
	local poolCfg = SummerLotteryConfig.instance:getSummerLotteryPoolConfig(poolPlanId)
	local taskPlanId = poolCfg and poolCfg.taskPlanId
	local tabIdList = {}
	local tabIdMap = {}

	if checknumber(taskPlanId) > 0 then
		local taskCfgs = SummerLotteryConfig.instance:getTaskCfgs(taskPlanId)

		for i, cfg in ipairs(taskCfgs) do
			if not tabIdMap[cfg.periodType] then
				tabIdMap[cfg.periodType] = true

				local tabId = GameEnum.PeriodRefreshTypeByStr[cfg.periodType]

				table.insert(tabIdList, tabId)
			end
		end
	end

	return tabIdList
end

SummerLotteryController.instance = SummerLotteryController.New()

return SummerLotteryController
