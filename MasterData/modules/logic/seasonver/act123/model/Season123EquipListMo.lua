-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipListMo.lua

local Season123EquipListMo = pureTable("Season123EquipListMo")

function Season123EquipListMo:ctor()
	return
end

function Season123EquipListMo:init(itemMO)
	self.id = itemMO.uid
	self.itemId = itemMO.itemId
	self.originMO = itemMO
end

return Season123EquipListMo
