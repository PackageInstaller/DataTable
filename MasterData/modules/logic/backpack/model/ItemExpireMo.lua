-- chunkname: @modules/logic/backpack/model/ItemExpireMo.lua

module("modules.logic.backpack.model.ItemExpireMo", package.seeall)

local ItemExpireMo = pureTable("ItemExpireMo")

function ItemExpireMo:ctor()
	self.expireId = 0
	self.uid = 0
	self.quantity = 0
	self.expireTime = 0
end

function ItemExpireMo:init(info)
	self.expireId = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

function ItemExpireMo:reset(info)
	self.expireId = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

return ItemExpireMo
