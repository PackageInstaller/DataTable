-- chunkname: @IQIGame\\UI\\MonthCardGetTipsUI.lua

local MonthCardGetTipsUI = {}

MonthCardGetTipsUI = Base:Extend("MonthCardGetTipsUI", "IQIGame.Onigao.UI.MonthCardGetTipsUI", MonthCardGetTipsUI)

function MonthCardGetTipsUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function MonthCardGetTipsUI:InitComponent()
	self.buttonMask = self.buttonMask:GetComponent("Button")
end

function MonthCardGetTipsUI:InitDelegate()
	function self.buttonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function MonthCardGetTipsUI:OnAddListeners()
	self.buttonMask.onClick:AddListener(self.buttonMaskDelegate)
end

function MonthCardGetTipsUI:OnRemoveListeners()
	self.buttonMask.onClick:RemoveListener(self.buttonMaskDelegate)
end

function MonthCardGetTipsUI:GetPreloadAssetPaths()
	return nil
end

function MonthCardGetTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonthCardGetTipsUI:IsManualShowOnOpen(userData)
	return false
end

function MonthCardGetTipsUI:GetBGM(userData)
	return nil
end

function MonthCardGetTipsUI:OnOpen(userData)
	self:Refresh()
end

function MonthCardGetTipsUI:OnClose(userData)
	return
end

function MonthCardGetTipsUI:OnPause()
	return
end

function MonthCardGetTipsUI:OnResume()
	return
end

function MonthCardGetTipsUI:OnCover()
	return
end

function MonthCardGetTipsUI:OnReveal()
	return
end

function MonthCardGetTipsUI:OnRefocus(userData)
	return
end

function MonthCardGetTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonthCardGetTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonthCardGetTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonthCardGetTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonthCardGetTipsUI:OnDestroy()
	return
end

function MonthCardGetTipsUI:Close()
	UIModule.Close(Constant.UIControllerName.MonthCardGetTipsUI)
end

function MonthCardGetTipsUI:Refresh()
	UGUIUtil.SetText(self.textResidualDays, MonthCardModule.GetMonthResidualDays())
end

function MonthCardGetTipsUI:OnButtonMaskClick()
	self:GetMonthAward()
	self:Close()
end

function MonthCardGetTipsUI:GetMonthAward()
	if not MonthCardModule.monthPrzieState then
		MonthCardModule.GetMonthCardAward()
	end
end

return MonthCardGetTipsUI
