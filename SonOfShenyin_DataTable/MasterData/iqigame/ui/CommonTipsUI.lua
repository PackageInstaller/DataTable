-- chunkname: @IQIGame\\UI\\CommonTipsUI.lua

local CommonTipsUI = Base:Extend("CommonTipsUI", "IQIGame.Onigao.UI.CommonTipsUI", {})

function CommonTipsUI:OnInit()
	LuaCodeInterface.BindOutlet(self.CloseBtn, self)

	self.CloseBtnComponent = self.CloseBtn:GetComponent("Button")
	self.CnTipsTextComponent = self.CNText:GetComponent("Text")
	self.TweenPanelComponent = self.TweenPanel:GetComponent("TweenAlpha")

	function self.DelegateCloseBtn()
		self:OnCloseBtnClick()
	end
end

function CommonTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonTipsUI:GetBGM(userData)
	return nil
end

function CommonTipsUI:OnOpen(userData)
	local args = userData

	self.Type = args[1]
	self.Content = args[2]
	self.Action = args[3]

	self:SetShowData()
end

function CommonTipsUI:OnClose(userData)
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.TweenPanelComponent:ResetToBeginning()

	self.Action = nil
end

function CommonTipsUI:OnAddListeners()
	self.CloseBtnComponent.onClick:AddListener(self.DelegateCloseBtn)
end

function CommonTipsUI:OnRemoveListeners()
	self.CloseBtnComponent.onClick:RemoveListener(self.DelegateCloseBtn)
end

function CommonTipsUI:OnPause()
	return
end

function CommonTipsUI:OnResume()
	return
end

function CommonTipsUI:OnCover()
	return
end

function CommonTipsUI:OnReveal()
	return
end

function CommonTipsUI:OnRefocus(userData)
	return
end

function CommonTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonTipsUI:OnDestroy()
	return
end

function CommonTipsUI:SetShowData()
	self.CnTipsTextComponent.text = self.Content

	self.TweenPanelComponent:PlayForward()

	self.timer = Timer.New(function()
		self:OnCloseBtnClick()
	end, 2, -1)

	self.timer:Start()
end

function CommonTipsUI:OnCloseBtnClick()
	if self.Action ~= nil then
		self:Action()
	end

	UIModule.CloseSelf(self)
end

return CommonTipsUI
