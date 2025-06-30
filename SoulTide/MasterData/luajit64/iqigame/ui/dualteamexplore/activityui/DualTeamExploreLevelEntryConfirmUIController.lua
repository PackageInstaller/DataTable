-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreLevelEntryConfirmUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreLevelEntryConfirmUIApi")

local DualTeamExploreLevelEntryConfirmUIController = {}

function DualTeamExploreLevelEntryConfirmUIController.New(uiController)
	local obj = Clone(DualTeamExploreLevelEntryConfirmUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreLevelEntryConfirmUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreLevelEntryConfirmUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreLevelEntryConfirmUIController:OnInit()
	function self.DelegateOnClickModeBtn1()
		self:OnClickModeBtn1()
	end

	function self.DelegateOnClickModeBtn2()
		self:OnClickModeBtn2()
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreLevelEntryConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.SubTitleText, DualTeamExploreLevelEntryConfirmUIApi:GetString("SubTitleText"))
	UGUIUtil.SetText(self.ModeNameText1, DualTeamExploreLevelEntryConfirmUIApi:GetString("ModeNameText1"))
	UGUIUtil.SetText(self.ModeNameText2, DualTeamExploreLevelEntryConfirmUIApi:GetString("ModeNameText2"))
	UGUIUtil.SetText(self.ModeDescText1, DualTeamExploreLevelEntryConfirmUIApi:GetString("ModeDescText1"))
	UGUIUtil.SetText(self.ModeDescText2, DualTeamExploreLevelEntryConfirmUIApi:GetString("ModeDescText2"))
end

function DualTeamExploreLevelEntryConfirmUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreLevelEntryConfirmUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreLevelEntryConfirmUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreLevelEntryConfirmUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreLevelEntryConfirmUIController:OnOpen(userData)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnClose(userData)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnAddListeners()
	self.ModeBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickModeBtn1)
	self.ModeBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickModeBtn2)
end

function DualTeamExploreLevelEntryConfirmUIController:OnRemoveListeners()
	self.ModeBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickModeBtn1)
	self.ModeBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickModeBtn2)
end

function DualTeamExploreLevelEntryConfirmUIController:OnPause()
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnResume()
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnCover()
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnReveal()
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnRefocus(userData)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreLevelEntryConfirmUIController:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreLevelEntryConfirmUIController:OnClickModeBtn1()
	self:SwitchToLevelEntryUI(1)
end

function DualTeamExploreLevelEntryConfirmUIController:OnClickModeBtn2()
	self:SwitchToLevelEntryUI(2)
end

function DualTeamExploreLevelEntryConfirmUIController:SwitchToLevelEntryUI(mode)
	UIModule.CloseSelf(self)
	UIModule.Open(Constant.UIControllerName.DualTeamExploreLevelEntryUI, Constant.UILayer.UI, {
		isEasyMode = mode == 1
	})
end

return DualTeamExploreLevelEntryConfirmUIController
