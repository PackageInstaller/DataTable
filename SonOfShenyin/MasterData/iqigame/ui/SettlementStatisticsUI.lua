-- chunkname: @IQIGame\\UI\\SettlementStatisticsUI.lua

local SettlementStatisticsUI = {}

SettlementStatisticsUI = Base:Extend("SettlementStatisticsUI", "IQIGame.Onigao.UI.SettlementStatisticsUI", SettlementStatisticsUI)

local SettlementStatisticsViewClass = require("IQIGame/UI/SettlementUI/SettlementStatisticsView")

function SettlementStatisticsUI:OnInit()
	self.statisticsView = SettlementStatisticsViewClass.New(self.statisticsRoot, self)
end

function SettlementStatisticsUI:GetPreloadAssetPaths()
	return nil
end

function SettlementStatisticsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SettlementStatisticsUI:IsManualShowOnOpen(userData)
	return false
end

function SettlementStatisticsUI:GetBGM(userData)
	return nil
end

function SettlementStatisticsUI:OnOpen(userData)
	self.statisticsView:Refresh(userData)
end

function SettlementStatisticsUI:OnClose(userData)
	return
end

function SettlementStatisticsUI:OnAddListeners()
	return
end

function SettlementStatisticsUI:OnRemoveListeners()
	return
end

function SettlementStatisticsUI:OnPause()
	return
end

function SettlementStatisticsUI:OnResume()
	return
end

function SettlementStatisticsUI:OnCover()
	return
end

function SettlementStatisticsUI:OnReveal()
	return
end

function SettlementStatisticsUI:OnRefocus(userData)
	return
end

function SettlementStatisticsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SettlementStatisticsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SettlementStatisticsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SettlementStatisticsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SettlementStatisticsUI:OnDestroy()
	self.statisticsView:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return SettlementStatisticsUI
