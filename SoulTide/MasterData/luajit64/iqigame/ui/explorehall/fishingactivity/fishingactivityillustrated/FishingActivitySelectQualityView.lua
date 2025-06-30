-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityIllustrated\\FishingActivitySelectQualityView.lua

local m = {
	SelectQualityCells = {}
}
local FishingActivitySelectQualityCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityIllustrated.FishingActivitySelectQualityCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.RootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)
	self.SortMould:SetActive(false)

	self.SelectQualityCellPool = UIObjectPool.New(6, function()
		return FishingActivitySelectQualityCell.New(UnityEngine.Object.Instantiate(self.SortMould))
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
	for i, v in pairs(self.SelectQualityCells) do
		v.View.transform:SetParent(self.RootUI.UIController.transform, false)
		v.View:SetActive(false)
		self.SelectQualityCellPool:Release(v)
	end

	self.SelectQualityCells = {}

	local tabData = FishingActivityIllustratedUIApi:GetString("FishQuality")

	for i = 1, #tabData do
		local num = tabData[i]
		local cell = self.SelectQualityCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.Sort.transform, false)
		cell:SetData(num)

		function cell.CallBack(num)
			self:SelectCell(num)
		end

		table.insert(self.SelectQualityCells, cell)
	end
end

function m:SelectCell(num)
	self.RootUI:SetSelectTog(num)
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
	for i, v in pairs(self.SelectQualityCells) do
		self.SelectQualityCellPool:Release(v)
	end

	self.SelectQualityCells = {}

	self.SelectQualityCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
