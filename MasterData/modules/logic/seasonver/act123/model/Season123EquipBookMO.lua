-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipBookMO.lua

local Season123EquipBookMO = pureTable("Season123EquipBookMO")

function Season123EquipBookMO:ctor()
	return
end

function Season123EquipBookMO:init(itemId)
	self.id = itemId
	self.count = 0
	self.isNew = false
end

function Season123EquipBookMO:setIsNew(isNew)
	self.isNew = isNew
end

return Season123EquipBookMO
