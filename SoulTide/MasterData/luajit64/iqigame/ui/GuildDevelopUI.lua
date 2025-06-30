-- chunkname: @IQIGame\\UI\\GuildDevelopUI.lua

local GuildDevelopUI = {
	buildings = {},
	buildingCellPool = {}
}

GuildDevelopUI = Base:Extend("GuildDevelopUI", "IQIGame.Onigao.UI.GuildDevelopUI", GuildDevelopUI)

require("IQIGame.UIExternalApi.GuildDevelopUIApi")

local GuildBuildingCell = require("IQIGame.UI.Guild.GuildDevelop.GuildBuildingCell")

function GuildDevelopUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildDevelopUIApi:GetString("TitleText"))

	self.ToggleBase:GetComponent("ToggleHelperComponent").text = GuildDevelopUIApi:GetString("ToggleBaseLabel")
	self.ToggleFight:GetComponent("ToggleHelperComponent").text = GuildDevelopUIApi:GetString("ToggleFightLabel")
	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnRenderSelectGridCell(cell)
	end

	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateToggleBase(isOn)
		self:OnToggleBase(isOn)
	end

	function self.DelegateToggleFight(isOn)
		self:OnToggleFight(isOn)
	end

	function self.DelegateGuildUpdateBuilding()
		self:OnGuildUpdateBuilding()
	end
end

function GuildDevelopUI:GetPreloadAssetPaths()
	return nil
end

function GuildDevelopUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildDevelopUI:IsManualShowOnOpen(userData)
	return false
end

function GuildDevelopUI:GetBGM(userData)
	return nil
end

function GuildDevelopUI:OnOpen(userData)
	if self.selectType == nil then
		self.selectType = Constant.GuildBuildingType.Guild_Building_Base
	end

	self:UpdateView()
end

function GuildDevelopUI:OnClose(userData)
	return
end

function GuildDevelopUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	self.ToggleBase:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleBase)
	self.ToggleFight:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleFight)
	EventDispatcher.AddEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	self.ToggleBase:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleBase)
	self.ToggleFight:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleFight)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopUI:OnPause()
	return
end

function GuildDevelopUI:OnResume()
	return
end

function GuildDevelopUI:OnCover()
	return
end

function GuildDevelopUI:OnReveal()
	return
end

function GuildDevelopUI:OnRefocus(userData)
	return
end

function GuildDevelopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildDevelopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildDevelopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildDevelopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildDevelopUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.buildingCellPool) do
		v:Dispose()
	end
end

function GuildDevelopUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function GuildDevelopUI:OnToggleBase(isOn)
	if isOn then
		self.selectType = Constant.GuildBuildingType.Guild_Building_Base

		self:ShowBuildingByType()
	end
end

function GuildDevelopUI:OnToggleFight(isOn)
	if isOn then
		self.selectType = Constant.GuildBuildingType.Guild_Building_Fight

		self:ShowBuildingByType()
	end
end

function GuildDevelopUI:OnRenderGridCell(cell)
	local cfgData = self.buildings[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local buildCell = self.buildingCellPool[instanceID]

	if buildCell == nil then
		buildCell = GuildBuildingCell.New(cell.gameObject)
		self.buildingCellPool[instanceID] = buildCell
	end

	local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(cfgData.Id)

	buildCell:SetData(cfgData.Id, buildLv, buildMaxLv)
end

function GuildDevelopUI:OnRenderSelectGridCell(cell)
	local cfgData = self.buildings[cell.index + 1]

	UIModule.Open(Constant.UIControllerName.GuildDevelopUpGradeUI, Constant.UILayer.UI, cfgData.Id)
end

function GuildDevelopUI:ShowBuildingByType()
	self.buildings = self:GetBuildingsByType(self.selectType)

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.buildings)
end

function GuildDevelopUI:GetBuildingsByType(type)
	local tab = {}

	for i, v in pairsCfg(CfgGuildBuildingTable) do
		if v.IsShow and v.BuildingType == type then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.Sort < b.Sort
	end)

	return tab
end

function GuildDevelopUI:OnGuildUpdateBuilding()
	self:ShowBuildingByType()
end

function GuildDevelopUI:UpdateView()
	if self.selectType == Constant.GuildBuildingType.Guild_Building_Base then
		if not self.ToggleBase:GetComponent("Toggle").isOn then
			self.ToggleBase:GetComponent("Toggle").isOn = true
		end
	elseif self.selectType == Constant.GuildBuildingType.Guild_Building_Fight and not self.ToggleFight:GetComponent("Toggle").isOn then
		self.ToggleFight:GetComponent("Toggle").isOn = true
	end

	self:ShowBuildingByType()
end

return GuildDevelopUI
