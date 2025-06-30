-- chunkname: @IQIGame\\UI\\Mission\\WeekActiveTask\\WeekActiveTaskCell.lua

local WeekActiveTaskCell = {
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

function WeekActiveTaskCell.New(view)
	local obj = Clone(WeekActiveTaskCell)

	obj:Init(view)

	return obj
end

function WeekActiveTaskCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.BindOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.BindOutlet(self.goCellOver, self.cellOver)

	self.cellDoing.itemCellPool[1] = self.cellDoing.goItemCell
	self.cellDoing.tfTargetDesc = self.cellDoing.goTargetDesc:GetComponent("Text")
	self.cellDoing.btnJump = self.cellDoing.goBtnJump:GetComponent("Button")

	function self.cellDoing.onClickBtnJumpDelegate()
		self:OnClickBtnJump()
	end

	self.cellDoing.goBtnJump.transform:Find("Text"):GetComponent("Text").text = MissionUIApi:GetString("goBtnJumpTxt")
	self.cellReward.itemCellPool[1] = self.cellReward.goItemCell
	self.cellReward.tfTargetDesc = self.cellReward.goTargetDesc:GetComponent("Text")
	self.cellReward.btnGet = self.cellReward.goBtnGet:GetComponent("Button")

	function self.cellReward.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	self.cellReward.goBtnGet.transform:Find("Text"):GetComponent("Text").text = MissionUIApi:GetString("goBtnGetTxt")
	self.cellOver.itemCellPool[1] = self.cellOver.goItemCell
	self.cellOver.tfTargetDesc = self.cellOver.goTargetDesc:GetComponent("Text")
	self.cellOver.goSign:GetComponent("Text").text = MissionUIApi:GetString("goFinishedTaskSign")

	self:AddListener()
end

function WeekActiveTaskCell:Refresh(taskData)
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

function WeekActiveTaskCell:OnHide()
	return
end

function WeekActiveTaskCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.ClearOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.ClearOutlet(self.goCellOver, self.cellOver)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function WeekActiveTaskCell:AddListener()
	self.cellDoing.btnJump.onClick:AddListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:AddListener(self.cellReward.onClickBtnGetDelegate)
end

function WeekActiveTaskCell:RemoveListener()
	self.cellDoing.btnJump.onClick:RemoveListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:RemoveListener(self.cellReward.onClickBtnGetDelegate)
end

function WeekActiveTaskCell:OnClickBtnJump()
	JumpModule.Jump(self.cfgTaskData.Source)
end

function WeekActiveTaskCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
end

function WeekActiveTaskCell:RefreshState(state)
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

function WeekActiveTaskCell:RefreshTemplate(template, state)
	template.tfTargetDesc.text = MissionUIApi:GetString("activeViewTargetDesc", self.cfgTaskData.Description, self.taskData.CurrentNum, self.taskData.TargetNum)

	if state == 1 then
		self.cellDoing.goBtnJump:SetActive(self.cfgTaskData.Source ~= 0)
	end

	local rewardDatum = {}

	for i, v in ipairs(self.cfgTaskData.Reward) do
		if i % 2 ~= 0 then
			rewardDatum[#rewardDatum + 1] = {
				v,
				self.cfgTaskData.Reward[i + 1]
			}
		end
	end

	for i, v in ipairs(template.itemCellPool) do
		v:SetActive(i <= #rewardDatum)
	end

	for i, v in ipairs(rewardDatum) do
		local itemCell = template.itemCellPool[i]

		if itemCell == nil then
			itemCell = UnityEngine.Object.Instantiate(template.goItemCell)

			itemCell.transform:SetParent(template.goItemCell.transform.parent, false)

			template.itemCellPool[i] = itemCell
		end

		local imgIcon = itemCell.transform:Find("Image"):GetComponent("Image")
		local tfNum = itemCell.transform:Find("Text_01"):GetComponent("Text")

		tfNum.text = MissionUIApi:GetString("activeViewRewardCount", v[2])

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[v[1]].Icon), imgIcon)
	end
end

return WeekActiveTaskCell
