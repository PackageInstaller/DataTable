-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerDistributionView.lua

local m = {
	ParkPlayers = {},
	ParkPlayerHeadCellPool = {},
	ParkBuilds = {},
	ParkPlayerBuildCellPool = {}
}
local AmusementParkPlayerHeadCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayerHeadCell")
local AmusementParkPlayerBuildCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerBuildCell")

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.RootUI = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ScrollBuild:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderBuildCell(cell)
	end
	self.ScrollBuild:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectBuildCell(cell)
	end
	self.ScrollSoul:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderSoulCell(cell)
	end
	self.ScrollSoul:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectSoulCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView(isRefreshPos)
	local num = 0
	local maxNum = 0

	self.ParkPlayers = {}

	for i, v in pairs(AmusementParkModule.AmusementParkPlayers) do
		if not v.parkRolePOD.status then
			table.insert(self.ParkPlayers, v)
		else
			num = num + 1
		end
	end

	table.sort(self.ParkPlayers, function(a, b)
		if a.parkRolePOD.level == b.parkRolePOD.level then
			return a.cid < b.cid
		end

		return a.parkRolePOD.level > b.parkRolePOD.level
	end)
	self.ScrollSoul:GetComponent("ScrollAreaList"):Refresh(#self.ParkPlayers)

	self.ParkBuilds = {}

	for i, v in pairs(AmusementParkModule.AmusementParkBuilds) do
		if v:IsUnlock() then
			table.insert(self.ParkBuilds, v)

			local tab, openCount = v:GetBuildPostData()

			maxNum = maxNum + openCount
		end
	end

	table.sort(self.ParkBuilds, function(a, b)
		return a.cid < b.cid
	end)

	local index = self:GetStartIndex()

	self.ScrollBuild:GetComponent("ScrollAreaList").startIndex = index - 1

	if isRefreshPos then
		self.ScrollBuild:GetComponent("ScrollAreaList"):Refresh(#self.ParkBuilds)
	else
		self.ScrollBuild:GetComponent("ScrollAreaList"):RenderCellsDynamic(#self.ParkBuilds)
	end

	UGUIUtil.SetText(self.TextSoulNum, AmusementParkPlayerUIApi:GetString("TextSoulNum", num, maxNum))
end

function m:GetStartIndex()
	for i = 1, #self.ParkBuilds do
		local buildData = self.ParkBuilds[i]

		if self.RootUI.SelectBuild and self.RootUI.SelectBuild == buildData.cid then
			return i
		end

		if self.SelectBuildData and self.SelectBuildData.cid == buildData.cid then
			return i
		end
	end

	return 1
end

function m:OnRenderBuildCell(cell)
	local buildData = self.ParkBuilds[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local parkPlayerBuildCell = self.ParkPlayerBuildCellPool[instanceID]

	if parkPlayerBuildCell == nil then
		parkPlayerBuildCell = AmusementParkPlayerBuildCell.New(cell.gameObject)
		self.ParkPlayerBuildCellPool[instanceID] = parkPlayerBuildCell
	end

	parkPlayerBuildCell:SetData(buildData)
	parkPlayerBuildCell:SetSelect(false)

	if self.SelectBuildData then
		if self.SelectBuildData.cid == buildData.cid then
			self.SelectBuildData = buildData
		end
	elseif self.RootUI.SelectBuild then
		if self.RootUI.SelectBuild == buildData.cid then
			self.SelectBuildData = buildData
		end
	else
		self.SelectBuildData = buildData
	end

	if self.SelectBuildData then
		parkPlayerBuildCell:SetSelect(self.SelectBuildData.cid == buildData.cid)
	end
end

function m:OnSelectBuildCell(cell)
	self.SelectBuildData = self.ParkBuilds[cell.index + 1]

	for i, v in pairs(self.ParkPlayerBuildCellPool) do
		v:SetSelect(v.BuildData.cid == self.SelectBuildData.cid)
	end
end

function m:OnRenderSoulCell(cell)
	local playerData = self.ParkPlayers[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local parkPlayerHeadCell = self.ParkPlayerHeadCellPool[instanceID]

	if parkPlayerHeadCell == nil then
		parkPlayerHeadCell = AmusementParkPlayerHeadCell.New(cell.gameObject)
		self.ParkPlayerHeadCellPool[instanceID] = parkPlayerHeadCell
	end

	parkPlayerHeadCell:IsUnlock(true)
	parkPlayerHeadCell:SetData(playerData)
end

function m:OnSelectSoulCell(cell)
	local playerData = self.ParkPlayers[cell.index + 1]

	if self.SelectBuildData then
		local buildPosDataList = self.SelectBuildData:GetBuildPostData()

		for i = 1, #buildPosDataList do
			local buildPosData = buildPosDataList[i]

			if buildPosData.unLock and buildPosData.playerData == nil then
				AmusementParkModule.RoleDeploy(self.SelectBuildData.parkBuildPOD.unitID, playerData.cid)

				break
			end
		end
	end
end

function m:Open()
	self.SelectBuildData = nil

	self.View:SetActive(true)
	self:UpdateView(true)
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ParkPlayerHeadCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.ParkPlayerBuildCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
