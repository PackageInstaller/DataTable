-- chunkname: @IQIGame\\UI\\Tips\\GiftTipContent.lua

local GiftTipContent = {
	cellPool = {},
	cfgItemDatum = {},
	itemCounts = {}
}
local GiftTipContentCell = require("IQIGame.UI.Tips.GiftTipContentCell")

function GiftTipContent.New(scrollAreaList)
	local o = Clone(GiftTipContent)

	o:Initialize(scrollAreaList)

	return o
end

function GiftTipContent:Initialize(scrollAreaList)
	self.scrollList = scrollAreaList

	function self.scrollList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end
end

function GiftTipContent:RefreshView(itemData, goItemSlot)
	self.goItemSlot = goItemSlot

	self:RefreshDatum(itemData)
	self:RefreshMisc()
end

function GiftTipContent:RefreshDatum(itemData)
	if itemData.classType ~= "ItemData" then
		itemData = ItemData.CreateByCIDAndNumber(itemData.Id, 1)
	end

	self.cfgItemDatum = {}
	self.itemCounts = {}

	for i, v in pairsCfg(CfgMallTable) do
		if v.Item == itemData.cid then
			for j, k in ipairs(v.ShowItem) do
				if j % 2 ~= 0 then
					self.cfgItemDatum[#self.cfgItemDatum + 1] = CfgItemTable[k]
				else
					self.itemCounts[#self.itemCounts + 1] = k
				end
			end

			break
		end
	end
end

function GiftTipContent:RefreshMisc()
	self.scrollList:Refresh(#self.cfgItemDatum)
end

function GiftTipContent:OnRenderGridCell(gridCell)
	local luaIndex = gridCell.index + 1
	local data = self.cfgItemDatum[luaIndex]
	local count = self.itemCounts[luaIndex]
	local insID = gridCell.gameObject:GetInstanceID()
	local cell = self.cellPool[insID]

	if cell == nil then
		local goClone = UnityEngine.Object.Instantiate(self.goItemSlot)

		cell = GiftTipContentCell.New(gridCell.gameObject, goClone)
		self.cellPool[insID] = cell
	end

	cell:RefreshView(data, count)
end

function GiftTipContent:Dispose()
	for i, v in pairs(self.cellPool) do
		self.cellPool[i]:Dispose()
	end
end

return GiftTipContent
