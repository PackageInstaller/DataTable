-- chunkname: @IQIGame\\UI\\Activity\\LimitedTurn\\LimitedTurnTaskItemCell.lua

local LimitedTurnTaskItemCell = {
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

function LimitedTurnTaskItemCell.New(view)
	local obj = Clone(LimitedTurnTaskItemCell)

	obj:Init(view)

	return obj
end

function LimitedTurnTaskItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.CellDoing, self.cellDoing)
	LuaCodeInterface.BindOutlet(self.CellReward, self.cellReward)
	LuaCodeInterface.BindOutlet(self.CellOver, self.cellOver)

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

function LimitedTurnTaskItemCell:Refresh(taskData)
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

function LimitedTurnTaskItemCell:OnHide()
	return
end

function LimitedTurnTaskItemCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.CellDoing, self.cellDoing)
	LuaCodeInterface.ClearOutlet(self.CellReward, self.cellReward)
	LuaCodeInterface.ClearOutlet(self.CellOver, self.cellOver)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function LimitedTurnTaskItemCell:AddListener()
	self.cellDoing.btnJump.onClick:AddListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:AddListener(self.cellReward.onClickBtnGetDelegate)
end

function LimitedTurnTaskItemCell:RemoveListener()
	self.cellDoing.btnJump.onClick:RemoveListener(self.cellDoing.onClickBtnJumpDelegate)
	self.cellReward.btnGet.onClick:RemoveListener(self.cellReward.onClickBtnGetDelegate)
end

function LimitedTurnTaskItemCell:OnClickBtnJump()
	JumpModule.Jump(self.cfgTaskData.Source)
end

function LimitedTurnTaskItemCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
end

function LimitedTurnTaskItemCell:RefreshState(state)
	self.CellDoing:SetActive(state == 1)
	self.CellReward:SetActive(state == 2)
	self.CellOver:SetActive(state == 3)

	if state == 1 then
		self:RefreshTemplate(self.cellDoing, state)
	elseif state == 2 then
		self:RefreshTemplate(self.cellReward, state)
	elseif state == 3 then
		self:RefreshTemplate(self.cellOver, state)
	end
end

function LimitedTurnTaskItemCell:RefreshTemplate(template, state)
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
		local itemCellObj = template.itemCellPool[i]

		if itemCellObj == nil then
			itemCellObj = UnityEngine.Object.Instantiate(template.goItemCell)

			itemCellObj.transform:SetParent(template.goItemCell.transform.parent, false)

			template.itemCellPool[i] = itemCellObj
		end

		local itemCell = ItemCell.New(itemCellObj)

		itemCell:SetItemByCID(v[1], v[2])
	end
end

return LimitedTurnTaskItemCell
