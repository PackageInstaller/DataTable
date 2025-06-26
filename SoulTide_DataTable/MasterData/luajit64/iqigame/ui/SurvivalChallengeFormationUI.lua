-- chunkname: @IQIGame\\UI\\SurvivalChallengeFormationUI.lua

local SurvivalChallengeFormationUI = {
	openType = 1,
	gamePlayerCells = {}
}

SurvivalChallengeFormationUI = Base:Extend("SurvivalChallengeFormationUI", "IQIGame.Onigao.UI.SurvivalChallengeFormationUI", SurvivalChallengeFormationUI)

require("IQIGame.UIExternalApi.SurvivalChallengeFormationUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SurvivalPlayerCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeFormation.SurvivalPlayerCell")

function SurvivalChallengeFormationUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateFlyRankBtn()
		self:OnFlyRankBtn()
	end

	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	self.gamePlayerModule:SetActive(false)

	self.gamePlayerCellPool = UIObjectPool.New(3, function()
		return SurvivalPlayerCell.New(UnityEngine.Object.Instantiate(self.gamePlayerModule))
	end, function(cell)
		cell:Dispose()
	end)
end

function SurvivalChallengeFormationUI:GetPreloadAssetPaths()
	return nil
end

function SurvivalChallengeFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SurvivalChallengeFormationUI:IsManualShowOnOpen(userData)
	return false
end

function SurvivalChallengeFormationUI:GetBGM(userData)
	return nil
end

function SurvivalChallengeFormationUI:OnOpen(userData)
	self.openType = userData.Type
	self.levelCid = userData.LevelCid

	self:UpdateView()
end

function SurvivalChallengeFormationUI:OnClose(userData)
	return
end

function SurvivalChallengeFormationUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	self.flyRankBtn:GetComponent("Button").onClick:AddListener(self.DelegateFlyRankBtn)
end

function SurvivalChallengeFormationUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	self.flyRankBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFlyRankBtn)
end

function SurvivalChallengeFormationUI:OnPause()
	return
end

function SurvivalChallengeFormationUI:OnResume()
	return
end

function SurvivalChallengeFormationUI:OnCover()
	return
end

function SurvivalChallengeFormationUI:OnReveal()
	return
end

function SurvivalChallengeFormationUI:OnRefocus(userData)
	return
end

function SurvivalChallengeFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalChallengeFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalChallengeFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SurvivalChallengeFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalChallengeFormationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.energyCell:Dispose()

	for i, v in pairs(self.gamePlayerCells) do
		self.gamePlayerCellPool:Release(v)
	end

	self.gamePlayerCells = {}

	self.gamePlayerCellPool:Dispose()
end

function SurvivalChallengeFormationUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function SurvivalChallengeFormationUI:UpdateView()
	self.flyRankBtn:SetActive(self.openType == FlyGameConstant.ChallengeType.Challenge_Endless_Mode)

	for i, v in pairs(self.gamePlayerCells) do
		self.gamePlayerCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.gamePlayerCells = {}

	for i, v in pairs(SurvivalModule.survivalPlayer) do
		local playerCell = self.gamePlayerCellPool:Obtain()

		playerCell.View:SetActive(true)
		playerCell.View.transform:SetParent(self.gamePlayerList.transform, false)
		playerCell:SetData(v, self.openType, self.levelCid)
		table.insert(self.gamePlayerCells, playerCell)
	end
end

function SurvivalChallengeFormationUI:OnFlyRankBtn()
	UIModule.Open(Constant.UIControllerName.SurvivalChallengeFlyRankUI, Constant.UILayer.UI)
end

return SurvivalChallengeFormationUI
