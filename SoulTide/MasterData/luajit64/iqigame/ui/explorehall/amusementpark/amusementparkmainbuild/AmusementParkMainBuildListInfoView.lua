-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildListInfoView.lua

local m = {
	BuildDataList = {},
	BuildCellPool = {}
}
local AmusementParkMainBuildCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildCell")

function m.New(view, RootUI)
	local obj = Clone(m)

	obj:Init(view, RootUI)

	return obj
end

function m:Init(view, RootUI)
	self.View = view
	self.RootUI = RootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BuildScroll:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.BuildScroll:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnRenderCell(cell)
	local buildData = self.BuildDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local buildCell = self.BuildCellPool[instanceID]

	if buildCell == nil then
		buildCell = AmusementParkMainBuildCell.New(cell.gameObject)
		self.BuildCellPool[instanceID] = buildCell
	end

	buildCell:SetData(buildData)
	buildCell:SetSelect(false)

	if self.SelectBuildData and self.SelectBuildData.cid == buildData.cid then
		buildCell:SetSelect(true)
	end
end

function m:OnSelectCell(cell)
	self.SelectBuildData = self.BuildDataList[cell.index + 1]

	self:RefreshSelectBuild()
end

function m:UpdateView()
	self.BuildDataList = {}

	for i, v in pairs(AmusementParkModule.AmusementParkBuilds) do
		if not v:IsUnlock() then
			table.insert(self.BuildDataList, v)
		end
	end

	table.sort(self.BuildDataList, function(a, b)
		return a.cid < b.cid
	end)
	self.Empty1:SetActive(false)
	self.Empty2:SetActive(false)

	if #self.BuildDataList == 0 then
		local cfgControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]
		local mainBuildData = AmusementParkModule.GetAmusementParkBuildData(cfgControlData.MainBuildingId)

		if mainBuildData:IsMaxLevel() then
			self.Empty2:SetActive(true)
		else
			self.Empty1:SetActive(true)
		end
	end

	self.BuildScroll:GetComponent("ScrollAreaList"):Refresh(#self.BuildDataList)
	self:RefreshSelectBuild()
end

function m:RefreshSelectBuild()
	for i, v in pairs(self.BuildCellPool) do
		if self.SelectBuildData and self.SelectBuildData.cid == v.BuildData.cid then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	if self.SelectBuildData then
		self.RootUI.BuildPanelInfoView:Show(1, self.SelectBuildData)
	end
end

function m:Show()
	self.View:SetActive(true)

	self.SelectBuildData = nil

	self:UpdateView()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.BuildCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
