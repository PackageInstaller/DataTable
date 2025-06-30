-- chunkname: @IQIGame\\UI\\MazeExitConfirmationUI.lua

local MazeExitConfirmationUI = Base:Extend("MazeExitConfirmationUI", "IQIGame.Onigao.UI.MazeExitConfirmationUI", {})

function MazeExitConfirmationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnClickAFKBtn()
		self:OnClickAFKBtn()
	end

	local titleText1, titleText2 = MazeExitConfirmationUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.ContentText, MazeExitConfirmationUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, MazeExitConfirmationUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ExitBtn, MazeExitConfirmationUIApi:GetString("ExitBtnText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, MazeExitConfirmationUIApi:GetString("AFKBtnText"))
end

function MazeExitConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function MazeExitConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeExitConfirmationUI:OnOpen(userData)
	return
end

function MazeExitConfirmationUI:OnClose(userData)
	return
end

function MazeExitConfirmationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
end

function MazeExitConfirmationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
end

function MazeExitConfirmationUI:OnPause()
	return
end

function MazeExitConfirmationUI:OnResume()
	return
end

function MazeExitConfirmationUI:OnCover()
	return
end

function MazeExitConfirmationUI:OnReveal()
	return
end

function MazeExitConfirmationUI:OnRefocus(userData)
	return
end

function MazeExitConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeExitConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeExitConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeExitConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeExitConfirmationUI:OnDestroy()
	return
end

function MazeExitConfirmationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeExitConfirmationUI:OnClickExitBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendLeaveMazeOrder()
	end
end

function MazeExitConfirmationUI:OnClickAFKBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendAFKOrder()
	end
end

return MazeExitConfirmationUI
