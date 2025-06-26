-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGMission\\HorizontalRPGMissionCell.lua

local HorizontalRPGMissionCell = {
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

require("IQIGame.UIExternalApi.RPGMissionUIApi")

local RPGItemCell = require("IQIGame.UI.RPGMission.RPGItemCell")

function HorizontalRPGMissionCell.New(view)
	local obj = Clone(HorizontalRPGMissionCell)

	obj:Init(view)

	return obj
end

function HorizontalRPGMissionCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.BindOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.BindOutlet(self.goCellOver, self.cellOver)

	self.cellDoing.itemCellPool[1] = RPGItemCell.New(self.cellDoing.goItemCell)
	self.cellDoing.tfTargetDesc = self.cellDoing.goTargetDesc:GetComponent("Text")
	self.cellDoing.tfTargetNow = self.cellDoing.goTargetNow:GetComponent("Text")
	self.cellDoing.tfTargetTotal = self.cellDoing.goTargetTotal:GetComponent("Text")
	self.cellDoing.imgIcon = self.cellDoing.goIcon:GetComponent("Image")

	UGUIUtil.SetTextInChildren(self.cellDoing.goSignNotOver, HorizontalRPGMissionUIApi:GetString("signNotOverTxt"))

	self.cellReward.itemCellPool[1] = RPGItemCell.New(self.cellReward.goItemCell)
	self.cellReward.tfTargetDesc = self.cellReward.goTargetDesc:GetComponent("Text")
	self.cellReward.tfTargetNow = self.cellReward.goTargetNow:GetComponent("Text")
	self.cellReward.tfTargetTotal = self.cellReward.goTargetTotal:GetComponent("Text")
	self.cellReward.imgIcon = self.cellReward.goIcon:GetComponent("Image")
	self.cellReward.btnGet = self.cellReward.goBtnGet:GetComponent("Button")

	function self.cellReward.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	UGUIUtil.SetTextInChildren(self.cellReward.goBtnGet, HorizontalRPGMissionUIApi:GetString("goBtnGetTxt"))

	self.cellOver.itemCellPool[1] = RPGItemCell.New(self.cellOver.goItemCell)
	self.cellOver.tfTargetDesc = self.cellOver.goTargetDesc:GetComponent("Text")
	self.cellOver.tfTargetNow = self.cellOver.goTargetNow:GetComponent("Text")
	self.cellOver.tfTargetTotal = self.cellOver.goTargetTotal:GetComponent("Text")
	self.cellOver.imgIcon = self.cellOver.goIcon:GetComponent("Image")

	self:AddListener()
end

function HorizontalRPGMissionCell:Refresh(taskData)
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

function HorizontalRPGMissionCell:OnHide()
	return
end

function HorizontalRPGMissionCell:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.cellDoing.itemCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.cellReward.itemCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.cellOver.itemCellPool) do
		v:OnDestroy()
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goCellDoing, self.cellDoing)
	LuaCodeInterface.ClearOutlet(self.goCellReward, self.cellReward)
	LuaCodeInterface.ClearOutlet(self.goCellOver, self.cellOver)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function HorizontalRPGMissionCell:AddListener()
	self.cellReward.btnGet.onClick:AddListener(self.cellReward.onClickBtnGetDelegate)
end

function HorizontalRPGMissionCell:RemoveListener()
	self.cellReward.btnGet.onClick:RemoveListener(self.cellReward.onClickBtnGetDelegate)
end

function HorizontalRPGMissionCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
end

function HorizontalRPGMissionCell:RefreshState(state)
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

function HorizontalRPGMissionCell:RefreshTemplate(template, state)
	template.tfTargetDesc.text = HorizontalRPGMissionUIApi:GetString("activeViewTargetDesc", self.cfgTaskData.Description, self.taskData.CurrentNum, self.taskData.TargetNum)
	template.tfTargetNow.text = HorizontalRPGMissionUIApi:GetString("progressNow", self.taskData.CurrentNum)
	template.tfTargetTotal.text = HorizontalRPGMissionUIApi:GetString("progressTotal", self.taskData.TargetNum)

	local existFlag = self.cfgTaskData.Flag ~= nil and self.cfgTaskData.Flag ~= ""

	if existFlag then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgTaskData.Flag), template.imgIcon)
	end

	template.imgIcon.transform.parent.gameObject:SetActive(existFlag)

	local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	if cfgRPGMazeControlData.MallMoneyId then
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
				local go = UnityEngine.Object.Instantiate(template.goItemCell)

				go.transform:SetParent(template.goItemCell.transform.parent, false)

				itemCell = RPGItemCell.New(go)
				template.itemCellPool[i] = itemCell
			end

			itemCell:Refresh(v[1], v[2], state)
		end
	end
end

return HorizontalRPGMissionCell
