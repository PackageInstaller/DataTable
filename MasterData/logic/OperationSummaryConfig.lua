-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/config/OperationSummaryConfig.lua

module("logic.extensions.OperationSummary.config.OperationSummaryConfig", package.seeall)

local OperationSummaryConfig = class("OperationSummaryConfig", BaseConfig)

function OperationSummaryConfig:onInit()
	OperationSummaryConfig.super.onInit(self)
end

function OperationSummaryConfig:getNames()
	return {
		"activity_summary",
		"activity_summary_items",
		"activity_summary_items2",
		"activity_summary_bg",
		"activity_summary_story",
		"activity_summary_task_base",
		"activity_summary_task_detail",
		"activity_summary_task_items",
		"activity_summary_task_progress",
		"activity_summary_task_prize",
		"activity_reward_content",
		"activity_reward_page",
		"activity_summary_task_lottery_progress",
		"activity_summary_start_up",
		"activity_summary_story_time",
		"activity_summary_items_collect",
		"activity_summary_time_progress",
		"activity_plugin_progress_plan",
		"activity_plugin_progress_prize"
	}
end

function OperationSummaryConfig:handleConfig(name, content)
	if name == "activity_summary" then
		self._summaryCfg = content
	elseif name == "activity_summary_items" then
		self._itemCfg = content
	elseif name == "activity_summary_items2" then
		self._item2Cfg = content
	elseif name == "activity_summary_bg" then
		self._bgCfg = content
	elseif name == "activity_summary_story" then
		self._storyCfg = content
		self._storyDic = {}

		for storyId, cfg in pairs(content) do
			for subId, data in ipairs(cfg) do
				self._storyDic[data.summaryId] = self._storyDic[data.summaryId] or {}
				self._storyDic[data.summaryId][data.subId] = data
			end
		end
	elseif name == "activity_summary_task_base" then
		self._baseCfg = content
	elseif name == "activity_summary_task_detail" then
		self._detailCfg = content

		self:_handleTaskDetailCfg(content)
	elseif name == "activity_summary_task_items" then
		self._task_itemsCfg = content

		self:_handleTaskItemsCfg(content)
	elseif name == "activity_summary_task_progress" then
		self._progressCfg = content
	elseif name == "activity_summary_task_prize" then
		self._prizesCfg = content
	elseif name == "activity_reward_content" then
		self._rewardContentCfg = content
	elseif name == "activity_reward_page" then
		self._rewardPageCfg = content
	elseif name == "activity_summary_task_lottery_progress" then
		self._lotteryProgressCfg = content
	elseif name == "activity_summary_start_up" then
		self._summaryStartUpCfg = content
	elseif name == "activity_summary_story_time" then
		self._activity_summary_story_time = content
	elseif name == "activity_summary_items_collect" then
		self._activity_summary_items_collect = content
	elseif name == "activity_summary_time_progress" then
		self._activity_summary_time_progress = content
	elseif name == "activity_plugin_progress_plan" then
		self._activity_plugin_progress_plan = content
	elseif name == "activity_plugin_progress_prize" then
		self._activity_plugin_progress_prize = content
	end
end

function OperationSummaryConfig:getSummaryCfgById(id)
	return self._summaryCfg[id]
end

function OperationSummaryConfig:getSummaryCfg()
	return self._summaryCfg
end

function OperationSummaryConfig:getItemCfg(actId)
	local list = {}

	if self._itemCfg[actId] then
		for k, v in pairs(self._itemCfg[actId]) do
			table.insert(list, v)
		end
	end

	return list
end

function OperationSummaryConfig:getPopItemCfg(actId)
	return self._item2Cfg[actId]
end

function OperationSummaryConfig:getTaskItemsCfg(actId)
	return self._task_itemsCfg[actId] or {}
end

function OperationSummaryConfig:getTaskItemsData(id)
	return self._taskItemsDataList[id]
end

function OperationSummaryConfig:_handleTaskItemsCfg(content)
	self._taskItemsDataList = {}

	for _, data in pairs(content.dataList) do
		self._taskItemsDataList[data.id] = data
	end
end

function OperationSummaryConfig:getTaskDetailsCfg(actId)
	return self._detailCfg[actId] or {}
end

function OperationSummaryConfig:getTaskDetailsCfgById(actId, id)
	if self._detailCfg[actId] then
		return self._detailCfg[actId][id] or {}
	end

	return {}
end

function OperationSummaryConfig:getTaskDetailData(id)
	return self._taskDetailDataList[id]
end

function OperationSummaryConfig:_handleTaskDetailCfg(content)
	self._taskDetailDataList = {}

	for _, data in pairs(content.dataList) do
		self._taskDetailDataList[data.id] = data
	end
end

function OperationSummaryConfig:getTaskRewardCfg(actId)
	if not self._baseCfg[actId] then
		if self._baseCfg[actId].progressPlanId then
			return self._progressCfg[self._baseCfg[actId].progressPlanId] or {}
		end
	end
end

function OperationSummaryConfig:getTaskBaseCfg(id)
	return self._baseCfg[id]
end

function OperationSummaryConfig:getBaseCfg()
	return self._baseCfg
end

function OperationSummaryConfig:getPrizeCfg(id)
	return self._prizesCfg[id]
end

function OperationSummaryConfig:getAllPrizeCfg()
	return self._prizesCfg
end

function OperationSummaryConfig:getBgCfg(id)
	return self._bgCfg[id]
end

function OperationSummaryConfig:getCollectCfgs(planId, id)
	if self._activity_summary_items_collect[planId] then
		return self._activity_summary_items_collect[planId][id]
	end

	return nil
end

function OperationSummaryConfig:getProgressCfg(id)
	if not self._baseCfg[id] then
		local cfg = {}
		local id = checknumber(cfg.progressPlanId)

		return self._progressCfg[id] or {}
	end
end

function OperationSummaryConfig:getStoryCfg(id)
	return self._storyCfg[id]
end

function OperationSummaryConfig:getStoryCfgByActId(activityId)
	local curSubId = 1
	local dataList = {}

	while self._storyDic[activityId][curSubId] ~= nil do
		table.insert(dataList, self._storyDic[activityId][curSubId])

		curSubId = curSubId + 1
	end

	return dataList
end

function OperationSummaryConfig:getLotteryProgressCfg(actyId)
	if not self._baseCfg[actyId] then
		local cfg = {}
		local id = checknumber(cfg.lotteryProgressPlanId)

		return self._lotteryProgressCfg[id] or {}
	end
end

function OperationSummaryConfig:getRewardContentCfg(actyId)
	if actyId == nil then
		printError("活动id为空")

		return nil
	end

	if self._rewardContentCfg[actyId] == nil then
		printError("活动id无法在 y运营-活动汇总面板-任务型 t_activity_reward_content 中找到配置，请检查活动id是否正确")

		return nil
	end

	return self._rewardContentCfg[actyId]
end

function OperationSummaryConfig:getRewardPageCfg(actyId)
	if actyId == nil then
		printError("活动id为空")

		return nil
	end

	if self._rewardPageCfg[actyId] == nil then
		printError("活动id无法在 y运营-活动汇总面板-任务型 t_activity_reward_page 中找到配置，请检查活动id是否正确")

		return nil
	end

	return self._rewardPageCfg[actyId]
end

function OperationSummaryConfig:getSummaryStartUpCfg()
	return self._summaryStartUpCfg
end

function OperationSummaryConfig:getSummaryStartUpDataList()
	return self._summaryStartUpCfg.dataList
end

function OperationSummaryConfig:getSummaryStartUpData(key)
	return self._summaryStartUpCfg[key]
end

function OperationSummaryConfig:getOpenBgCfg(id)
	return (OperationSummaryConfig.instance:getBgCfg(id))
end

function OperationSummaryConfig:isShowItem(cfg)
	if string.nilorempty(cfg.startTime) and string.nilorempty(cfg.endTime) then
		return true
	end

	return GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime)
end

function OperationSummaryConfig:getOpenTimeInfo(cfg)
	local curType, startTime = GameUtil.inTimePeriod

	if cfg.activityId > 0 and cfg.activityType > 0 then
		local cfgAty = ActivityDefineConfig.instance:getCfgById(cfg.activityType, cfg.activityId)

		if cfgAty then
			curType = GameUtil.getTimePeriodType(cfgAty.startTime, cfgAty.endTime)
		end

		if curType == GameUtil.beforeTimePeriod then
			startTime = cfgAty.startTime
		end
	end

	return curType, startTime
end

function OperationSummaryConfig:getStoryTimeCfgList(activityId)
	return self._activity_summary_story_time[activityId]
end

function OperationSummaryConfig:getStoryIdByActivityId(activityId)
	local storyId = 0
	local list = self:getStoryTimeCfgList(activityId) or {}

	for i, v in ipairs(list) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			storyId = v.storyId

			break
		end
	end

	return storyId
end

function OperationSummaryConfig:getActSumTimeProDataList(activityId)
	return self._activity_summary_time_progress[activityId]
end

function OperationSummaryConfig:getActSumTimeProData(activityId, index)
	return self._activity_summary_time_progress[activityId][index]
end

function OperationSummaryConfig:getPluginProgressPlanCfg(activityId, progressId)
	local activityType = math.floor(activityId / 1000)

	return self._activity_plugin_progress_plan[activityType][activityId][progressId]
end

function OperationSummaryConfig:getPluginProgressPrizeCfg(planId)
	return self._activity_plugin_progress_prize[planId]
end

OperationSummaryConfig.instance = OperationSummaryConfig.New()

return OperationSummaryConfig
