-- chunkname: @IQIGame\\UI\\ActivityList\\TreasureHuntActivity\\TreasureHuntActivityItemView.lua

local Item = {}

function Item.New(gameObject)
	local obj = Clone(Item)

	obj:__Init(gameObject)

	return obj
end

function Item:__Init(gameObject)
	self.view = gameObject

	LuaCodeInterface.BindOutlet(self.view, self)

	self.itemCell = ItemCell.New(self.ItemCellView, true, true, true)
	self.itemCell.showMoneyNum = true

	self.SelectView.gameObject:SetActive(false)
	self.CloseView.gameObject:SetActive(false)
end

function Item:Show(cfgCid, isClose)
	self.awardCid = cfgCid
	self.__isClose = isClose

	local cfg = CfgTreasureHuntActivityTable[cfgCid]

	self.itemCell:SetItemByCid(cfg.ItemId, cfg.ItemCount)
	self.SelectView.gameObject:SetActive(false)
	self.CloseView.gameObject:SetActive(isClose)
end

function Item:SetSelectShow(isSelect)
	if self.__isClose then
		return false
	end

	self.SelectView.gameObject:SetActive(isSelect)

	return true
end

function Item:Dispose()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return Item
