-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerBuildCell.lua

local m = {
	ParkAttrCells = {},
	ParkBuildPosCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkAttrCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkAttrCell")
local AmusementParkPlayerHeadCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayerHeadCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.BuildAttrMould:SetActive(false)

	self.ParkAttrCellPool = UIObjectPool.New(6, function()
		return AmusementParkAttrCell.New(UnityEngine.Object.Instantiate(self.BuildAttrMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.BuildWorkMould:SetActive(false)

	self.ParkBuildPosCellPool = UIObjectPool.New(6, function()
		local cell = AmusementParkPlayerHeadCell.New(UnityEngine.Object.Instantiate(self.BuildWorkMould))

		function cell.ClickCallBack(parkPlayerData, buildID)
			self:OnClickBuildPosCell(parkPlayerData, buildID)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(buildData)
	self.BuildData = buildData

	self:UpdateView()
end

function m:UpdateView()
	if self.BuildData then
		local path = UIGlobalApi.GetImagePath(self.BuildData:GetCfgData().Icon)

		AssetUtil.LoadImage(self, path, self.BuildIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.BuildName, self.BuildData:GetCfgData().Name)
		UGUIUtil.SetText(self.TextBuildLv, self.BuildData.parkBuildPOD.level)

		local UIController = self.View:GetComponentInParent(typeof(UIController))

		for i, v in pairs(self.ParkAttrCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(UIController.transform, false)
			self.ParkAttrCellPool:Release(v)
		end

		self.ParkAttrCells = {}

		local attrs = self.BuildData:GetBuildPlayerAttrs()
		local cfgBuildingLevelData = self.BuildData:GetCfgBuildLevelData()

		for i = 1, #cfgBuildingLevelData.SoulAttType do
			local id = cfgBuildingLevelData.SoulAttType[i]

			if id > 0 then
				local value = attrs[id] or 0
				local cell = self.ParkAttrCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.BuildAttrNode.transform, false)
				cell:SetData(id, value)
				table.insert(self.ParkAttrCells, cell)
			end
		end

		for i, v in pairs(self.ParkBuildPosCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(UIController.transform, false)
			self.ParkBuildPosCellPool:Release(v)
		end

		self.ParkBuildPosCells = {}

		local buildPosDataList = self.BuildData:GetBuildPostData()

		for i, v in pairs(buildPosDataList) do
			local cell = self.ParkBuildPosCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.BuildWorks.transform, false)
			cell:IsUnlock(v.unLock)
			cell:SetUnlockLv(v.unlockLv)

			cell.View.name = v.pos

			cell:SetData(v.playerData, self.BuildData.cid)
			table.insert(self.ParkBuildPosCells, cell)
		end
	end
end

function m:OnClickBuildPosCell(parkPlayerData, buildID)
	if parkPlayerData and parkPlayerData.parkRolePOD.status then
		AmusementParkModule.RoleUnDeploy(self.BuildData.cid, parkPlayerData.cid)
	end
end

function m:SetSelect(top)
	self.SelectNode:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ParkAttrCells) do
		self.ParkAttrCellPool:Release(v)
	end

	self.ParkAttrCells = {}

	self.ParkAttrCellPool:Dispose()

	for i, v in pairs(self.ParkBuildPosCells) do
		self.ParkBuildPosCellPool:Release(v)
	end

	self.ParkBuildPosCells = {}

	self.ParkBuildPosCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
