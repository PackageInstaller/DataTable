-- chunkname: @IQIGame\\UI\\DailyActivityEffectUI.lua

local DailyActivityEffectUI = {
	rewards = {}
}

DailyActivityEffectUI = Base:Extend("DailyActivityEffectUI", "IQIGame.Onigao.UI.DailyActivityEffectUI", DailyActivityEffectUI)

function DailyActivityEffectUI:OnInit()
	return
end

function DailyActivityEffectUI:GetPreloadAssetPaths()
	return nil
end

function DailyActivityEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DailyActivityEffectUI:IsManualShowOnOpen(userData)
	return false
end

function DailyActivityEffectUI:GetBGM(userData)
	return nil
end

function DailyActivityEffectUI:OnOpen(userData)
	self.rewards = userData

	local timer = Timer.New(function()
		UIModule.CloseSelf(self)
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.rewards)
	end, 1)

	timer:Start()
end

function DailyActivityEffectUI:OnClose(userData)
	return
end

function DailyActivityEffectUI:OnAddListeners()
	return
end

function DailyActivityEffectUI:OnRemoveListeners()
	return
end

function DailyActivityEffectUI:OnPause()
	return
end

function DailyActivityEffectUI:OnResume()
	return
end

function DailyActivityEffectUI:OnCover()
	return
end

function DailyActivityEffectUI:OnReveal()
	return
end

function DailyActivityEffectUI:OnRefocus(userData)
	return
end

function DailyActivityEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DailyActivityEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DailyActivityEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DailyActivityEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DailyActivityEffectUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return DailyActivityEffectUI
