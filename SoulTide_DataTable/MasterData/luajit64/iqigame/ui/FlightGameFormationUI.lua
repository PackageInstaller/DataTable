-- chunkname: @IQIGame\\UI\\FlightGameFormationUI.lua

local FlightGameFormationUI = {
	gamePlayerCells = {}
}

FlightGameFormationUI = Base:Extend("FlightGameFormationUI", "IQIGame.Onigao.UI.FlightGameFormationUI", FlightGameFormationUI)

require("IQIGame.UIExternalApi.FlightGameFormationUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FlightGamePlayerCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameFormation.FlightGamePlayerCell")

function FlightGameFormationUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateFlyRankBtn()
		self:OnFlyRankBtn()
	end

	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	self.gamePlayerModule:SetActive(false)

	self.gamePlayerCellPool = UIObjectPool.New(3, function()
		return FlightGamePlayerCell.New(UnityEngine.Object.Instantiate(self.gamePlayerModule))
	end, function(cell)
		cell:Dispose()
	end)
end

function FlightGameFormationUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameFormationUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameFormationUI:GetBGM(userData)
	return nil
end

function FlightGameFormationUI:OnOpen(userData)
	self:UpdateView()
end

function FlightGameFormationUI:OnClose(userData)
	return
end

function FlightGameFormationUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	self.flyRankBtn:GetComponent("Button").onClick:AddListener(self.DelegateFlyRankBtn)
end

function FlightGameFormationUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	self.flyRankBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFlyRankBtn)
end

function FlightGameFormationUI:OnPause()
	return
end

function FlightGameFormationUI:OnResume()
	return
end

function FlightGameFormationUI:OnCover()
	return
end

function FlightGameFormationUI:OnReveal()
	return
end

function FlightGameFormationUI:OnRefocus(userData)
	return
end

function FlightGameFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameFormationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.energyCell:Dispose()

	for i, v in pairs(self.gamePlayerCells) do
		self.gamePlayerCellPool:Release(v)
	end

	self.gamePlayerCells = {}

	self.gamePlayerCellPool:Dispose()
end

function FlightGameFormationUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function FlightGameFormationUI:UpdateView()
	for i, v in pairs(self.gamePlayerCells) do
		self.gamePlayerCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.gamePlayerCells = {}

	for i, v in pairs(FlightChallengeModule.flightGamePlayer) do
		local playerCell = self.gamePlayerCellPool:Obtain()

		playerCell.View:SetActive(true)
		playerCell.View.transform:SetParent(self.gamePlayerList.transform, false)
		playerCell:SetData(v)
		table.insert(self.gamePlayerCells, playerCell)
	end
end

function FlightGameFormationUI:OnFlyRankBtn()
	UIModule.Open(Constant.UIControllerName.FlightGameBossRankUI, Constant.UILayer.UI)
end

return FlightGameFormationUI
