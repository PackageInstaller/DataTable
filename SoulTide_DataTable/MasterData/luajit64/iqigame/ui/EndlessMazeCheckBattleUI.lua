-- chunkname: @IQIGame\\UI\\EndlessMazeCheckBattleUI.lua

local EndlessMazeCheckBattleUI = Base:Extend("EndlessMazeCheckBattleUI", "IQIGame.Onigao.UI.EndlessMazeCheckBattleUI", {})

function EndlessMazeCheckBattleUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	UGUIUtil.SetText(self.TitleText1, EndlessMazeCheckBattleUIApi:GetString("TitleText1"))
	UGUIUtil.SetText(self.TitleText2, EndlessMazeCheckBattleUIApi:GetString("TitleText2"))
	UGUIUtil.SetText(self.ContentText, EndlessMazeCheckBattleUIApi:GetString("ContentText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, EndlessMazeCheckBattleUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessMazeCheckBattleUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.IgnoreToggle, EndlessMazeCheckBattleUIApi:GetString("IgnoreToggleText"))
end

function EndlessMazeCheckBattleUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeCheckBattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeCheckBattleUI:OnOpen(userData)
	self.OnCloseCallback = userData.onClose

	UGUIUtil.SetText(self.TipText, EndlessMazeCheckBattleUIApi:GetString("TipText", MazeDataModule.ChapterType))

	self.IgnoreToggle:GetComponent("Toggle").isOn = false
end

function EndlessMazeCheckBattleUI:OnClose(userData)
	return
end

function EndlessMazeCheckBattleUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
end

function EndlessMazeCheckBattleUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
end

function EndlessMazeCheckBattleUI:OnPause()
	return
end

function EndlessMazeCheckBattleUI:OnResume()
	return
end

function EndlessMazeCheckBattleUI:OnCover()
	return
end

function EndlessMazeCheckBattleUI:OnReveal()
	return
end

function EndlessMazeCheckBattleUI:OnRefocus(userData)
	return
end

function EndlessMazeCheckBattleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeCheckBattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeCheckBattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeCheckBattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeCheckBattleUI:OnDestroy()
	return
end

function EndlessMazeCheckBattleUI:OnClickConfirmBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeCheckBattleUI)

	if self.IgnoreToggle:GetComponent("Toggle").isOn then
		MazeModule.IsQuickFightIgnoreType = 1
	end

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback(true)
	end
end

function EndlessMazeCheckBattleUI:OnClickCancelBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeCheckBattleUI)

	if self.IgnoreToggle:GetComponent("Toggle").isOn then
		MazeModule.IsQuickFightIgnoreType = 2
	end

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback(false)
	end
end

return EndlessMazeCheckBattleUI
