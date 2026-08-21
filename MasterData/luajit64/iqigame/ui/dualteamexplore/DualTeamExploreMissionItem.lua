-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreMissionItem.lua

local DualTeamExploreMissionItemState = require("IQIGame.UI.DualTeamExplore.DualTeamExploreMissionItemState")
local m = {
	STATE_REWARD = 2,
	STATE_FINISHED = 3,
	STATE_PROCESSING = 1,
	StateControllers = {}
}

function m.New(view, rewardCellPool)
	local obj = Clone(m)

	obj:Init(view, rewardCellPool)

	return obj
end

function m:Init(view, rewardCellPool)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 3 do
		self.StateControllers[i] = DualTeamExploreMissionItemState.New(self["StateView" .. i], i, rewardCellPool, function(state)
			self:OnClickBtn(state)
		end)
	end
end

function m:SetData(taskUIData)
	self.TaskUIData = taskUIData

	local taskState

	if taskUIData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		taskState = m.STATE_FINISHED
	elseif taskUIData.CurrentNum >= taskUIData.TargetNum then
		taskState = m.STATE_REWARD
	else
		taskState = m.STATE_PROCESSING
	end

	for i = 1, #self.StateControllers do
		self.StateControllers[i]:SetData(self.TaskUIData, taskState)
	end
end

function m:OnClickBtn(state)
	if state == m.STATE_REWARD then
		TaskModule.SendCommitTaskMsg(self.TaskUIData.cid)
	end
end

function m:Dispose()
	for i = 1, #self.StateControllers do
		self.StateControllers[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
