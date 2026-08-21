-- chunkname: @IQIGame\\UI\\TypeTipsUI.lua

local TypeTipsUI = Base:Extend("TypeTipsUI", "IQIGame.Onigao.UI.TypeTipsUI", {})

function TypeTipsUI:OnInit()
	self:Initialize()
end

function TypeTipsUI:GetPreloadAssetPaths()
	return nil
end

function TypeTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TypeTipsUI:OnOpen(userData)
	self:Refresh(userData)
end

function TypeTipsUI:OnClose(userData)
	self:Dispose()
end

function TypeTipsUI:OnAddListeners()
	return
end

function TypeTipsUI:OnRemoveListeners()
	return
end

function TypeTipsUI:OnPause()
	return
end

function TypeTipsUI:OnResume()
	return
end

function TypeTipsUI:OnCover()
	return
end

function TypeTipsUI:OnReveal()
	return
end

function TypeTipsUI:OnRefocus(userData)
	return
end

function TypeTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TypeTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TypeTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TypeTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TypeTipsUI:Initialize()
	self.tfName = self.goName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.imgIcon = self.goIcon:GetComponent("Image")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end
end

function TypeTipsUI:Refresh(userData)
	local tipType = userData[1]
	local type = userData[2]
	local name, path, desc

	if tipType == Constant.TypeTipsType.CLASS then
		name = MiscApi:GetString("SoulClass", type)
		path = MiscApi:GetString("SoulClassIconForTip", type)
		desc = MiscApi:GetString("SoulClassDesc", type)
	elseif tipType == Constant.TypeTipsType.DAMAGE then
		name = MiscApi:GetString("SoulDamageType", type)
		path = MiscApi:GetString("SoulDamageTypeIconForTip", type)
		desc = MiscApi:GetString("SoulDamageDesc", type)
	elseif tipType == Constant.TypeTipsType.POWER_SOURCE then
		path = MiscApi:GetString("SoulPowerSourceIconForTip", type)
		desc = MiscApi:GetString("SoulPowerSourceDesc", type)
	elseif tipType == Constant.TypeTipsType.MONSTER then
		name = MiscApi:GetString("PositionType", type)
		path = MiscApi:GetString("MonsterIconForTip", type)
		desc = MiscApi:GetString("MonsterDesc", type)
	end

	self.tfName.text = name
	self.tfDesc.text = desc

	AssetUtil.LoadImage(self, path, self.imgIcon)
end

function TypeTipsUI:Dispose()
	return
end

function TypeTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function TypeTipsUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function TypeTipsUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function TypeTipsUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.TypeTipsUI)
end

return TypeTipsUI
