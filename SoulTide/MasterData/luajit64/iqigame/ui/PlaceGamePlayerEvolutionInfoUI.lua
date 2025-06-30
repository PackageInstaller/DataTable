-- chunkname: @IQIGame\\UI\\PlaceGamePlayerEvolutionInfoUI.lua

local PlaceGamePlayerEvolutionInfoUI = {}

PlaceGamePlayerEvolutionInfoUI = Base:Extend("PlaceGamePlayerEvolutionInfoUI", "IQIGame.Onigao.UI.PlaceGamePlayerEvolutionInfoUI", PlaceGamePlayerEvolutionInfoUI)

require("IQIGame.UIExternalApi.PlaceGamePlayerEvolutionInfoUIApi")

local placeGamePlayerFeatureTipView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerEvolutionInfo.placeGamePlayerFeatureTipView")

function PlaceGamePlayerEvolutionInfoUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.linkTipCell = LinkTipCell.New(self.goLinkCell)
	self.placeGamePlayerFeatureTip = placeGamePlayerFeatureTipView.New(self.ContentView)
end

function PlaceGamePlayerEvolutionInfoUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGamePlayerEvolutionInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGamePlayerEvolutionInfoUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGamePlayerEvolutionInfoUI:GetBGM(userData)
	return nil
end

function PlaceGamePlayerEvolutionInfoUI:OnOpen(userData)
	self.placeGameSoulData = userData.PlaceGameSoulData

	self:UpdateView()
end

function PlaceGamePlayerEvolutionInfoUI:OnClose(userData)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function PlaceGamePlayerEvolutionInfoUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function PlaceGamePlayerEvolutionInfoUI:OnPause()
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnResume()
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnCover()
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnReveal()
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnRefocus(userData)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGamePlayerEvolutionInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.linkTipCell:OnDestroy()
	self.placeGamePlayerFeatureTip:Dispose()
end

function PlaceGamePlayerEvolutionInfoUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGamePlayerEvolutionInfoUI:UpdateView()
	self.placeGamePlayerFeatureTip:SetData(self.placeGameSoulData)
	self.linkTipCell:Open(self.placeGamePlayerFeatureTip.SourceTxt)
end

return PlaceGamePlayerEvolutionInfoUI
