-- chunkname: @IQIGame\\UI\\ActiveWeekend\\NewPlayerGrowUp\\TaskCell.lua

local TaskCell = {
	cellDoing = {
		itemCellPool = {}
	},
	cellReward = {
		itemCellPool = {}
	},
	cellOver = {
		itemCellPool = {}
	}
}

function TaskCell.New(view)
	local obj = Clone(TaskCell)

	obj:Init(view)

	return obj
end

function TaskCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.BindOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.BindOutlet(self.goCellOver, self.cellOver)

	self.cellDoing.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.cellDoing.goItemCell, true, true)
	self.cellDoing.tfTargetDesc = self.cellDoing.goTargetDesc:GetComponent("Text")
	self.cellDoing.tfProgress = self.cellDoing.goProgress:GetComponent("Text")
	self.cellDoing.btnJump = self.cellDoing.goBtnJump:GetComponent("Button")

	function self.cellDoing.onClickBtnJumpDelegate()
		self:OnClickBtnJump()
	end

	self.cellDoing.goBtnJump.transform:Find("Text"):GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewBtnJumpTxt")
	self.cellReward.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.cellReward.goItemCell, true, true)
	self.cellReward.tfTargetDesc = self.cellReward.goTargetDesc:GetComponent("Text")
	self.cellReward.tfProgress = self.cellReward.goProgress:GetComponent("Text")
	self.cellReward.btnGet = self.cellReward.goBtnGet:GetComponent("Button")

	function self.cellReward.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	self.cellReward.goBtnGet.transform:Find("Text"):GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewBtnGetTxt")
	self.cellOver.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.cellOver.goItemCell, true, true)
	self.cellOver.tfTargetDesc = self.cellOver.goTargetDesc:GetComponent("Text")
	self.cellOver.tfProgress = self.cellOver.goProgress:GetComponent("Text")
	self.cellOver.goSign:GetComponent("Text").text = ActiveWeekendUIApi:GetString("growUpViewFinishSign")

	self:AddListener()
end

function TaskCell:Refresh(taskData)
	self.taskData = taskData
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

function TaskCell:OnHide()
	return
end

function TaskCell:OnDestroy()
	for i, v in pairs(self.cellDoing.itemCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.cellReward.itemCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.cellOver.itemCellPool) do
		v:Dispose()
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.ClearOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.ClearOutlet(self.goCellOver, self.cellOver)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TaskCell:AddListener()
	self.cellDoing.btnJump.onClick:AddListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:AddListener(self.cellReward.onClickBtnGetDelegate)
end

function TaskCell:RemoveListener()
	self.cellDoing.btnJump.onClick:RemoveListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:RemoveListener(self.cellReward.onClickBtnGetDelegate)
end

function TaskCell:OnClickBtnJump()
	JumpModule.Jump(self.cfgTaskData.Source)
end

function TaskCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
end

function TaskCell:RefreshState(state)
	self.goCellDoing:SetActive(state == 1)
	self.goCellReward:SetActive(state == 2)
	self.goCellOver:SetActive(state == 3)

	if state == 1 then
		self:RefreshTemplate(self.cellDoing, state)
	elseif state == 2 then
		self:RefreshTemplate(self.cellReward, state)
	elseif state == 3 then
		self:RefreshTemplate(self.cellOver, state)
	end
end

function TaskCell:RefreshTemplate(template, state)
	template.tfTargetDesc.text = ActiveWeekendUIApi:GetString("growUpViewTargetDesc", self.cfgTaskData.Description, self.taskData.CurrentNum, self.taskData.TargetNum)
	template.tfProgress.text = ActiveWeekendUIApi:GetString("growUpViewProgressDesc", self.taskData.CurrentNum, self.taskData.TargetNum)

	if state == 1 then
		self.cellDoing.goBtnJump:SetActive(self.cfgTaskData.Source ~= 0)
	end

	local rewardDatum = {}

	for i, v in ipairs(self.cfgTaskData.Reward) do
		if i % 2 ~= 0 and v ~= 1101 and v ~= 1102 then
			rewardDatum[#rewardDatum + 1] = {
				v,
				self.cfgTaskData.Reward[i + 1]
			}
		end
	end

	for i, v in ipairs(template.itemCellPool) do
		v.ViewGo:SetActive(i <= #rewardDatum)
	end

	for i, v in ipairs(rewardDatum) do
		local itemCell = template.itemCellPool[i]

		if itemCell == nil then
			local go = UnityEngine.Object.Instantiate(template.goItemCell)

			go.transform:SetParent(template.goItemCell.transform.parent, false)

			itemCell = ItemCell.PackageOrReuseView(self, go, true, true)
			template.itemCellPool[i] = itemCell
		end

		itemCell:SetItemByCID(v[1], v[2])
		itemCell:SetGray(self.state == 3)
	end
end

return TaskCell
