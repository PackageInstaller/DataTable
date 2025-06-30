-- chunkname: @IQIGame\\UI\\AmusementParkOverViewUI.lua

local AmusementParkOverViewUI = {
	Buildings = {},
	ParkOverCellPool = {}
}

AmusementParkOverViewUI = Base:Extend("AmusementParkOverViewUI", "IQIGame.Onigao.UI.AmusementParkOverViewUI", AmusementParkOverViewUI)

require("IQIGame.UIExternalApi.AmusementParkOverViewUIApi")

local AmusementParkOverCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkOverView.AmusementParkOverCell")

function AmusementParkOverViewUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateInfoEvent()
		self:OnUpdateInfoEvent()
	end

	function self.DelegateUpdateParkGameShow()
		self:OnUpdateParkGameShow()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end
end

function AmusementParkOverViewUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkOverViewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkOverViewUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkOverViewUI:GetBGM(userData)
	return nil
end

function AmusementParkOverViewUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkOverViewUI:OnClose(userData)
	return
end

function AmusementParkOverViewUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfoEvent)
	EventDispatcher.AddEventListener(EventID.APUpdateParkGameShowInfoEvent, self.DelegateUpdateParkGameShow)
end

function AmusementParkOverViewUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfoEvent)
	EventDispatcher.RemoveEventListener(EventID.APUpdateParkGameShowInfoEvent, self.DelegateUpdateParkGameShow)
end

function AmusementParkOverViewUI:OnPause()
	return
end

function AmusementParkOverViewUI:OnResume()
	return
end

function AmusementParkOverViewUI:OnCover()
	return
end

function AmusementParkOverViewUI:OnReveal()
	return
end

function AmusementParkOverViewUI:OnRefocus(userData)
	return
end

function AmusementParkOverViewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkOverViewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkOverViewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkOverViewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkOverViewUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.ParkOverCellPool) do
		v:Dispose()
	end
end

function AmusementParkOverViewUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkOverViewUI:OnUpdateInfoEvent()
	self:UpdateView()
end

function AmusementParkOverViewUI:OnUpdateParkGameShow()
	self:UpdateView()
end

function AmusementParkOverViewUI:UpdateView()
	UGUIUtil.SetText(self.TextPlayerName, PlayerModule.PlayerInfo.baseInfo.pName)

	self.Buildings = {}

	for i, v in pairs(AmusementParkModule.AmusementParkBuilds) do
		if #v:GetCfgData().FunctionGroup > 0 then
			table.insert(self.Buildings, v)
		end
	end

	table.sort(self.Buildings, function(a, b)
		local buildA = a:IsUnlock() and 1 or 0
		local buildB = b:IsUnlock() and 1 or 0

		if buildA == buildB then
			return a.cid < b.cid
		end

		return buildB < buildA
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.Buildings)
end

function AmusementParkOverViewUI:OnRenderCell(cell)
	local buildingData = self.Buildings[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local parkOverCell = self.ParkOverCellPool[instanceID]

	if parkOverCell == nil then
		parkOverCell = AmusementParkOverCell.New(cell.gameObject)
		self.ParkOverCellPool[instanceID] = parkOverCell
	end

	parkOverCell:SetData(buildingData)
end

function AmusementParkOverViewUI:OnSelectedCell(cell)
	return
end

return AmusementParkOverViewUI
