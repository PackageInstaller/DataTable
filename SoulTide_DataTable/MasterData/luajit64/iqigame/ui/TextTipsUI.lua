-- chunkname: @IQIGame\\UI\\TextTipsUI.lua

local TextTipsUI = Base:Extend("TextTipsUI", "IQIGame.Onigao.UI.TextTipsUI", {})

function TextTipsUI:OnInit()
	self:Initialize()
end

function TextTipsUI:GetPreloadAssetPaths()
	return nil
end

function TextTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TextTipsUI:OnOpen(userData)
	self:Refresh(userData)
end

function TextTipsUI:OnClose(userData)
	self:OnHide()
end

function TextTipsUI:OnPause()
	return
end

function TextTipsUI:OnResume()
	return
end

function TextTipsUI:OnCover()
	return
end

function TextTipsUI:OnReveal()
	return
end

function TextTipsUI:OnRefocus(userData)
	return
end

function TextTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TextTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TextTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TextTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TextTipsUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.tfContent = self.goContent:GetComponent("Text")
end

function TextTipsUI:Refresh(userData)
	local content = userData[1]
	local showClose = userData[2]

	if showClose == nil then
		showClose = true
	end

	self.tfContent.text = tostring(content)

	self.goBtnClose:SetActive(showClose)
end

function TextTipsUI:OnHide()
	return
end

function TextTipsUI:OnDestroy()
	return
end

function TextTipsUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function TextTipsUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function TextTipsUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.TextTipsUI)
end

return TextTipsUI
