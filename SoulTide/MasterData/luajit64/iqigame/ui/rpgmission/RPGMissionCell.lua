-- chunkname: @IQIGame\\UI\\RPGMission\\RPGMissionCell.lua

local RpgMissionCell = {
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
local RPGItemCell = require("IQIGame.UI.RPGMission.RPGItemCell")

function RpgMissionCell.New(view)
	local obj = Clone(RpgMissionCell)

	obj:Init(view)

	return obj
end

function RpgMissionCell:Init(view)
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
	self.cellDoing.goSignNotOver.transform:Find("Text_01"):GetComponent("Text").text = RPGMissionUIApi:GetString("signNotOverTxt")
	self.cellReward.itemCellPool[1] = RPGItemCell.New(self.cellReward.goItemCell)
	self.cellReward.tfTargetDesc = self.cellReward.goTargetDesc:GetComponent("Text")
	self.cellReward.tfTargetNow = self.cellReward.goTargetNow:GetComponent("Text")
	self.cellReward.tfTargetTotal = self.cellReward.goTargetTotal:GetComponent("Text")
	self.cellReward.imgIcon = self.cellReward.goIcon:GetComponent("Image")
	self.cellReward.btnGet = self.cellReward.goBtnGet:GetComponent("Button")

	function self.cellReward.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	self.cellReward.goBtnGet.transform:Find("Text"):GetComponent("Text").text = RPGMissionUIApi:GetString("goBtnGetTxt")
	self.cellOver.itemCellPool[1] = RPGItemCell.New(self.cellOver.goItemCell)
	self.cellOver.tfTargetDesc = self.cellOver.goTargetDesc:GetComponent("Text")
	self.cellOver.tfTargetNow = self.cellOver.goTargetNow:GetComponent("Text")
	self.cellOver.tfTargetTotal = self.cellOver.goTargetTotal:GetComponent("Text")
	self.cellOver.imgIcon = self.cellOver.goIcon:GetComponent("Image")

	self:AddListener()
end

function RpgMissionCell:Refresh(taskData)
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

function RpgMissionCell:OnHide()
	return
end

function RpgMissionCell:OnDestroy()
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

function RpgMissionCell:AddListener()
	self.cellReward.btnGet.onClick:AddListener(self.cellReward.onClickBtnGetDelegate)
end

function RpgMissionCell:RemoveListener()
	self.cellReward.btnGet.onClick:RemoveListener(self.cellReward.onClickBtnGetDelegate)
end

function RpgMissionCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
end

function RpgMissionCell:RefreshState(state)
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

function RpgMissionCell:RefreshTemplate(template, state)
	template.tfTargetDesc.text = RPGMissionUIApi:GetString("activeViewTargetDesc", self.cfgTaskData.Description, self.taskData.CurrentNum, self.taskData.TargetNum)
	template.tfTargetNow.text = RPGMissionUIApi:GetString("progressNow", self.taskData.CurrentNum)
	template.tfTargetTotal.text = RPGMissionUIApi:GetString("progressTotal", self.taskData.TargetNum)

	local existFlag = self.cfgTaskData.Flag ~= nil and self.cfgTaskData.Flag ~= ""

	if existFlag then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgTaskData.Flag), template.imgIcon)
	end

	template.imgIcon.transform.parent.gameObject:SetActive(existFlag)

	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]
	local rewardDatum = {}

	for i, v in ipairs(self.cfgTaskData.Reward) do
		if i % 2 ~= 0 and v == cfgRPGMazeControlData.ScoreItem then
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

return RpgMissionCell
