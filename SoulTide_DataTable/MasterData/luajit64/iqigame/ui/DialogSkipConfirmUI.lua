-- chunkname: @IQIGame\\UI\\DialogSkipConfirmUI.lua

local DialogSkipConfirmUI = Base:Extend("DialogSkipConfirmUI", "IQIGame.Onigao.UI.DialogSkipConfirmUI", {})

function DialogSkipConfirmUI:OnInit()
	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, DialogSkipConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, DialogSkipConfirmUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, DialogSkipConfirmUIApi:GetString("ConfirmBtnText"))
end

function DialogSkipConfirmUI:GetPreloadAssetPaths()
	return nil
end

function DialogSkipConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DialogSkipConfirmUI:IsManualShowOnOpen(userData)
	return false
end

function DialogSkipConfirmUI:GetBGM(userData)
	return nil
end

function DialogSkipConfirmUI:OnOpen(userData)
	self.OnConfirmCallback = userData.onConfirm

	self:UpdateView(userData.subTitle, userData.profile)
end

function DialogSkipConfirmUI:OnClose(userData)
	return
end

function DialogSkipConfirmUI:OnAddListeners()
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DialogSkipConfirmUI:OnRemoveListeners()
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DialogSkipConfirmUI:OnPause()
	return
end

function DialogSkipConfirmUI:OnResume()
	return
end

function DialogSkipConfirmUI:OnCover()
	return
end

function DialogSkipConfirmUI:OnReveal()
	return
end

function DialogSkipConfirmUI:OnRefocus(userData)
	return
end

function DialogSkipConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DialogSkipConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DialogSkipConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DialogSkipConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DialogSkipConfirmUI:OnDestroy()
	return
end

function DialogSkipConfirmUI:UpdateView(subTitle, profile)
	UGUIUtil.SetText(self.SubTitleText, subTitle)
	UGUIUtil.SetText(self.ProfileText, profile)
end

function DialogSkipConfirmUI:OnClickCancelBtn()
	UIModule.CloseSelf(self)
end

function DialogSkipConfirmUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
	self.OnConfirmCallback()

	self.OnConfirmCallback = nil
end

function DialogSkipConfirmUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DialogSkipConfirmUI
