-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalFlyGameSettlement\\SurvivalFlyGameSettlementPanelView.lua

local m = {
	bossNum = 0,
	monsterNum = 0,
	levelCid = 0,
	survivalSettlementTaskCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SurvivalFlyGameSettlementTaskCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalFlyGameSettlement.SurvivalFlyGameSettlementTaskCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.LevelTaskModule:SetActive(false)

	self.survivalSettlementTaskPool = UIObjectPool.New(5, function()
		return SurvivalFlyGameSettlementTaskCell.New(UnityEngine.Object.Instantiate(self.LevelTaskModule))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	UGUIUtil.SetText(self.TextMonsterNum, self.monsterNum)
	UGUIUtil.SetText(self.TextBossNum, self.bossNum)

	local survivalChallengeLevelData = SurvivalModule.GetSurvivalChallengeLevelDataByID(self.levelCid)
	local path = SurvivalFlyGameSettlementUIApi:GetString("ImageState", #survivalChallengeLevelData.levelStatusPod.award)

	AssetUtil.LoadImage(self, path, self.ImageState:GetComponent("Image"))

	for i, v in pairs(self.survivalSettlementTaskCells) do
		self.survivalSettlementTaskPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.survivalSettlementTaskCells = {}

	if survivalChallengeLevelData then
		for i = 1, #survivalChallengeLevelData:GetCfgData().Task do
			local taskStr = survivalChallengeLevelData:GetCfgData().Task[i]
			local isOpen = survivalChallengeLevelData:RewardIsComplete(i)
			local rewards = survivalChallengeLevelData:GetCfgData().Reward[i]
			local survivalFlyGameTaskCell = self.survivalSettlementTaskPool:Obtain()

			survivalFlyGameTaskCell.View:SetActive(true)
			survivalFlyGameTaskCell.View.transform:SetParent(self.LevelTaskNode.transform, false)
			survivalFlyGameTaskCell:SetData(taskStr, isOpen, rewards)
			table.insert(self.survivalSettlementTaskCells, survivalFlyGameTaskCell)
		end
	end
end

function m:SetData(levelCid, monsterNum, bossNum)
	self.levelCid = levelCid
	self.monsterNum = monsterNum
	self.bossNum = bossNum

	self:UpdateView()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.survivalSettlementTaskCells) do
		self.survivalSettlementTaskPool:Release(v)
	end

	self.survivalSettlementTaskCells = {}

	self.survivalSettlementTaskPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
