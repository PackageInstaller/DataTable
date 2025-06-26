-- chunkname: @IQIGame\\UI\\WebNoticeUI.lua

local WebNoticeUI = Base:Extend("WebNoticeUI", "IQIGame.Onigao.UI.WebNoticeUI", {})

function WebNoticeUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, NoticeUIApi:GetTextTitle())
	UGUIUtil.SetText(self.TextTitleEng, NoticeUIApi:GetTextTitleEng())
	UGUIUtil.SetText(self.TextBtn, NoticeUIApi:GetTextBtn())

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end
end

function WebNoticeUI:GetPreloadAssetPaths()
	return nil
end

function WebNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WebNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function WebNoticeUI:GetBGM(userData)
	return nil
end

function WebNoticeUI:OnOpen(userData)
	if IQIGame.Onigao.Game.Device.isMobile then
		self.UniWebViewClone = UnityEngine.Object.Instantiate(self.UniWebView)

		self.UniWebViewClone.transform:SetParent(self.UniWebViewPanel.transform, false)

		local uniWebViewCom = self.UniWebViewClone:GetComponent("UniWebView")

		uniWebViewCom:LoadHTMLString(userData.content, LoginModule.GetRequestUrl(Constant.LoginConst.GetNoticeContentUrl), false)
		uniWebViewCom:Show()
		uniWebViewCom:UpdateFrame()
	else
		UGUIUtil.SetText(self.TextContent, userData.content)
	end
end

function WebNoticeUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
end

function WebNoticeUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
end

function WebNoticeUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.WebNoticeUI)
end

function WebNoticeUI:OnClose(userData)
	if IQIGame.Onigao.Game.Device.isMobile and self.UniWebViewClone then
		UnityEngine.GameObject.Destroy(self.UniWebViewClone)

		self.UniWebViewClone = nil
	end
end

function WebNoticeUI:OnPause()
	return
end

function WebNoticeUI:OnResume()
	return
end

function WebNoticeUI:OnCover()
	return
end

function WebNoticeUI:OnReveal()
	return
end

function WebNoticeUI:OnRefocus(userData)
	return
end

function WebNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WebNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WebNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WebNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WebNoticeUI:OnDestroy()
	return
end

return WebNoticeUI
