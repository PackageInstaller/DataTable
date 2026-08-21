-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailBuildCell.lua

local m = {
	ParkDetailBuildSoulCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkDetailBuildSoulCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailBuildSoulCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.SoulMould:SetActive(false)

	self.ParkDetailBuildSoulCellPool = UIObjectPool.New(10, function()
		return AmusementParkDetailBuildSoulCell.New(UnityEngine.Object.Instantiate(self.SoulMould))
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

function m:SetData(buildAreaData)
	self.BuildAreaData = buildAreaData

	self:Refresh()
end

function m:Refresh()
	self.View:SetActive(false)
	self.View.transform.parent.gameObject:SetActive(false)

	for i, v in pairs(self.ParkDetailBuildSoulCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		self.ParkDetailBuildSoulCellPool:Release(v)
	end

	self.ParkDetailBuildSoulCells = {}

	if self.BuildAreaData then
		local isOpen = self.BuildAreaData:IsOpen()

		self.View:SetActive(isOpen)
		self.View.transform.parent.gameObject:SetActive(isOpen)

		local buildData = self.BuildAreaData:GetAreaBuildData()

		self.Empty:SetActive(buildData == nil)
		self.Normal:SetActive(buildData ~= nil)
		self.ImgIcon:SetActive(buildData ~= nil)
		self.MaxLevelTag:SetActive(false)
		self.LevelTag:SetActive(false)
		self.Level:SetActive(true)

		if buildData ~= nil then
			local path = UIGlobalApi.GetImagePath(buildData:GetCfgData().Icon)

			AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

			local isMaxLv = buildData:IsMaxLevel()

			self.MaxLevelTag:SetActive(isMaxLv)
			self.Level:SetActive(not isMaxLv)

			local canLevelUp = buildData:IsCanLevelUp()

			self.LevelTag:SetActive(canLevelUp)

			local souls = buildData:GetBuildPlayers()

			for i, v in pairs(souls) do
				local render = self.ParkDetailBuildSoulCellPool:Obtain()

				render.View:SetActive(true)
				render.View.transform:SetParent(self.Souls.transform, false)
				render:SetData(v)
				table.insert(self.ParkDetailBuildSoulCells, render)
			end

			UGUIUtil.SetText(self.TextLevel, buildData.parkBuildPOD.level)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ParkDetailBuildSoulCells) do
		self.ParkDetailBuildSoulCellPool:Release(v)
	end

	self.ParkDetailBuildSoulCells = {}

	self.ParkDetailBuildSoulCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
