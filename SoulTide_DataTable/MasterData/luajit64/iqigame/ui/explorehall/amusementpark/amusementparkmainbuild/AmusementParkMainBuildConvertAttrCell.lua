-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildConvertAttrCell.lua

local m = {
	TransformRatio = {},
	TransAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkMainBuildTransAttrCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainBuild.AmusementParkMainBuildTransAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.ContentMould:SetActive(false)

	self.TransAttrCellPool = UIObjectPool.New(3, function()
		local cell = AmusementParkMainBuildTransAttrCell.New(UnityEngine.Object.Instantiate(self.ContentMould))

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

function m:UpdateView()
	local cfgAttrData = CfgAmusementParkAttributeTable[self.Attr]
	local path = UIGlobalApi.GetImagePath(cfgAttrData.ImageIcon)

	AssetUtil.LoadImage(self, path, self.TitleAttIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TitleAttName, cfgAttrData.AttName)

	for i, v in pairs(self.TransAttrCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.TransAttrCellPool:Release(v)
	end

	self.TransAttrCells = {}

	for i = 1, #self.TransformRatio, 2 do
		local attrID = self.TransformRatio[i]
		local attrValue = self.TransformRatio[i + 1]

		if attrID > 0 then
			local cell = self.TransAttrCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ContentNode.transform, false)
			cell:SetData(attrID, attrValue)
			table.insert(self.TransAttrCells, cell)
		end
	end
end

function m:SetData(attr, transformRatio)
	self.Attr = attr
	self.TransformRatio = transformRatio

	self:UpdateView()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.TransAttrCells) do
		self.TransAttrCellPool:Release(v)
	end

	self.TransAttrCells = {}

	self.TransAttrCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
