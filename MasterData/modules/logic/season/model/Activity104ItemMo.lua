-- chunkname: @modules/logic/season/model/Activity104ItemMo.lua

local Activity104ItemMo = pureTable("Activity104ItemMo")

function Activity104ItemMo:ctor()
	self.uid = 0
	self.itemId = 0
	self.quantity = 0
end

function Activity104ItemMo:init(info)
	self.uid = info.uid
	self.itemId = info.itemId
	self.quantity = info.quantity
end

function Activity104ItemMo:reset(info)
	self.uid = info.uid
	self.itemId = info.itemId
	self.quantity = info.quantity
end

return Activity104ItemMo
