-- chunkname: @IQIGame\\UI\\MagicTower\\MagicTowerTaskItem.lua

local ActivityTaskItem = require("IQIGame.UI.Activity.Common.ActivityTaskItem")
local MagicTowerTaskItemState = require("IQIGame.UI.MagicTower.MagicTowerTaskItemState")
local m = {}

m = extend(ActivityTaskItem, m)

function m.New(view, rewardPool, api)
	local obj = Clone(m)

	obj:Init(view, rewardPool, api)

	return obj
end

function m:Init(view, rewardPool, api)
	self:BaseInit(view)

	self.StateViews[m.STATE_PROCESSING] = MagicTowerTaskItemState.New(self.ProcessingView, m.STATE_PROCESSING, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_REWARD] = MagicTowerTaskItemState.New(self.RewardView, m.STATE_REWARD, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_FINISHED] = MagicTowerTaskItemState.New(self.FinishedView, m.STATE_FINISHED, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
end

function m:Dispose()
	self:BaseDispose()
end

return m
