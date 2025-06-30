-- chunkname: @IQIGame\\UI\\MaintainTipsUI.lua

local MaintainTipsUI = {}

MaintainTipsUI = Base:Extend("MaintainTipsUI", "IQIGame.Onigao.UI.MaintainTipsUI", MaintainTipsUI)

function MaintainTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.uniWebViewCom = self.UniWebView:GetComponent("UniWebView")
end

function MaintainTipsUI:GetPreloadAssetPaths()
	return nil
end

function MaintainTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MaintainTipsUI:IsManualShowOnOpen(userData)
	return false
end

function MaintainTipsUI:GetBGM(userData)
	return nil
end

function MaintainTipsUI:OnOpen(userData)
	self:ShowMaintainInfo(userData.notice)
end

function MaintainTipsUI:OnClose(userData)
	return
end

function MaintainTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MaintainTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MaintainTipsUI:OnPause()
	return
end

function MaintainTipsUI:OnResume()
	return
end

function MaintainTipsUI:OnCover()
	return
end

function MaintainTipsUI:OnReveal()
	return
end

function MaintainTipsUI:OnRefocus(userData)
	return
end

function MaintainTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MaintainTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MaintainTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MaintainTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MaintainTipsUI:OnDestroy()
	return
end

function MaintainTipsUI:ShowMaintainInfo(notice)
	UGUIUtil.SetText(self.MaintainInfoText, notice)
end

function MaintainTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return MaintainTipsUI
