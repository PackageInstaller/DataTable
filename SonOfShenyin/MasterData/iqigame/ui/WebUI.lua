-- chunkname: @IQIGame\\UI\\WebUI.lua

local WebUI = Base:Extend("WebUI", "IQIGame.Onigao.UI.WebUI", {})

function WebUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnGoBack()
		self:OnClickWebOtherBtn(1)
	end

	function self.delegateBtnGoForward()
		self:OnClickWebOtherBtn(3)
	end

	function self.delegateBtnRefresh()
		self:OnClickWebOtherBtn(2)
	end
end

function WebUI:GetPreloadAssetPaths()
	return nil
end

function WebUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WebUI:IsManualShowOnOpen(userData)
	return false
end

function WebUI:GetBGM(userData)
	return nil
end

function WebUI:OnOpen(userData)
	if IQIGame.Onigao.Game.Device.isMobile then
		self.UniWebViewClone = UnityEngine.Object.Instantiate(self.UniWebView)

		self.UniWebViewClone.transform:SetParent(self.UniWebViewPanel.transform, false)

		self.UniWebViewComponent = self.UniWebViewClone:GetComponent("UniWebView")

		self.UniWebViewComponent:LoadHTMLString(userData.content, userData.url, false)
		self.UniWebViewComponent:Show()
		self.UniWebViewComponent:UpdateFrame()
	else
		UGUIUtil.SetText(self.TextContent, userData.content)
	end
end

function WebUI:OnClose(userData)
	if IQIGame.Onigao.Game.Device.isMobile and self.UniWebViewClone then
		UnityEngine.GameObject.Destroy(self.UniWebViewClone)

		self.UniWebViewClone = nil
	end
end

function WebUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.BtnGoBack:GetComponent("Button").onClick:AddListener(self.delegateBtnGoBack)
	self.BtnRefresh:GetComponent("Button").onClick:AddListener(self.delegateBtnRefresh)
	self.BtnGoForward:GetComponent("Button").onClick:AddListener(self.delegateBtnGoForward)
end

function WebUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.BtnGoBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGoBack)
	self.BtnRefresh:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRefresh)
	self.BtnGoForward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGoForward)
end

function WebUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.WebUI)
end

function WebUI:OnClickWebOtherBtn(index)
	if self.UniWebViewComponent == nil then
		return
	end

	if index == 1 then
		self.UniWebViewComponent:GoBack()
	elseif index == 2 then
		self.UniWebViewComponent:ReLoad()
	elseif index == 3 then
		self.UniWebViewComponent:GoForward()
	end
end

function WebUI:OnClickBtnGoBack()
	self.UniWebViewComponent:GoBack()
end

function WebUI:OnClickBtnGoForward()
	self.UniWebViewComponent:GoForward()
end

function WebUI:OnClickBtnRefresh()
	self.UniWebViewComponent:ReLoad()
end

function WebUI:OnPause()
	return
end

function WebUI:OnResume()
	return
end

function WebUI:OnCover()
	return
end

function WebUI:OnReveal()
	return
end

function WebUI:OnRefocus(userData)
	return
end

function WebUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WebUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WebUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WebUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WebUI:OnDestroy()
	return
end

return WebUI
