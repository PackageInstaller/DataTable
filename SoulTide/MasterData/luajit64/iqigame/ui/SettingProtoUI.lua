-- chunkname: @IQIGame\\UI\\SettingProtoUI.lua

local SettingProtoUI = {}

SettingProtoUI = Base:Extend("SettingProtoUI", "IQIGame.Onigao.UI.SettingProtoUI", SettingProtoUI)

local SettingProtoView = require("IQIGame.UI.Setting.SettingProtoView")

function SettingProtoUI:OnInit()
	function self.delegateBtnClose()
		self:onBtnClose()
	end

	self.settingProtoView = SettingProtoView.New(self.SettingProto)
end

function SettingProtoUI:GetPreloadAssetPaths()
	return nil
end

function SettingProtoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SettingProtoUI:IsManualShowOnOpen(userData)
	return false
end

function SettingProtoUI:GetBGM(userData)
	return nil
end

function SettingProtoUI:OnOpen(userData)
	self.settingProtoView:OnMainUIOpen()
	self.settingProtoView:Open()
end

function SettingProtoUI:OnClose(userData)
	self.settingProtoView:OnMainUIClose()
end

function SettingProtoUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function SettingProtoUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function SettingProtoUI:OnPause()
	return
end

function SettingProtoUI:OnResume()
	return
end

function SettingProtoUI:OnCover()
	return
end

function SettingProtoUI:OnReveal()
	return
end

function SettingProtoUI:OnRefocus(userData)
	return
end

function SettingProtoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SettingProtoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SettingProtoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SettingProtoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SettingProtoUI:OnDestroy()
	return
end

function SettingProtoUI:onBtnClose()
	UIModule.Close(Constant.UIControllerName.SettingProtoUI)
end

return SettingProtoUI
