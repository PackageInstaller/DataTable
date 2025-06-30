-- chunkname: @IQIGame\\UI\\AmusementParkMainBuildUI.lua

local AmusementParkMainBuildUI = {
	TicketCellPool = {}
}

AmusementParkMainBuildUI = Base:Extend("AmusementParkMainBuildUI", "IQIGame.Onigao.UI.AmusementParkMainBuildUI", AmusementParkMainBuildUI)

require("IQIGame.UIExternalApi.AmusementParkMainBuildUIApi")

local ROTicketCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.ROTicketCell")
local AmusementParkMainBuildPanelInfoView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildPanelInfoView")
local AmusementParkMainBuildListInfoView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildListInfoView")
local AmusementParkMainBuildFunctionView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildFunctionView")
local AmusementParkMainBuildTipInfoView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildTipInfoView")

function AmusementParkMainBuildUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateUpdateInfo()
		self:OnUpdateInfo()
	end

	function self.DelegateUpdateParkLand()
		self:OnUpdateParkLand()
	end

	function self.DelegateParkMainBuild(buildAreaData)
		self:OnParkMainBuild(buildAreaData)
	end

	self.BuildPanelInfoView = AmusementParkMainBuildPanelInfoView.New(self.PanelInfo, self)
	self.BuildFunctionView = AmusementParkMainBuildFunctionView.New(self.BuildingFunction, self)
	self.BuildListInfoView = AmusementParkMainBuildListInfoView.New(self.BuildingList, self)
	self.BuildTipInfoView = AmusementParkMainBuildTipInfoView.New(self.TipsInfo, self)
	self.TicketCellPool = {}

	local cfgControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]
	local roTicketCell1 = ROTicketCell.New(self.Ticket1)

	roTicketCell1:RefreshData(cfgControlData.MoneyId)

	self.TicketCellPool[1] = roTicketCell1

	local roTicketCell2 = ROTicketCell.New(self.Ticket2)

	roTicketCell2:RefreshData(cfgControlData.ExpId)

	self.TicketCellPool[2] = roTicketCell2
end

function AmusementParkMainBuildUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkMainBuildUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkMainBuildUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkMainBuildUI:GetBGM(userData)
	return nil
end

function AmusementParkMainBuildUI:OnOpen(userData)
	EventDispatcher.Dispatch(EventID.APEditStateEvent, true)

	self.BuildAreaData = userData.BuildAreaData

	self:UpdateView()
end

function AmusementParkMainBuildUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.APEditStateEvent, false)
end

function AmusementParkMainBuildUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
	EventDispatcher.AddEventListener(EventID.APUpdateParkMainBuildUIEvent, self.DelegateParkMainBuild)
end

function AmusementParkMainBuildUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
	EventDispatcher.RemoveEventListener(EventID.APUpdateParkMainBuildUIEvent, self.DelegateParkMainBuild)
end

function AmusementParkMainBuildUI:OnPause()
	return
end

function AmusementParkMainBuildUI:OnResume()
	return
end

function AmusementParkMainBuildUI:OnCover()
	return
end

function AmusementParkMainBuildUI:OnReveal()
	return
end

function AmusementParkMainBuildUI:OnRefocus(userData)
	return
end

function AmusementParkMainBuildUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkMainBuildUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkMainBuildUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkMainBuildUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkMainBuildUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.TicketCellPool) do
		v:Dispose()
	end

	self.BuildFunctionView:Dispose()

	self.BuildFunctionView = nil

	self.BuildPanelInfoView:Dispose()

	self.BuildPanelInfoView = nil

	self.BuildListInfoView:Dispose()

	self.BuildListInfoView = nil

	self.BuildTipInfoView:Dispose()

	self.BuildTipInfoView = nil
end

function AmusementParkMainBuildUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function AmusementParkMainBuildUI:OnParkMainBuild(buildAreaData)
	self.BuildAreaData = buildAreaData

	self:UpdateView()
end

function AmusementParkMainBuildUI:OnUpdateInfo()
	self:UpdateView()
end

function AmusementParkMainBuildUI:OnUpdateParkLand()
	self:UpdateView()
end

function AmusementParkMainBuildUI:UpdateView()
	self:SetDefaultChildView()

	if self.BuildAreaData then
		local buildData = self.BuildAreaData:GetAreaBuildData()

		if buildData ~= nil then
			self.BuildFunctionView:Show(buildData)
			self.BuildPanelInfoView:Show(2, buildData)
		else
			self.BuildListInfoView:Show()
		end
	end
end

function AmusementParkMainBuildUI:SetDefaultChildView()
	self.BuildFunctionView:Hide()
	self.BuildPanelInfoView:Hide()
	self.BuildListInfoView:Hide()
	self.BuildTipInfoView:Hide()
end

return AmusementParkMainBuildUI
