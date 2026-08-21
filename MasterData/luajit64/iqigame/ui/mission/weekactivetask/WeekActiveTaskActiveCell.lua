-- chunkname: @IQIGame\\UI\\Mission\\WeekActiveTask\\WeekActiveTaskActiveCell.lua

local WeekActiveTaskActiveCell = {
	cellDoing = {},
	cellReward = {},
	cellOver = {}
}

function WeekActiveTaskActiveCell.New(view)
	local obj = Clone(WeekActiveTaskActiveCell)

	obj:Init(view)

	return obj
end

function WeekActiveTaskActiveCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.BindOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.BindOutlet(self.goCellOver, self.cellOver)

	self.cellDoing.tfActiveValue = self.cellDoing.goActiveValue:GetComponent("Text")
	self.cellDoing.tfActiveLv = self.cellDoing.goActiveLv:GetComponent("Text")
	self.cellReward.tfActiveValue = self.cellReward.goActiveValue:GetComponent("Text")
	self.cellReward.tfActiveLv = self.cellReward.goActiveLv:GetComponent("Text")
	self.cellOver.tfActiveValue = self.cellOver.goActiveValue:GetComponent("Text")
	self.cellOver.tfActiveLv = self.cellOver.goActiveLv:GetComponent("Text")

	self:AddListener()
end

function WeekActiveTaskActiveCell:Refresh(taskData, index)
	self.taskData = taskData
	self.index = index
	self.cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.taskData.CurrentNum >= self.taskData.TargetNum then
			self.state = 2
		else
			self.state = 1
		end
	else
		self.state = 3
	end

	self:RefreshState(self.state)
end

function WeekActiveTaskActiveCell:OnHide()
	self:RemoveListener()
end

function WeekActiveTaskActiveCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.ClearOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.ClearOutlet(self.goCellOver, self.cellOver)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function WeekActiveTaskActiveCell:AddListener()
	return
end

function WeekActiveTaskActiveCell:RemoveListener()
	return
end

function WeekActiveTaskActiveCell:OnSelected()
	if self.state == 1 then
		local rewards = {}

		for i, v in ipairs(self.cfgTaskData.Reward) do
			if i % 2 ~= 0 then
				rewards[#rewards + 1] = {
					id = v,
					num = self.cfgTaskData.Reward[i + 1]
				}
			end
		end

		UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
			GetState = false,
			Rewards = rewards
		})
	elseif self.state == 2 then
		TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
	end
end

function WeekActiveTaskActiveCell:RefreshState(state)
	self.goCellDoing:SetActive(state == 1)
	self.goCellReward:SetActive(state == 2)
	self.goCellOver:SetActive(state == 3)

	if state == 1 then
		self:RefreshTemplate(self.cellDoing)
	elseif state == 2 then
		self:RefreshTemplate(self.cellReward)
	elseif state == 3 then
		self:RefreshTemplate(self.cellOver)
	end
end

function WeekActiveTaskActiveCell:RefreshTemplate(template)
	template.tfActiveValue.text = MissionUIApi:GetString("activeViewActiveValue", self.taskData.TargetNum)
	template.tfActiveLv.text = MissionUIApi:GetString("activeViewActiveLv", self.index)
end

return WeekActiveTaskActiveCell
