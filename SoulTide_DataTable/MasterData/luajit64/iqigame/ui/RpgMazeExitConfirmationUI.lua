-- chunkname: @IQIGame\\UI\\RpgMazeExitConfirmationUI.lua

local RpgMazeExitConfirmationUI = {}

RpgMazeExitConfirmationUI = Base:Extend("RpgMazeExitConfirmationUI", "IQIGame.Onigao.UI.RpgMazeExitConfirmationUI", RpgMazeExitConfirmationUI)

function RpgMazeExitConfirmationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnClickAFKBtn()
		self:OnClickAFKBtn()
	end

	local titleText1, titleText2 = RpgMazeExitConfirmationUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetTextInChildren(self.ExitBtn, RpgMazeExitConfirmationUIApi:GetString("ExitBtnText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, RpgMazeExitConfirmationUIApi:GetString("AFKBtnText"))
end

function RpgMazeExitConfirmationUI:GetPreloadAssetPaths()
	return nil
end

function RpgMazeExitConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RpgMazeExitConfirmationUI:IsManualShowOnOpen(userData)
	return false
end

function RpgMazeExitConfirmationUI:GetBGM(userData)
	return nil
end

function RpgMazeExitConfirmationUI:OnOpen(userData)
	self:UpdateView()
end

function RpgMazeExitConfirmationUI:OnClose(userData)
	return
end

function RpgMazeExitConfirmationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
end

function RpgMazeExitConfirmationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
end

function RpgMazeExitConfirmationUI:OnPause()
	return
end

function RpgMazeExitConfirmationUI:OnResume()
	return
end

function RpgMazeExitConfirmationUI:OnCover()
	return
end

function RpgMazeExitConfirmationUI:OnReveal()
	return
end

function RpgMazeExitConfirmationUI:OnRefocus(userData)
	return
end

function RpgMazeExitConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RpgMazeExitConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RpgMazeExitConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RpgMazeExitConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RpgMazeExitConfirmationUI:OnDestroy()
	return
end

function RpgMazeExitConfirmationUI:UpdateView()
	local isFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, MazeDataModule.MazeInstanceID) ~= -1

	UGUIUtil.SetText(self.ContentText, RpgMazeExitConfirmationUIApi:GetString("ContentText", isFinished))
	UGUIUtil.SetText(self.TipText, RpgMazeExitConfirmationUIApi:GetString("TipText", isFinished))
	self.ExitBtn:SetActive(isFinished)
end

function RpgMazeExitConfirmationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RpgMazeExitConfirmationUI:OnClickExitBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendLeaveMazeOrder()
	end
end

function RpgMazeExitConfirmationUI:OnClickAFKBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendAFKOrder()
	end
end

return RpgMazeExitConfirmationUI
