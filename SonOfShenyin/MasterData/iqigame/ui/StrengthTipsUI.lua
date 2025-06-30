-- chunkname: @IQIGame\\UI\\StrengthTipsUI.lua

local StrengthTipsUI = {
	Timer = 0,
	DURATION = 2
}

StrengthTipsUI = Base:Extend("StrengthTipsUI", "IQIGame.Onigao.UI.StrengthTipsUI", StrengthTipsUI)

function StrengthTipsUI:OnInit()
	return
end

function StrengthTipsUI:GetPreloadAssetPaths()
	return nil
end

function StrengthTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function StrengthTipsUI:IsManualShowOnOpen(userData)
	return false
end

function StrengthTipsUI:GetBGM(userData)
	return nil
end

function StrengthTipsUI:OnOpen(type)
	UGUIUtil.SetText(self.ContentText, StrengthTipsUIApi:GetContentText(type))
	self:Reset()
end

function StrengthTipsUI:OnClose(userData)
	return
end

function StrengthTipsUI:OnAddListeners()
	return
end

function StrengthTipsUI:OnRemoveListeners()
	return
end

function StrengthTipsUI:OnPause()
	return
end

function StrengthTipsUI:OnResume()
	return
end

function StrengthTipsUI:OnCover()
	return
end

function StrengthTipsUI:OnReveal()
	return
end

function StrengthTipsUI:OnRefocus(userData)
	return
end

function StrengthTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.Timer < self.DURATION then
		self.Timer = self.Timer + realElapseSeconds
	else
		UIModule.Close(Constant.UIControllerName.StrengthTipsUI)
	end
end

function StrengthTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function StrengthTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function StrengthTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function StrengthTipsUI:OnDestroy()
	return
end

function StrengthTipsUI:Reset()
	self.Timer = 0
end

return StrengthTipsUI
