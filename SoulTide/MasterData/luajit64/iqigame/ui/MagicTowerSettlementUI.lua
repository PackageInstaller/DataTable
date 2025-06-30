-- chunkname: @IQIGame\\UI\\MagicTowerSettlementUI.lua

local MagicTowerSettlementUI = {}

MagicTowerSettlementUI = Base:Extend("MagicTowerSettlementUI", "IQIGame.Onigao.UI.MagicTowerSettlementUI", MagicTowerSettlementUI)

function MagicTowerSettlementUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function MagicTowerSettlementUI:GetPreloadAssetPaths()
	return nil
end

function MagicTowerSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MagicTowerSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function MagicTowerSettlementUI:GetBGM(userData)
	return nil
end

function MagicTowerSettlementUI:OnOpen(userData)
	self:UpdateView(userData.isSuccess)
end

function MagicTowerSettlementUI:OnClose(userData)
	return
end

function MagicTowerSettlementUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MagicTowerSettlementUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MagicTowerSettlementUI:OnPause()
	return
end

function MagicTowerSettlementUI:OnResume()
	return
end

function MagicTowerSettlementUI:OnCover()
	return
end

function MagicTowerSettlementUI:OnReveal()
	return
end

function MagicTowerSettlementUI:OnRefocus(userData)
	return
end

function MagicTowerSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MagicTowerSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MagicTowerSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MagicTowerSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MagicTowerSettlementUI:OnDestroy()
	return
end

function MagicTowerSettlementUI:UpdateView(isSuccess)
	self.SuccessView:SetActive(isSuccess)
	self.FailView:SetActive(not isSuccess)
end

function MagicTowerSettlementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MagicTowerModule.ExitScene()
end

return MagicTowerSettlementUI
