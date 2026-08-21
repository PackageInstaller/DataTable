-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreMazeExitConfirmationUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreMazeExitConfirmationUIApi")

local DualTeamExploreMazeExitConfirmationUIController = {}

function DualTeamExploreMazeExitConfirmationUIController.New(uiController)
	local obj = Clone(DualTeamExploreMazeExitConfirmationUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreMazeExitConfirmationUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreMazeExitConfirmationUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreMazeExitConfirmationUIController:OnInit()
	function self.DelegateOnClickAFKBtn()
		self:OnClickAFKBtn()
	end

	function self.DelegateOnClickGiveUpBtn()
		self:OnClickGiveUpBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local titleText1, titleText2 = DualTeamExploreMazeExitConfirmationUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.ContentText, DualTeamExploreMazeExitConfirmationUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, DualTeamExploreMazeExitConfirmationUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, DualTeamExploreMazeExitConfirmationUIApi:GetString("AFKBtnText"))
	UGUIUtil.SetTextInChildren(self.GiveUpBtn, DualTeamExploreMazeExitConfirmationUIApi:GetString("GiveUpBtn"))
end

function DualTeamExploreMazeExitConfirmationUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreMazeExitConfirmationUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreMazeExitConfirmationUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreMazeExitConfirmationUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreMazeExitConfirmationUIController:OnOpen(userData)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnClose(userData)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnAddListeners()
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreMazeExitConfirmationUIController:OnRemoveListeners()
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreMazeExitConfirmationUIController:OnPause()
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnResume()
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnCover()
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnReveal()
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnRefocus(userData)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreMazeExitConfirmationUIController:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreMazeExitConfirmationUIController:OnClickAFKBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendAFKOrder()
	end
end

function DualTeamExploreMazeExitConfirmationUIController:OnClickGiveUpBtn()
	UIModule.CloseSelf(self)

	if MazeModule.CommandSwitchOn then
		MazeModule.SendLeaveMazeOrder()
	end
end

function DualTeamExploreMazeExitConfirmationUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreMazeExitConfirmationUIController
