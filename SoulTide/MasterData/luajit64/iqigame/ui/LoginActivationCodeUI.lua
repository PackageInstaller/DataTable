-- chunkname: @IQIGame\\UI\\LoginActivationCodeUI.lua

local LoginActivationCodeUI = Base:Extend("LoginActivationCodeUI", "IQIGame.Onigao.UI.LoginActivationCodeUI", {})

function LoginActivationCodeUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	UGUIUtil.SetText(self.TitleText, LoginActivationCodeUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, LoginActivationCodeUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, LoginActivationCodeUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, LoginActivationCodeUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetText(self.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").placeholder.gameObject, LoginActivationCodeUIApi:GetString("InputPlaceHolderText"))
end

function LoginActivationCodeUI:GetPreloadAssetPaths()
	return nil
end

function LoginActivationCodeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LoginActivationCodeUI:OnOpen(userData)
	self.UID = userData.uid
end

function LoginActivationCodeUI:OnClose(userData)
	return
end

function LoginActivationCodeUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
end

function LoginActivationCodeUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
end

function LoginActivationCodeUI:OnPause()
	return
end

function LoginActivationCodeUI:OnResume()
	return
end

function LoginActivationCodeUI:OnCover()
	return
end

function LoginActivationCodeUI:OnReveal()
	return
end

function LoginActivationCodeUI:OnRefocus(userData)
	return
end

function LoginActivationCodeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LoginActivationCodeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoginActivationCodeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoginActivationCodeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoginActivationCodeUI:OnDestroy()
	return
end

function LoginActivationCodeUI:OnClickConfirmBtn()
	UIModule.Close(Constant.UIControllerName.LoginActivationCodeUI)
	LoginModule.ActiveAccount(self.UID, self.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").text)
end

function LoginActivationCodeUI:OnClickCancelBtn()
	UIModule.Close(Constant.UIControllerName.LoginActivationCodeUI)
end

return LoginActivationCodeUI
