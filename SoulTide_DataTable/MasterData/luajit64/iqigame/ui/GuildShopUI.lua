-- chunkname: @IQIGame\\UI\\GuildShopUI.lua

local GuildShopUI = {}

GuildShopUI = Base:Extend("GuildShopUI", "IQIGame.Onigao.UI.GuildShopUI", GuildShopUI)

function GuildShopUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end
end

function GuildShopUI:GetPreloadAssetPaths()
	return nil
end

function GuildShopUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildShopUI:IsManualShowOnOpen(userData)
	return false
end

function GuildShopUI:GetBGM(userData)
	return nil
end

function GuildShopUI:OnOpen(userData)
	return
end

function GuildShopUI:OnClose(userData)
	return
end

function GuildShopUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function GuildShopUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function GuildShopUI:OnPause()
	return
end

function GuildShopUI:OnResume()
	return
end

function GuildShopUI:OnCover()
	return
end

function GuildShopUI:OnReveal()
	return
end

function GuildShopUI:OnRefocus(userData)
	return
end

function GuildShopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildShopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildShopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildShopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildShopUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GuildShopUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return GuildShopUI
