-- chunkname: @modules/logic/backpack/model/ItemPowerMo.lua

module("modules.logic.backpack.model.ItemPowerMo", package.seeall)

local ItemPowerMo = pureTable("ItemPowerMo")

function ItemPowerMo:ctor()
	self.id = 0
	self.uid = 0
	self.quantity = 0
	self.expireTime = 0
end

function ItemPowerMo:init(info)
	self.id = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

function ItemPowerMo:reset(info)
	self.id = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

return ItemPowerMo
