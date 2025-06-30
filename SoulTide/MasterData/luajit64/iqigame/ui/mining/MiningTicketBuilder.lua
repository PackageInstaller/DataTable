-- chunkname: @IQIGame\\UI\\Mining\\MiningTicketBuilder.lua

local m = {
	miningTicketCells = {}
}
local MiningTicketCell = require("IQIGame.UI.Mining.MiningTicketCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.MinintTicketMould:SetActive(false)

	self.miningTicketPool = UIObjectPool.New(3, function()
		return MiningTicketCell.New(UnityEngine.Object.Instantiate(self.MinintTicketMould))
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

function m:RefreshMiningTicketView(itemIds)
	self.currencyCidList = itemIds

	for i, v in pairs(self.miningTicketCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.miningTicketPool:Release(v)
	end

	self.miningTicketCells = {}

	for i = 1, #self.currencyCidList do
		local itemCid = self.currencyCidList[i]
		local cell = self.miningTicketPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.View.transform, false)
		cell:RefreshData(itemCid)
		table.insert(self.miningTicketCells, cell)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.miningTicketCells) do
		self.miningTicketPool:Release(v)
	end

	self.miningTicketCells = {}

	self.miningTicketPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
