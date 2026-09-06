-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/model/OpSummaryModel.lua

module("logic.extensions.operationsummary.model.OpSummaryModel", package.seeall)

local OpSummaryModel = class("OpSummaryModel", BaseModel)

OpSummaryModel.TAB_JINGJIU = 1
OpSummaryModel.TAB_TIANYAN = 2
OpSummaryModel.SAVE_KEY = "OpSummaryModel_"
OpSummaryModel.FIRST_ANIM = "OpSummaryAnimFirst"
OpSummaryModel.HAD_OPENITEM = "OpSummaryHadOpenItem"
OpSummaryModel.KEY_ABOUTNEW = "OpSummary_aboutNew"
OpSummaryModel.RECHARGEJUMPHUODOT = "OpSummaryModel.RECHARGEJUMPHUODOT"
OpSummaryModel.REDID_NEWTAB = "OSRdNT"
OpSummaryModel.CURGRANDSUMINFO = {
	{
		activityId = 17037,
		redId = RedPointModel.ID_GRANDSUMMARYONE
	},
	{
		activityId = 17038,
		redId = RedPointModel.ID_GRANDSUMMARYTWO
	}
}

function OpSummaryModel:ctor()
	return
end

function OpSummaryModel:onInit()
	self:onReset()
end

function OpSummaryModel:onReset()
	self._selectTab = OpSummaryModel.TAB_JINGJIU
	self._haveInvitation = false
	self.taskInfos = {}
	self.collectionInfos = {}
	self.totalScore = 0
	self.hasGainProgessPrize = {}
	self.hasLotteryTimes = 0
	self.lotteryScores = 0
	self.hasGainLotteryProgessPrize = {}
	self.curLotteryPrizeId = 0
	self.taskId = nil
	self.summaryId = 0
	self.moonProgressInfos = {}
end

function OpSummaryModel:getOpenActivityId()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Summary)
	local id

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end

		id = item.activityId
	end

	printError("can find open activity (alreadly return the last one)")

	return id
end

function OpSummaryModel:getSelectTab()
	return self._selectTab
end

function OpSummaryModel:setSelectTab(tab)
	self._selectTab = tab
end

function OpSummaryModel:getCurActivityId()
	return self.summaryId
end

function OpSummaryModel:isNewItem(cfg, actType)
	if cfg.activityType == 0 or cfg.activityId == 0 then
		return false
	end

	local cfgAty = ActivityDefineConfig.instance:getCfgById(cfg.activityType, cfg.activityId)

	if cfgAty then
		local isIn = GameUtil.checkIsInTimePeriod(cfgAty.startTime, cfgAty.endTime)

		if not isIn then
			return false
		end

		local allActOpenCfg = ActivityDefineConfig.instance:getCfgById(actType, cfg.planId)

		if GameUtil.string2time(cfgAty.startTime) <= GameUtil.string2time(allActOpenCfg.startTime) then
			return false
		end

		local key = OpSummaryModel.HAD_OPENITEM .. cfg.planId .. cfg.id

		if GameUtil.getUserData(key) then
			return false
		end

		return true
	else
		printError(">>>>>>>>>>> 这配了个啥 activityType=" .. cfg.activityType .. "activityId = " .. cfg.activityId)

		return false
	end
end

function OpSummaryModel:setNewItem(cfg)
	if cfg.activityType == 0 or cfg.activityId == 0 then
		return
	end

	local key = OpSummaryModel.HAD_OPENITEM .. cfg.planId .. cfg.id

	GameUtil.saveUserData(key, true)
end

function OpSummaryModel:isHaveNewOne()
	local id = self:getCurActivityId()
	local cfgs = OperationSummaryConfig.instance:getItemCfg(id)

	for k, v in pairs(cfgs) do
		if self:isNewItem(v, GameEnum.ActivityType.Summary) then
			return true
		end
	end

	return false
end

function OpSummaryModel:getTaskInfo(taskId)
	if self.taskInfos then
		return self.taskInfos[taskId] or {}
	end

	return {}
end

function OpSummaryModel:getTaskProgress(taskId)
	local info = self:getTaskInfo(taskId)

	return (info or nil) and (info.curProgress or 0)
end

function OpSummaryModel:isHasGainPrizeAsTask(taskId)
	local info = self:getTaskInfo(taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function OpSummaryModel:getTaskCompleteNum(summaryId, arr)
	local num = 0
	local hasRed = false

	for i, taskId in ipairs(arr) do
		local info = self:getTaskInfo(taskId)

		if info.hasGainPrize then
			num = num + 1
		else
			local data = OperationSummaryConfig.instance:getTaskDetailsCfgById(summaryId, taskId)
			local tmp = checknumber(info.curProgress)

			if tmp >= checknumber(data.maxProgress) then
				hasRed = true
			end
		end
	end

	return num, hasRed
end

function OpSummaryModel:getHaveGetInvitation(activityId)
	local key = OpSummaryModel.SAVE_KEY .. activityId
	local state = GameUtil.getUserData(key)

	if checknumber(state) == 1 or state == nil then
		return true
	else
		return false
	end
end

function OpSummaryModel:setHaveGetInvitation(activityId, state)
	local key = OpSummaryModel.SAVE_KEY .. activityId

	GameUtil.saveUserData(key, state)
end

function OpSummaryModel:sendGetAllTask(summaryId)
	self.summaryId = summaryId

	ActivitySummaryAgent.instance:sendPM_ActivitySummaryGetTaskInfosReq(summaryId)
end

function OpSummaryModel:getGetAllTask(msg)
	self.taskInfos = {}

	for k, v in ipairs(msg.taskInfos) do
		self.taskInfos[v.taskId] = v
	end

	self.totalScore = checknumber(msg.totalScore)
	self.hasGainProgessPrize = msg.hasGainProgessPrize or {}
	self.hasLotteryTimes = checknumber(msg.hasLotteryTimes)
	self.lotteryScores = checknumber(msg.lotteryScores)
	self.hasGainLotteryProgessPrize = msg.hasGainLotteryProgessPrize or {}
	self.summaryId = msg.summaryId

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryGetTaskInfo)
end

function OpSummaryModel:handleSummaryStatisticsGetInfoRes(msg)
	self.collectionInfos = {}

	for _, info in ipairs(msg.infos) do
		if not self.collectionInfos[info.id] then
			self.collectionInfos[info.id][info.subId] = info
			self.collectionInfos[info.id] = self.collectionInfos[info.id]
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryStatisticsGetInfoRes)
end

function OpSummaryModel:getCollectionNum(id, subId)
	if not (self.collectionInfos[id] or {})[subId] then
		local info = {}

		return info.num or 0
	end
end

function OpSummaryModel:sendGetTaskPrize(summaryId, taskId)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryGainTaskPrizeReq(summaryId, taskId)
end

function OpSummaryModel:onGetTaskPrize(msg)
	self.summaryId = msg.summaryId

	local taskInfo = self:getTaskInfo(msg.taskId)

	taskInfo.curProgress = taskInfo.curProgress + 1
	taskInfo.hasGainPrize = true

	local data = OperationSummaryConfig.instance:getTaskDetailsCfgById(self.summaryId, msg.taskId)

	self.totalScore = self.totalScore + checknumber(data.score)

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryGetTaskInfo)
end

function OpSummaryModel:sendPlayStroy(summaryId, taskId)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryFinishStoryReq(summaryId, taskId)
end

function OpSummaryModel:onPlayStroy(msg)
	self.summaryId = msg.summaryId

	local taskInfo = msg.taskInfo

	self.taskInfos[taskInfo.taskId] = taskInfo

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryGetTaskInfo)
end

function OpSummaryModel:sendGetPrize(summaryId, taskId)
	self.taskId = taskId

	ActivitySummaryAgent.instance:sendPM_ActivitySummaryGainProgressPrizeReq(summaryId, taskId)
end

function OpSummaryModel:onGetProgressPrize(msg)
	self.summaryId = msg.summaryId

	if self.taskId then
		table.insert(self.hasGainProgessPrize, self.taskId)

		self.taskId = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_ActivitySummaryGetTaskInfo)
end

function OpSummaryModel:sendLotteryReq(summaryId, handler, handlerObj, errHandler)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryLotteryReq(summaryId, handler, handlerObj, errHandler)
end

function OpSummaryModel:onGetLotteryRes(msg)
	self.summaryId = msg.summaryId
	self.curLotteryPrizeId = msg.changeSetId

	self:sendGetAllTask(self.summaryId)
end

function OpSummaryModel:sendGainLotteryProgressPrize(summaryId, prizeId)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryGainLotteryProgressPrizeReq(summaryId, prizeId)
end

function OpSummaryModel:onGetLotteryProgressPrize(msg)
	self.summaryId = msg.summaryId

	table.insert(self.hasGainLotteryProgessPrize, msg.changeSetId)
	self:sendGetAllTask(self.summaryId)
end

function OpSummaryModel:checkRechargeJumpHudDot()
	local value = GameUtil.getUserData(OpSummaryModel.RECHARGEJUMPHUODOT)

	return string.nilorempty(value)
end

function OpSummaryModel:clearRechargeJumpHudDot()
	GameUtil.saveUserData(OpSummaryModel.RECHARGEJUMPHUODOT, "ok")
end

function OpSummaryModel:setAdmireMoonInfo(msg)
	GameUtil.pbToTable(msg, self.moonProgressInfos)
end

function OpSummaryModel:getAdmireMoonInfo()
	return self.moonProgressInfos.progressInfos or {}
end

OpSummaryModel.instance = OpSummaryModel.New()

return OpSummaryModel
