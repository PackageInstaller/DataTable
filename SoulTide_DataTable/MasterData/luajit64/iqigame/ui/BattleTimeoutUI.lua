-- chunkname: @IQIGame\\UI\\BattleTimeoutUI.lua

local BattleTimeoutUI = Base:Extend("BattleTimeoutUI", "IQIGame.Onigao.UI.BattleTimeoutUI", {})

function BattleTimeoutUI:OnInit()
	UGUIUtil.SetText(self.TitleText, BattleTimeoutUIApi:GetString("TitleText"))
end

function BattleTimeoutUI:GetPreloadAssetPaths()
	return nil
end

function BattleTimeoutUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleTimeoutUI:IsManualShowOnOpen(userData)
	return false
end

function BattleTimeoutUI:GetBGM(userData)
	return nil
end

function BattleTimeoutUI:OnOpen(userData)
	self.OnCloseCallback = userData.onClose

	local duration = tonumber(BattleTimeoutUIApi:GetString("Duration"))

	if duration == nil then
		logError("BattleTimeoutUIApi.Duration配置错误")

		duration = 0
	end

	if self.Timer ~= nil then
		self.Timer:Stop()
	end

	self.Timer = Timer.New(function()
		self.Timer = nil

		UIModule.CloseSelf(self)
	end, duration)

	self.Timer:Start()
end

function BattleTimeoutUI:OnClose(userData)
	if self.Timer ~= nil then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.OnCloseCallback()

	self.OnCloseCallback = nil
end

function BattleTimeoutUI:OnAddListeners()
	return
end

function BattleTimeoutUI:OnRemoveListeners()
	return
end

function BattleTimeoutUI:OnPause()
	return
end

function BattleTimeoutUI:OnResume()
	return
end

function BattleTimeoutUI:OnCover()
	return
end

function BattleTimeoutUI:OnReveal()
	return
end

function BattleTimeoutUI:OnRefocus(userData)
	return
end

function BattleTimeoutUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleTimeoutUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleTimeoutUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleTimeoutUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleTimeoutUI:OnDestroy()
	return
end

return BattleTimeoutUI
