-- chunkname: @IQIGame\\UI\\Fishing\\FishCollectionSelectQualityView.lua

local m = {
	selectQualityCells = {}
}
local FishCollectionQualityCell = require("IQIGame.UI.Fishing.FishCollectionQualityCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.rootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)
	self.SortMould:SetActive(false)

	self.selectQualityCellPool = UIObjectPool.New(6, function()
		return FishCollectionQualityCell.New(UnityEngine.Object.Instantiate(self.SortMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	for i, v in pairs(self.selectQualityCells) do
		v.View.transform:SetParent(self.rootUI.UIController.transform, false)
		v.View:SetActive(false)
		self.selectQualityCellPool:Release(v)
	end

	self.selectQualityCells = {}

	local tabData = HomeLandFishCollectionUIApi:GetString("FishQuality")

	for i = 1, #tabData do
		local num = tabData[i]
		local cell = self.selectQualityCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.Sort.transform, false)
		cell:SetData(num)

		function cell.callBack(num)
			self:SelectCell(num)
		end

		table.insert(self.selectQualityCells, cell)
	end
end

function m:SelectCell(num)
	self.rootUI:SetSelectTog(num)
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	for i, v in pairs(self.selectQualityCells) do
		self.selectQualityCellPool:Release(v)
	end

	self.selectQualityCells = {}

	self.selectQualityCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
