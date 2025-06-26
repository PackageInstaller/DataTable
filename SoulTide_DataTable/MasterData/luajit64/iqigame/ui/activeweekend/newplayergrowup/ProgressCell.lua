-- chunkname: @IQIGame\\UI\\ActiveWeekend\\NewPlayerGrowUp\\ProgressCell.lua

local ProgressCell = {}

function ProgressCell.New(view)
	local obj = Clone(ProgressCell)

	obj:Init(view)

	return obj
end

function ProgressCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end

	self.goState2.transform:Find("Text_01"):GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewFinishSign")
end

function ProgressCell:Open(taskData, curProgress)
	self.taskData = taskData
	self.curProgress = curProgress
	self.cfgTask = CfgMainQuestTable[self.taskData.cid]

	self.View:SetActive(true)
	self:RefreshMisc()
	self:RefreshState()
	self:OnAddListeners()
end

function ProgressCell:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function ProgressCell:OnHide()
	self:OnRemoveListeners()
end

function ProgressCell:OnDestroy()
	self:OnRemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ProgressCell:OnAddListeners()
	self:OnRemoveListeners()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
end

function ProgressCell:OnRemoveListeners()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
end

function ProgressCell:OnClickBtnSelf()
	if self.state == 1 then
		TaskModule.SendCommitTaskMsg(self.cfgTask.Id)
	else
		local state

		state = self.state == 2 and 1 or 3

		local rewards = {}

		for i, v in ipairs(self.cfgTask.Reward) do
			if i % 2 ~= 0 then
				rewards[#rewards + 1] = {
					id = v,
					num = self.cfgTask.Reward[i + 1]
				}
			end
		end

		UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
			Rewards = rewards,
			State = state
		})
	end
end

function ProgressCell:RefreshMisc()
	self.goState1.transform:Find("Text_01"):GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewProgressScore", self.taskData.TargetNum, self.curProgress)
	self.goState3.transform:Find("Text_01"):GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewProgressScore", self.taskData.TargetNum, self.curProgress)

	local icon = self.goIcon:GetComponent("Image")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgTask.Reward[1]].Icon), icon)
end

function ProgressCell:RefreshState()
	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.taskData.CurrentNum >= self.taskData.TargetNum then
			self.state = 1
		else
			self.state = 3
		end
	else
		self.state = 2
	end

	self.goState1:SetActive(self.state == 1)
	self.goState2:SetActive(self.state == 2)
	self.goState3:SetActive(self.state == 3)
end

return ProgressCell
