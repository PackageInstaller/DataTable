-- chunkname: @IQIGame\\UI\\Guild\\GuildTask\\GuildTaskItem.lua

local ActivityTaskItem = require("IQIGame.UI.Activity.Common.ActivityTaskItem")
local GuildTaskItemState = require("IQIGame.UI.Guild.GuildTask.GuildTaskItemState")
local m = {}

m = extend(ActivityTaskItem, m)

function m.New(view, rewardPool, api)
	local obj = Clone(m)

	obj:Init(view, rewardPool, api)

	return obj
end

function m:Init(view, rewardPool, api)
	self:BaseInit(view)

	self.StateViews[m.STATE_PROCESSING] = GuildTaskItemState.New(self.ProcessingView, m.STATE_PROCESSING, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
	self.StateViews[m.STATE_REWARD] = GuildTaskItemState.New(self.RewardView, m.STATE_REWARD, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
	self.StateViews[m.STATE_FINISHED] = GuildTaskItemState.New(self.FinishedView, m.STATE_FINISHED, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end, function(taskCid, taskState)
		self:OnRewardBtn(taskCid, taskState)
	end)
end

function m:OnRewardBtn(taskCid, taskState)
	local cfgMainQuestData = CfgMainQuestTable[taskCid]
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
