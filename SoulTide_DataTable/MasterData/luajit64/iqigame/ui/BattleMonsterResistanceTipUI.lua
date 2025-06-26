-- chunkname: @IQIGame\\UI\\BattleMonsterResistanceTipUI.lua

local BattleMonsterResistanceTipUI = Base:Extend("BattleMonsterResistanceTipUI", "IQIGame.Onigao.UI.BattleMonsterResistanceTipUI", {})

function BattleMonsterResistanceTipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function BattleMonsterResistanceTipUI:GetPreloadAssetPaths()
	return nil
end

function BattleMonsterResistanceTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleMonsterResistanceTipUI:IsManualShowOnOpen(userData)
	return false
end

function BattleMonsterResistanceTipUI:GetBGM(userData)
	return nil
end

function BattleMonsterResistanceTipUI:OnOpen(userData)
	self:UpdateView(userData.buffCid, userData.customContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), userData.srcRefTrans, self.Content.transform, nil, UGUISide.Top, UGUISide.BottomLeft)
end

function BattleMonsterResistanceTipUI:OnClose(userData)
	return
end

function BattleMonsterResistanceTipUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function BattleMonsterResistanceTipUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function BattleMonsterResistanceTipUI:OnPause()
	return
end

function BattleMonsterResistanceTipUI:OnResume()
	return
end

function BattleMonsterResistanceTipUI:OnCover()
	return
end

function BattleMonsterResistanceTipUI:OnReveal()
	return
end

function BattleMonsterResistanceTipUI:OnRefocus(userData)
	return
end

function BattleMonsterResistanceTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleMonsterResistanceTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleMonsterResistanceTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleMonsterResistanceTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleMonsterResistanceTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function BattleMonsterResistanceTipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function BattleMonsterResistanceTipUI:UpdateView(buffCid, customContent)
	local iconPath, name, desc

	if customContent == nil then
		local cfgBuffData = CfgBuffTable[buffCid]

		iconPath = UIGlobalApi.GetIconPath(cfgBuffData.Icon)
		name = cfgBuffData.Name
		desc = cfgBuffData.Describe
	else
		iconPath = customContent.iconPath
		name = customContent.name
		desc = customContent.desc
	end

	AssetUtil.LoadImage(self, iconPath, self.BuffIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.BuffNameText, name)
	UGUIUtil.SetText(self.BuffDescText, desc)
end

return BattleMonsterResistanceTipUI
