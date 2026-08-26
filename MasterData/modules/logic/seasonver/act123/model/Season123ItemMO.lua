-- chunkname: @modules/logic/seasonver/act123/model/Season123ItemMO.lua

local Season123ItemMO = pureTable("Season123ItemMO")

function Season123ItemMO:ctor()
	self.id = 0
	self.uid = 0
	self.itemId = 0
	self.quantity = 0
end

function Season123ItemMO:setData(info)
	self.id = info.uid
	self.uid = info.uid
	self.itemId = info.itemId
	self.quantity = info.quantity
end

function Season123ItemMO:reset(info)
	self.id = info.uid
	self.uid = info.uid
	self.itemId = info.itemId
	self.quantity = info.quantity
end

return Season123ItemMO
