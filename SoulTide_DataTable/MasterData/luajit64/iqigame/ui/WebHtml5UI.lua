-- chunkname: @IQIGame\\UI\\WebHtml5UI.lua

local WebHtml5UI = {}

WebHtml5UI = Base:Extend("WebHtml5UI", "IQIGame.Onigao.UI.WebHtml5UI", WebHtml5UI)

function WebHtml5UI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end
end

function WebHtml5UI:GetPreloadAssetPaths()
	return nil
end

function WebHtml5UI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WebHtml5UI:IsManualShowOnOpen(userData)
	return false
end

function WebHtml5UI:GetBGM(userData)
	return nil
end

function WebHtml5UI:OnOpen(userData)
	self.url = userData

	self:UpdateView()
	EventDispatcher.Dispatch(EventID.StopBGM)
end

function WebHtml5UI:OnClose(userData)
	if self.UniWebViewClone ~= nil then
		UnityEngine.GameObject.Destroy(self.UniWebViewClone)

		self.UniWebViewClone = nil
	end

	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function WebHtml5UI:OnAddListeners()
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function WebHtml5UI:OnRemoveListeners()
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function WebHtml5UI:OnPause()
	return
end

function WebHtml5UI:OnResume()
	return
end

function WebHtml5UI:OnCover()
	return
end

function WebHtml5UI:OnReveal()
	return
end

function WebHtml5UI:OnRefocus(userData)
	return
end

function WebHtml5UI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WebHtml5UI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WebHtml5UI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WebHtml5UI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WebHtml5UI:OnDestroy()
	return
end

function WebHtml5UI:UpdateView()
	if IQIGame.Onigao.Game.Device.isMobile then
		if self.UniWebViewClone ~= nil then
			UnityEngine.GameObject.Destroy(self.UniWebViewClone)
		end

		self.UniWebViewClone = UnityEngine.Object.Instantiate(self.UniWebView)

		self.UniWebViewClone.transform:SetParent(self.UniWebViewPanel.transform, false)

		local uniWebViewCom = self.UniWebViewClone:GetComponent("UniWebView")

		uniWebViewCom:SetZoomEnabled(true)
		uniWebViewCom:SetBackButtonEnabled(false)
		uniWebViewCom:Load(self.url, false)
		uniWebViewCom:Show()
	else
		UGUIUtil.SetText(self.ContentText, "Not supported on Unity Editor Mode.")
	end
end

function WebHtml5UI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.WebHtml5UI)
end

return WebHtml5UI
