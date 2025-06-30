-- chunkname: @IQIGame\\UI\\GirlContractConfirmationUI.lua

local GirlContractConfirmationUI = Base:Extend("GirlContractConfirmationUI", "IQIGame.Onigao.UI.GirlContractConfirmationUI", {})

function GirlContractConfirmationUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnConclusion()
		self:OnBtnConclusion()
	end
end

function GirlContractConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function GirlContractConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlContractConfirmationUI:OnOpen(userData)
	self.parent = userData
	self.soulData = userData.soulData
end

function GirlContractConfirmationUI:OnClose(userData)
	return
end

function GirlContractConfirmationUI:OnAddListeners()
	self.BtnConclusion:GetComponent("Button").onClick:AddListener(self.delegateBtnConclusion)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function GirlContractConfirmationUI:OnRemoveListeners()
	self.BtnConclusion:GetComponent("Button").onClick:RemoveListener(self.delegateBtnConclusion)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function GirlContractConfirmationUI:OnPause()
	return
end

function GirlContractConfirmationUI:OnResume()
	return
end

function GirlContractConfirmationUI:OnCover()
	return
end

function GirlContractConfirmationUI:OnReveal()
	return
end

function GirlContractConfirmationUI:OnRefocus(userData)
	return
end

function GirlContractConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlContractConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlContractConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlContractConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlContractConfirmationUI:OnDestroy()
	return
end

function GirlContractConfirmationUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.GirlContractConfirmationUI)
end

function GirlContractConfirmationUI:OnBtnConclusion()
	UIModule.Close(Constant.UIControllerName.GirlContractConfirmationUI)
	self.parent:PlayCloseEffect()
end

return GirlContractConfirmationUI
