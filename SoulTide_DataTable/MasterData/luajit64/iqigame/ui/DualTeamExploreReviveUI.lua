-- chunkname: @IQIGame\\UI\\DualTeamExploreReviveUI.lua

require("IQIGame.UIExternalApi.DualTeamExploreReviveUIApi")

local DualTeamExploreReviveUI = {}

DualTeamExploreReviveUI = Base:Extend("DualTeamExploreReviveUI", "IQIGame.Onigao.UI.DualTeamExploreReviveUI", DualTeamExploreReviveUI)

function DualTeamExploreReviveUI:OnInit()
	function self.DelegateOnClickGiveUpBtn()
		self:OnClickGiveUpBtn()
	end

	function self.DelegateOnClickReviveBtn()
		self:OnClickReviveBtn()
	end

	UGUIUtil.SetText(self.TitleText1, DualTeamExploreReviveUIApi:GetString("TitleText1"))
	UGUIUtil.SetText(self.TitleText2, DualTeamExploreReviveUIApi:GetString("TitleText2"))
	UGUIUtil.SetText(self.DescText, DualTeamExploreReviveUIApi:GetString("DescText"))
	UGUIUtil.SetText(self.SubDescText, DualTeamExploreReviveUIApi:GetString("SubDescText"))
	UGUIUtil.SetTextInChildren(self.GiveUpBtn, DualTeamExploreReviveUIApi:GetString("GiveUpBtnText"))
	UGUIUtil.SetTextInChildren(self.ReviveBtn, DualTeamExploreReviveUIApi:GetString("ReviveBtnText"))
	UGUIUtil.SetTextInChildren(self.DisabledReviveBtn, DualTeamExploreReviveUIApi:GetString("ReviveBtnText"))
end

function DualTeamExploreReviveUI:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreReviveUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreReviveUI:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreReviveUI:GetBGM(userData)
	return nil
end

function DualTeamExploreReviveUI:OnOpen(userData)
	self.OnGiveUpCallback = userData.onGiveUp
	self.OnReviveCallback = userData.onRevive

	self:UpdateView()
end

function DualTeamExploreReviveUI:OnClose(userData)
	return
end

function DualTeamExploreReviveUI:OnAddListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
	self.ReviveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReviveBtn)
end

function DualTeamExploreReviveUI:OnRemoveListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
	self.ReviveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReviveBtn)
end

function DualTeamExploreReviveUI:OnPause()
	return
end

function DualTeamExploreReviveUI:OnResume()
	return
end

function DualTeamExploreReviveUI:OnCover()
	return
end

function DualTeamExploreReviveUI:OnReveal()
	return
end

function DualTeamExploreReviveUI:OnRefocus(userData)
	return
end

function DualTeamExploreReviveUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreReviveUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreReviveUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreReviveUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreReviveUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function DualTeamExploreReviveUI:UpdateView()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]
	local reviveItemCid = cfgDualTeamExploreControlData.ReviveItem
	local reviveItemNum = WarehouseModule.GetItemNumByCfgID(reviveItemCid)

	self.DisabledReviveBtn:SetActive(reviveItemNum == 0)
	self.ReviveBtn:SetActive(reviveItemNum > 0)

	local cfgItemData = CfgItemTable[reviveItemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CurrencyIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.PriceNumText, DualTeamExploreReviveUIApi:GetString("ReviveItemText", reviveItemNum))
end

function DualTeamExploreReviveUI:OnClickGiveUpBtn()
	UIModule.CloseSelf(self)
	self.OnGiveUpCallback()
end

function DualTeamExploreReviveUI:OnClickReviveBtn()
	UIModule.CloseSelf(self)
	self.OnReviveCallback()
end

return DualTeamExploreReviveUI
