-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulListPageCell.lua

local m = {
	PageSouls = {},
	SoulListCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibrarySoulCell = require("IQIGame.UI.Library.LibrarySoulCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.SoulMould:SetActive(false)

	self.SoulListCellPool = UIObjectPool.New(16, function()
		return LibrarySoulCell.New(UnityEngine.Object.Instantiate(self.SoulMould))
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

function m:SetData(data)
	if self.PageSouls ~= data then
		self.PageSouls = data

		self:UpdateView()
	end
end

function m:UpdateView()
	for i, v in pairs(self.SoulListCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		self.SoulListCellPool:Release(v)
	end

	self.SoulListCells = {}

	for i = 1, #self.PageSouls do
		local soulData = self.PageSouls[i]
		local cell = self.SoulListCellPool:Obtain()

		cell.View.transform:SetParent(self.Grid.transform, false)
		cell.View:SetActive(true)
		cell:SetData(soulData)
		table.insert(self.SoulListCells, cell)
	end
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.SoulListCells) do
		self.SoulListCellPool:Release(v)
	end

	self.SoulListCells = {}

	self.SoulListCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
