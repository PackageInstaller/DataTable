-- chunkname: @IQIGame\\UI\\SoulEvolutionInfoUI.lua

local SoulFeatureTipController = require("IQIGame.UI.Soul.SoulFeatureTipController")
local SoulEvolutionInfoUI = Base:Extend("SoulEvolutionInfoUI", "IQIGame.Onigao.UI.SoulEvolutionInfoUI", {})

function SoulEvolutionInfoUI:OnInit()
	self:Initialize()
end

function SoulEvolutionInfoUI:GetPreloadAssetPaths()
	return nil
end

function SoulEvolutionInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulEvolutionInfoUI:IsManualShowOnOpen(userData)
	return false
end

function SoulEvolutionInfoUI:GetBGM(userData)
	return nil
end

function SoulEvolutionInfoUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulEvolutionInfoUI:OnClose(userData)
	self:OnHide()
end

function SoulEvolutionInfoUI:OnPause()
	return
end

function SoulEvolutionInfoUI:OnResume()
	return
end

function SoulEvolutionInfoUI:OnCover()
	return
end

function SoulEvolutionInfoUI:OnReveal()
	return
end

function SoulEvolutionInfoUI:OnRefocus(userData)
	return
end

function SoulEvolutionInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulEvolutionInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulEvolutionInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulEvolutionInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulEvolutionInfoUI:Initialize()
	self.linkTipCell = LinkTipCell.New(self.goLinkCell)
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.SoulFeatureTipController = SoulFeatureTipController.New(self.ContentView)
	self.TipText:GetComponent("Text").text = SoulUIApi:GetString("infoViewFeatureTipTitle2")
end

function SoulEvolutionInfoUI:Refresh(userData)
	self.soulData = userData

	self.SoulFeatureTipController:SetData(self.soulData)
	self.linkTipCell:Open(self.SoulFeatureTipController.SourceTxt)
end

function SoulEvolutionInfoUI:OnHide()
	return
end

function SoulEvolutionInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.SoulFeatureTipController:Dispose()
	self.linkTipCell:OnDestroy()

	self.btnClose = nil
end

function SoulEvolutionInfoUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SoulEvolutionInfoUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SoulEvolutionInfoUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return SoulEvolutionInfoUI
