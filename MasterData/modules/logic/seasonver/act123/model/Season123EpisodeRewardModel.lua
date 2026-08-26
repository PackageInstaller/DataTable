-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeRewardModel.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeRewardModel", package.seeall)

local Season123EpisodeRewardModel = class("Season123EpisodeRewardModel", BaseModel)

function Season123EpisodeRewardModel:init(actId, taskInfoList)
	self.stageRewardMap = {}
	self.curActId = actId

	self:initStageRewardConfig(taskInfoList)
end

function Season123EpisodeRewardModel:release()
	self:clear()

	self.stageRewardMap = {}
	self.curActId = 0
end

function Season123EpisodeRewardModel:initStageRewardConfig(taskInfoList)
	for id, mo in pairs(taskInfoList) do
		if mo.config and mo.config.seasonId == self.curActId and mo.config.isRewardView == Activity123Enum.TaskRewardViewType then
			local paramList = Season123Config.instance:getTaskListenerParamCache(mo.config)
			local stage = tonumber(paramList[1])
			local rewardMOMap = self.stageRewardMap[stage]

			rewardMOMap = rewardMOMap or {}
			rewardMOMap[id] = mo
			self.stageRewardMap[stage] = rewardMOMap
		end
	end
end

function Season123EpisodeRewardModel:setTaskInfoList(stage)
	local rewardList = {}

	if not self.stageRewardMap[stage] then
		if GameUtil.getTabLen(self.stageRewardMap[stage]) == 0 then
			logError("task_activity123 config is not exited, actid: " .. self.curActId .. ",stageId: " .. stage)
		end

		for id, rewardMO in pairs(self.stageRewardMap[stage]) do
			table.insert(rewardList, rewardMO)
		end

		self:setList(rewardList)
		self:sort(Season123EpisodeRewardModel.sortList)
	end
end

function Season123EpisodeRewardModel.sortList(a, b)
	local ATargetNum = tonumber(string.split(a.config.listenerParam, "#")[2])
	local BTargetNum = tonumber(string.split(b.config.listenerParam, "#")[2])

	return BTargetNum < ATargetNum
end

function Season123EpisodeRewardModel:getCurStageCanGetReward()
	local canGetRewardList = {}
	local list = self:getList()

	for index, mo in ipairs(list) do
		if mo.progress >= mo.config.maxProgress and mo.hasFinished then
			table.insert(canGetRewardList, mo.id)
		end
	end

	return canGetRewardList
end

Season123EpisodeRewardModel.instance = Season123EpisodeRewardModel.New()

return Season123EpisodeRewardModel
