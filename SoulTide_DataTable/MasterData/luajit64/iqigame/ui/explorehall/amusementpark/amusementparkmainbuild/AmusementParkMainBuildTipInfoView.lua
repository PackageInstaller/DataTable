-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildTipInfoView.lua

local m = {
	ConvertAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkMainBuildConvertAttrCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildConvertAttrCell")

function m.New(view, RootUI)
	local obj = Clone(m)

	obj:Init(view, RootUI)

	return obj
end

function m:Init(view, RootUI)
	self.View = view
	self.RootUI = RootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.ConvertAttrMould:SetActive(false)

	self.ConvertAttrCellPool = UIObjectPool.New(5, function()
		local cell = AmusementParkMainBuildConvertAttrCell.New(UnityEngine.Object.Instantiate(self.ConvertAttrMould))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:UpdateView()
	for i, v in pairs(self.ConvertAttrCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.ConvertAttrCellPool:Release(v)
	end

	self.ConvertAttrCells = {}

	for i = 1, #self.parkBuildingLevelData.SoulAttType do
		local AttType = self.parkBuildingLevelData.SoulAttType[i]
		local TransformRatio = self.parkBuildingLevelData.TransformRatio[i]

		if AttType > 0 then
			local cell = self.ConvertAttrCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ConvertAttrGrid.transform, false)
			cell:SetData(AttType, TransformRatio)
			table.insert(self.ConvertAttrCells, cell)
		end
	end
end

function m:OnBtnClose()
	self:Hide()
end

function m:Show(parkBuildingLevelData)
	self.parkBuildingLevelData = parkBuildingLevelData

	self.View:SetActive(true)
	self:UpdateView()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ConvertAttrCells) do
		self.ConvertAttrCellPool:Release(v)
	end

	self.ConvertAttrCells = {}

	self.ConvertAttrCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
