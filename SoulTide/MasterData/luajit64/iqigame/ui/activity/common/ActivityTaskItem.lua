-- chunkname: @IQIGame\\UI\\Activity\\Common\\ActivityTaskItem.lua

local m = {
	STATE_FINISHED = 3,
	STATE_PROCESSING = 1,
	STATE_REWARD = 2,
	StateViews = {}
}
local ActivityTaskItemState = require("IQIGame.UI.Activity.Common.ActivityTaskItemState")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, rewardPool, api)
	local obj = Clone(m)

	obj:Init(view, rewardPool, api)

	return obj
end

function m:Init(view, rewardPool, api)
	self:BaseInit(view)

	self.StateViews[m.STATE_PROCESSING] = ActivityTaskItemState.New(self.ProcessingView, m.STATE_PROCESSING, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_REWARD] = ActivityTaskItemState.New(self.RewardView, m.STATE_REWARD, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
	self.StateViews[m.STATE_FINISHED] = ActivityTaskItemState.New(self.FinishedView, m.STATE_FINISHED, rewardPool, api, function(state)
		self:OnClickBtn(state)
	end)
end

function m:BaseInit(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m.CreateRewardPool(size, commonSlotUIPrefab)
	local rewardPool = UIObjectPool.New(size, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(commonSlotUIPrefab), true, true)
	end, function(cell)
		local v = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	return rewardPool
end

function m:SetData(taskUIData)
	self:BaseSetData(taskUIData)
end

function m:BaseSetData(taskUIData)
	self.TaskUIData = taskUIData

	local taskState

	if taskUIData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		taskState = m.STATE_FINISHED
	elseif taskUIData.CurrentNum >= taskUIData.TargetNum then
		taskState = m.STATE_REWARD
	else
		taskState = m.STATE_PROCESSING
	end

	for state, stateController in pairs(self.StateViews) do
		stateController:SetData(taskUIData, taskState)
	end
end

function m:OnClickBtn(state)
	if state == m.STATE_PROCESSING then
		-- block empty
	elseif state == m.STATE_REWARD then
		TaskModule.SendCommitTaskMsg(self.TaskUIData.cid)
	end
end

function m:Dispose()
	self:BaseDispose()
end

function m:BaseDispose()
	for i, stateController in pairs(self.StateViews) do
		stateController:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
