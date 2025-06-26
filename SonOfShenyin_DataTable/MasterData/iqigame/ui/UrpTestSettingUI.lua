-- chunkname: @IQIGame\\UI\\UrpTestSettingUI.lua

local UrpTestSettingUI = {}

UrpTestSettingUI = Base:Extend("UrpTestSettingUI", "IQIGame.Onigao.UI.UrpTestSettingUI", UrpTestSettingUI)

function UrpTestSettingUI:OnInit()
	function self.Delegation_OpenSettingBtnOnClick()
		self:OpenSettingBtnOnClick()
	end

	function self.Delegation_CloseBtnOnClick()
		self:CloseBtnOnClick()
	end

	self.OpenSettingButton = self.OpenSettingBtn:GetComponent("Button")

	self.OpenSettingButton.onClick:AddListener(self.Delegation_OpenSettingBtnOnClick)

	self.CloseButton = self.CloseBtn:GetComponent("Button")

	self.CloseButton.onClick:AddListener(self.Delegation_CloseBtnOnClick)
end

function UrpTestSettingUI:OpenSettingBtnOnClick()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI, true)
end

function UrpTestSettingUI:CloseBtnOnClick()
	GameEntry.LuaEvent:FireNow(nil, ChangeSceneEventArgs():Fill(SceneID.MainCity))
end

function UrpTestSettingUI:GetPreloadAssetPaths()
	return nil
end

function UrpTestSettingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UrpTestSettingUI:IsManualShowOnOpen(userData)
	return false
end

function UrpTestSettingUI:GetBGM(userData)
	return nil
end

function UrpTestSettingUI:OnOpen(userData)
	return
end

function UrpTestSettingUI:OnClose(userData)
	return
end

function UrpTestSettingUI:OnAddListeners()
	return
end

function UrpTestSettingUI:OnRemoveListeners()
	return
end

function UrpTestSettingUI:OnPause()
	return
end

function UrpTestSettingUI:OnResume()
	return
end

function UrpTestSettingUI:OnCover()
	return
end

function UrpTestSettingUI:OnReveal()
	return
end

function UrpTestSettingUI:OnRefocus(userData)
	return
end

function UrpTestSettingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UrpTestSettingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UrpTestSettingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UrpTestSettingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UrpTestSettingUI:OnDestroy()
	return
end

return UrpTestSettingUI
