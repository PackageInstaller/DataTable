-- chunkname: @IQIGame\\UI\\RewardLevels\\RewardLevelsCell.lua

local m = {
	showRewardTab = {},
	rewardCellPool = {}
}
local RewardLevelsRewardCell = require("IQIGame.UI.RewardLevels.RewardLevelsRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnGetRewardLabel1, RewardLevelsUIApi:GetString("BtnGetRewardLabel1"))
	UGUIUtil.SetText(self.BtnGetRewardLabel2, RewardLevelsUIApi:GetString("BtnGetRewardLabel2"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnGetReward1()
		self:OnBtnGetReward1()
	end

	function self.delegateBtnGetReward2()
		self:OnBtnGetReward2()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnGetReward1:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward2)
end

function m:RemoveListener()
	self.BtnGetReward1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward2)
end

function m:SetData(data)
	self.cfgUpgradeBigBattleData = data
	self.showRewardTab = {}

	if self.cfgUpgradeBigBattleData then
		for i = 1, #self.cfgUpgradeBigBattleData.Reward, 2 do
			local tab = {}

			tab.ID = self.cfgUpgradeBigBattleData.Reward[i]
			tab.Num = self.cfgUpgradeBigBattleData.Reward[i + 1]

			table.insert(self.showRewardTab, tab)
		end

		UGUIUtil.SetText(self.TextNeedLv, self.cfgUpgradeBigBattleData.Condition)
		self.scrollList:Refresh(#self.showRewardTab)

		local canGetReward = PlayerModule.PlayerInfo.baseInfo.pLv >= self.cfgUpgradeBigBattleData.TargetLevel

		self.Bg1:SetActive(canGetReward)
		self.Bg2:SetActive(not canGetReward)
		self.BtnGetReward1:SetActive(canGetReward)
		self.BtnGetReward2:SetActive(not canGetReward)
	end
end

function m:OnRenderGridCell(cell)
	local data = self.showRewardTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = RewardLevelsRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:OnBtnGetReward1()
	net_active.getLvReachReward(self.cfgUpgradeBigBattleData.Id)
end

function m:OnBtnGetReward2()
	return
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
