-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerCultivateView.lua

local m = {
	ParkPlayers = {},
	ParkPlayerHeadCellPool = {}
}
local AmusementParkPlayerCultivateMsgView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerCultivateMsgView")
local AmusementParkPlayerHeadCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayerHeadCell")

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.RootUI = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.PlayerCultivateMsgView = AmusementParkPlayerCultivateMsgView.New(self.SelectSoul)
	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
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

function m:UpdateView(isRefreshPos)
	self.ParkPlayers = AmusementParkModule.AmusementParkPlayers

	self.EmptyNode:SetActive(#self.ParkPlayers == 0)
	table.sort(self.ParkPlayers, function(a, b)
		if a.parkRolePOD.level == b.parkRolePOD.level then
			return a.cid < b.cid
		else
			return a.parkRolePOD.level > b.parkRolePOD.level
		end
	end)

	if isRefreshPos then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.ParkPlayers)
	else
		for i, v in pairs(self.ParkPlayers) do
			if self.SelectPlayerData and self.SelectPlayerData.cid == v.cid then
				self.SelectPlayerData = v

				break
			end
		end

		self.ScrollArea:GetComponent("ScrollAreaList"):RenderCellsDynamic(#self.ParkPlayers)
	end

	self.PlayerCultivateMsgView:SetData(self.SelectPlayerData)
end

function m:OnRenderCell(cell)
	local playerData = self.ParkPlayers[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local parkPlayerHeadCell = self.ParkPlayerHeadCellPool[instanceID]

	if parkPlayerHeadCell == nil then
		parkPlayerHeadCell = AmusementParkPlayerHeadCell.New(cell.gameObject)

		parkPlayerHeadCell:IsUnlock(true)

		self.ParkPlayerHeadCellPool[instanceID] = parkPlayerHeadCell
	end

	parkPlayerHeadCell:SetData(playerData)

	if self.SelectPlayerData == nil then
		self.SelectPlayerData = playerData
	elseif self.SelectPlayerData.cid == playerData.cid then
		self.SelectPlayerData = playerData
	end

	parkPlayerHeadCell:SetSelect(self.SelectPlayerData.cid == playerData.cid)
end

function m:OnSelectCell(cell)
	self.SelectPlayerData = self.ParkPlayers[cell.index + 1]

	self.PlayerCultivateMsgView:SetData(self.SelectPlayerData)

	for i, v in pairs(self.ParkPlayerHeadCellPool) do
		v:SetSelect(self.SelectPlayerData.cid == v.ParkPlayerData.cid)
	end
end

function m:Open()
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

	self.PlayerCultivateMsgView:Dispose()

	self.PlayerCultivateMsgView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
