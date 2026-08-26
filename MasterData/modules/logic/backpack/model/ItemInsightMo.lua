-- chunkname: @modules/logic/backpack/model/ItemInsightMo.lua

module("modules.logic.backpack.model.ItemInsightMo", package.seeall)

local ItemInsightMo = pureTable("ItemInsightMo")

function ItemInsightMo:ctor()
	self.insightId = 0
	self.uid = 0
	self.quantity = 0
	self.expireTime = 0
end

function ItemInsightMo:init(info)
	self.insightId = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

function ItemInsightMo:reset(info)
	self.insightId = tonumber(info.itemId)
	self.uid = tonumber(info.uid)
	self.quantity = tonumber(info.quantity)
	self.expireTime = info.expireTime
end

return ItemInsightMo
