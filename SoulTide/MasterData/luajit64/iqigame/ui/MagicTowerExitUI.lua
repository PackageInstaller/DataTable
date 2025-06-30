-- chunkname: @IQIGame\\UI\\MagicTowerExitUI.lua

local MagicTowerExitUI = {}

MagicTowerExitUI = Base:Extend("MagicTowerExitUI", "IQIGame.Onigao.UI.MagicTowerExitUI", MagicTowerExitUI)

function MagicTowerExitUI:OnInit()
	function self.DelegateOnClickGiveUpBtn()
		self:OnClickGiveUpBtn()
	end

	function self.DelegateOnClickAFKBtn()
		self:OnClickAFKBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCloseBtn1()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, MagicTowerExitUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ContentText, MagicTowerExitUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, MagicTowerExitUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.GiveUpBtn, MagicTowerExitUIApi:GetString("GiveUpBtnText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, MagicTowerExitUIApi:GetString("AFKBtnText"))
end

function MagicTowerExitUI:GetPreloadAssetPaths()
	return nil
end

function MagicTowerExitUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MagicTowerExitUI:IsManualShowOnOpen(userData)
	return false
end

function MagicTowerExitUI:GetBGM(userData)
	return nil
end

function MagicTowerExitUI:OnOpen(userData)
	self.OnGiveUpCallback = userData.onGiveUp
	self.OnAFKCallback = userData.onAFK
end

function MagicTowerExitUI:OnClose(userData)
	return
end

function MagicTowerExitUI:OnAddListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn1)
end

function MagicTowerExitUI:OnRemoveListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn1)
end

function MagicTowerExitUI:OnPause()
	return
end

function MagicTowerExitUI:OnResume()
	return
end

function MagicTowerExitUI:OnCover()
	return
end

function MagicTowerExitUI:OnReveal()
	return
end

function MagicTowerExitUI:OnRefocus(userData)
	return
end

function MagicTowerExitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MagicTowerExitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MagicTowerExitUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MagicTowerExitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MagicTowerExitUI:OnDestroy()
	return
end

function MagicTowerExitUI:OnClickGiveUpBtn()
	UIModule.CloseSelf(self)
	self.OnGiveUpCallback()
end

function MagicTowerExitUI:OnClickAFKBtn()
	UIModule.CloseSelf(self)
	self.OnAFKCallback()
end

function MagicTowerExitUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return MagicTowerExitUI
