-- chunkname: @modules/logic/backpack/model/ItemMo.lua

module("modules.logic.backpack.model.ItemMo", package.seeall)

local ItemMo = pureTable("ItemMo")

function ItemMo:ctor()
	self.id = 0
	self.quantity = 0
	self.lastUseTime = 0
end

function ItemMo:init(info)
	self.id = info.itemId
	self.quantity = info.quantity
	self.lastUseTime = info.lastUseTime
	self.lastUpdateTime = info.lastUpdateTime
end

function ItemMo:initFromMaterialData(info)
	self.id = info.materilId
	self.quantity = info.quantity
	self.lastUseTime = nil
	self.lastUpdateTime = nil
end

return ItemMo
