-- chunkname: @IQIGame\\UI\\Guild\\GuildTask\\GuildMissionItem.lua

local ActivityTaskItem = require("IQIGame.UI.Activity.Common.ActivityTaskItem")
local GuildMissionItemState = require("IQIGame.UI.Guild.GuildTask.GuildMissionItemState")
local m = {}

m = extend(ActivityTaskItem, m)

function m.New(view, rewardPool, api)
	local obj = Clone(m)

	obj:Init(view, rewardPool, api)

	return obj
end

function m:Init(view, rewardPool, api)
	self:BaseInit(view, rewardPool, api)

	self.StateViews[m.STATE_PROCESSING] = GuildMissionItemState.New(self.ProcessingView, m.STATE_PROCESSING, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
	self.StateViews[m.STATE_REWARD] = GuildMissionItemState.New(self.RewardView, m.STATE_REWARD, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
	self.StateViews[m.STATE_FINISHED] = GuildMissionItemState.New(self.FinishedView, m.STATE_FINISHED, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
end

function m:SetData(guildMissData)
	self.guildMissData = guildMissData

	local taskState

	if self.guildMissData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		taskState = m.STATE_FINISHED
	elseif self.guildMissData.CurrentNum >= self.guildMissData.TargetNum then
		taskState = m.STATE_REWARD
	else
		taskState = m.STATE_PROCESSING
	end

	for state, stateController in pairs(self.StateViews) do
		stateController:SetData(guildMissData, taskState)
	end
end

function m:OnClickBtn(state)
	log("state " .. state)

	if state == m.STATE_PROCESSING then
		-- block empty
	elseif state == m.STATE_REWARD then
		GuildModule.GetGuildQuestRewards({
			self.guildMissData.Cid
		})
	end
end

function m:OnRewardBtn(taskCid, taskState)
	local cfgMainQuestData = CfgGuildMissionTable[taskCid]
	local rewards = {}

	for i = 1, #cfgMainQuestData.Reward, 2 do
		local itemCid = cfgMainQuestData.Reward[i]
		local itemNum = cfgMainQuestData.Reward[i + 1]

		table.insert(rewards, {
			id = itemCid,
			num = itemNum
		})
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		Rewards = rewards,
		State = taskState
	})
end

function m:Dispose()
	self:BaseDispose()
end

return m
