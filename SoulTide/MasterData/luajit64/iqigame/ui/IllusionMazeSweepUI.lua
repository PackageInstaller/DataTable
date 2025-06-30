-- chunkname: @IQIGame\\UI\\IllusionMazeSweepUI.lua

local IllusionMazeSweepUI = {}

IllusionMazeSweepUI = Base:Extend("IllusionMazeSweepUI", "IQIGame.Onigao.UI.IllusionMazeSweepUI", IllusionMazeSweepUI)

require("IQIGame.UIExternalApi.IllusionMazeSweepUIApi")

function IllusionMazeSweepUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	UGUIUtil.SetText(self.TitleText, IllusionMazeSweepUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ContentText, IllusionMazeSweepUIApi:GetString("ContentText"))
	UGUIUtil.SetText(self.TipText, IllusionMazeSweepUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, IllusionMazeSweepUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, IllusionMazeSweepUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetTextInChildren(self.IgnoreToggle, IllusionMazeSweepUIApi:GetString("IgnoreToggleText"))
end

function IllusionMazeSweepUI:GetPreloadAssetPaths()
	return nil
end

function IllusionMazeSweepUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function IllusionMazeSweepUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeSweepUI:GetBGM(userData)
	return nil
end

function IllusionMazeSweepUI:OnOpen(userData)
	return
end

function IllusionMazeSweepUI:OnClose(userData)
	return
end

function IllusionMazeSweepUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
end

function IllusionMazeSweepUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
end

function IllusionMazeSweepUI:OnPause()
	return
end

function IllusionMazeSweepUI:OnResume()
	return
end

function IllusionMazeSweepUI:OnCover()
	return
end

function IllusionMazeSweepUI:OnReveal()
	return
end

function IllusionMazeSweepUI:OnRefocus(userData)
	return
end

function IllusionMazeSweepUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function IllusionMazeSweepUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function IllusionMazeSweepUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function IllusionMazeSweepUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function IllusionMazeSweepUI:OnDestroy()
	return
end

function IllusionMazeSweepUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)

	if self.IgnoreToggle:GetComponent("Toggle").isOn then
		NoticeModule.AddCustomIgnoreType(Constant.CustomIgnoreType.IllusionMazeSweep)
	end

	MazeModule.SweepIllusionMaze(Constant.MazeId.IllusionMaze, 1)
end

function IllusionMazeSweepUI:OnClickCancelBtn()
	UIModule.CloseSelf(self)
end

return IllusionMazeSweepUI
