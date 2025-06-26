-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreLevelExitUIController.lua

local DualTeamExploreLevelExitUIController = {}

function DualTeamExploreLevelExitUIController.New(uiController)
	local obj = Clone(DualTeamExploreLevelExitUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreLevelExitUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreLevelExitUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreLevelExitUIController:OnInit()
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

	UGUIUtil.SetText(self.TitleText, DualTeamExploreLevelExitUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ContentText, DualTeamExploreLevelExitUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, DualTeamExploreLevelExitUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.GiveUpBtn, DualTeamExploreLevelExitUIApi:GetString("GiveUpBtnText"))
	UGUIUtil.SetTextInChildren(self.AFKBtn, DualTeamExploreLevelExitUIApi:GetString("AFKBtnText"))
end

function DualTeamExploreLevelExitUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreLevelExitUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreLevelExitUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreLevelExitUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreLevelExitUIController:OnOpen(userData)
	self.OnGiveUpCallback = userData.onGiveUp
	self.OnAFKCallback = userData.onAFK
end

function DualTeamExploreLevelExitUIController:OnClose(userData)
	return
end

function DualTeamExploreLevelExitUIController:OnAddListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
	self.AFKBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAFKBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn1)
end

function DualTeamExploreLevelExitUIController:OnRemoveListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
	self.AFKBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAFKBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn1)
end

function DualTeamExploreLevelExitUIController:OnPause()
	return
end

function DualTeamExploreLevelExitUIController:OnResume()
	return
end

function DualTeamExploreLevelExitUIController:OnCover()
	return
end

function DualTeamExploreLevelExitUIController:OnReveal()
	return
end

function DualTeamExploreLevelExitUIController:OnRefocus(userData)
	return
end

function DualTeamExploreLevelExitUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreLevelExitUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreLevelExitUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreLevelExitUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreLevelExitUIController:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreLevelExitUIController:OnClickGiveUpBtn()
	UIModule.CloseSelf(self)
	self.OnGiveUpCallback()
end

function DualTeamExploreLevelExitUIController:OnClickAFKBtn()
	UIModule.CloseSelf(self)
	self.OnAFKCallback()
end

function DualTeamExploreLevelExitUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreLevelExitUIController
