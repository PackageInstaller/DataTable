-- chunkname: @modules/logic/item/model/ItemTalentMO.lua

module("modules.logic.item.model.ItemTalentMO", package.seeall)

local ItemTalentMO = pureTable("ItemTalentMO")

function ItemTalentMO:ctor()
	self.uid = 0
	self.talentItemId = 0
	self.quantity = 0
	self.expireTime = 0
end

function ItemTalentMO:init(info)
	self.uid = tonumber(info.uid)
	self.talentItemId = tonumber(info.talentItemId)
	self.quantity = info.quantity
	self.expireTime = info.expireTime
end

function ItemTalentMO:reset(info)
	self:init(info)
end

return ItemTalentMO
