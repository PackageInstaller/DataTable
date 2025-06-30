-- chunkname: @IQIGame\\UI\\HorizontalRpgMazeExitConfirmationUI.lua

local HorizontalRpgMazeExitConfirmationUI = {}

HorizontalRpgMazeExitConfirmationUI = Base:Extend("HorizontalRpgMazeExitConfirmationUI", "IQIGame.Onigao.UI.HorizontalRpgMazeExitConfirmationUI", HorizontalRpgMazeExitConfirmationUI)

require("IQIGame.UIExternalApi.HorizontalRpgMazeExitConfirmationUIApi")

function HorizontalRpgMazeExitConfirmationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnClickAFKBtn()
		self:OnClickAFKBtn()
	end

	local titleText1, titleText2 = HorizontalRpgMazeExitConfirmationUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetTextInChildren(self.ExitBtn, HorizontalRpgMazeExitConfirmationUIApi:GetString("ExitBtnText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, HorizontalRpgMazeExitConfirmationUIApi:GetString("AFKBtnText"))
end

function HorizontalRpgMazeExitConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRpgMazeExitConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRpgMazeExitConfirmationUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRpgMazeExitConfirmationUI:GetBGM(userData)
	return nil
end

function HorizontalRpgMazeExitConfirmationUI:OnOpen(userData)
	self:UpdateView()
end

function HorizontalRpgMazeExitConfirmationUI:OnClose(userData)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
end

function HorizontalRpgMazeExitConfirmationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
end

function HorizontalRpgMazeExitConfirmationUI:OnPause()
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnResume()
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnCover()
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnReveal()
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnRefocus(userData)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRpgMazeExitConfirmationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HorizontalRpgMazeExitConfirmationUI:UpdateView()
	UGUIUtil.SetText(self.ContentText, HorizontalRpgMazeExitConfirmationUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, HorizontalRpgMazeExitConfirmationUIApi:GetString("TipText"))
	self.ExitBtn:SetActive(true)
	self.AFKBtn:SetActive(false)
end

function HorizontalRpgMazeExitConfirmationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function HorizontalRpgMazeExitConfirmationUI:OnClickExitBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendLeaveMazeOrder()
	end
end

function HorizontalRpgMazeExitConfirmationUI:OnClickAFKBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendAFKOrder()
	end
end

return HorizontalRpgMazeExitConfirmationUI
