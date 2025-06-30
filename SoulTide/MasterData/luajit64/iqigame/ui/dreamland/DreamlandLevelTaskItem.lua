-- chunkname: @IQIGame\\UI\\Dreamland\\DreamlandLevelTaskItem.lua

local ActivityTaskItem = require("IQIGame.UI.Activity.Common.ActivityTaskItem")
local DreamlandTaskItemState = require("IQIGame.UI.Dreamland.DreamlandTaskItemState")
local m = {
	IsLevelTask = false
}

m = extend(ActivityTaskItem, m)

function m.New(view, rewardPool, api, isLevelTask)
	local obj = Clone(m)

	obj:Init(view, rewardPool, api, isLevelTask)

	return obj
end

function m:Init(view, rewardPool, api, isLevelTask)
	self:BaseInit(view)

	self.IsLevelTask = isLevelTask
	self.StateViews[m.STATE_PROCESSING] = DreamlandTaskItemState.New(self.ProcessingView, m.STATE_PROCESSING, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_REWARD] = DreamlandTaskItemState.New(self.RewardView, m.STATE_REWARD, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_FINISHED] = DreamlandTaskItemState.New(self.FinishedView, m.STATE_FINISHED, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
end

function m:SetData(taskUIData)
	self:BaseSetData(taskUIData)

	if not self.IsLevelTask then
		return
	end

	if taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		self.NewEffect:SetActive(false)

		if DreamlandModule.IsNewTask(taskUIData.cid) then
			self.NewEffect:SetActive(true)

			local dreamlandTaskItemState = self.StateViews[m.STATE_PROCESSING]

			UIUtil.PlayDefaultAnim(dreamlandTaskItemState.View)
			DreamlandModule.RemoveNewTask(taskUIData.cid)
		end
	end
end

function m:Dispose()
	self:BaseDispose()
end

return m
