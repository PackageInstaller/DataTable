-- chunkname: @IQIGame\\UI\\DailyActivityTipsUI.lua

local DailyActivityTipsUI = {
	desStr = ""
}

DailyActivityTipsUI = Base:Extend("DailyActivityTipsUI", "IQIGame.Onigao.UI.DailyActivityTipsUI", DailyActivityTipsUI)

function DailyActivityTipsUI:OnInit()
	UGUIUtil.SetText(self.goTitle, DailyActivityTipsUIApi:GetString("TextTitle"))

	function self.delegateBtnClose()
		self:onBtnClose()
	end
end

function DailyActivityTipsUI:GetPreloadAssetPaths()
	return nil
end

function DailyActivityTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DailyActivityTipsUI:IsManualShowOnOpen(userData)
	return false
end

function DailyActivityTipsUI:GetBGM(userData)
	return nil
end

function DailyActivityTipsUI:OnOpen(userData)
	self.desStr = userData

	self:UpdateView()
end

function DailyActivityTipsUI:OnClose(userData)
	return
end

function DailyActivityTipsUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function DailyActivityTipsUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function DailyActivityTipsUI:OnPause()
	return
end

function DailyActivityTipsUI:OnResume()
	return
end

function DailyActivityTipsUI:OnCover()
	return
end

function DailyActivityTipsUI:OnReveal()
	return
end

function DailyActivityTipsUI:OnRefocus(userData)
	return
end

function DailyActivityTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DailyActivityTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DailyActivityTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DailyActivityTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DailyActivityTipsUI:OnDestroy()
	return
end

function DailyActivityTipsUI:UpdateView()
	UGUIUtil.SetText(self.TextDes, self.desStr)
end

function DailyActivityTipsUI:onBtnClose()
	UIModule.Close(Constant.UIControllerName.DailyActivityTipsUI)
end

return DailyActivityTipsUI
