-- chunkname: @IQIGame\\UI\\ShieldTipsUI.lua

local ShieldTipsUI = Base:Extend("ShieldTipsUI", "IQIGame.Onigao.UI.ShieldTipsUI", {})

function ShieldTipsUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function ShieldTipsUI:GetPreloadAssetPaths()
	return nil
end

function ShieldTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ShieldTipsUI:IsManualShowOnOpen(userData)
	return false
end

function ShieldTipsUI:GetBGM(userData)
	return nil
end

function ShieldTipsUI:OnOpen(userData)
	self.elementType = userData[1]
	self.refTrans = userData[2]

	self:UpdateView()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), self.refTrans, self.Content.transform, nil, UGUISide.Top, UGUISide.BottomLeft)
end

function ShieldTipsUI:OnClose(userData)
	return
end

function ShieldTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function ShieldTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function ShieldTipsUI:OnPause()
	return
end

function ShieldTipsUI:OnResume()
	return
end

function ShieldTipsUI:OnCover()
	return
end

function ShieldTipsUI:OnReveal()
	return
end

function ShieldTipsUI:OnRefocus(userData)
	return
end

function ShieldTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ShieldTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShieldTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShieldTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShieldTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function ShieldTipsUI:UpdateView()
	UGUIUtil.SetText(self.TextDes, MazeDetailUIApi:GetString("ElementTextDes", self.elementType))
	AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", self.elementType, true), self.ImgIcon:GetComponent("Image"))
end

function ShieldTipsUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ShieldTipsUI)
end

return ShieldTipsUI
