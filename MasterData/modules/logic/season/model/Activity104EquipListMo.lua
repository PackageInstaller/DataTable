-- chunkname: @modules/logic/season/model/Activity104EquipListMo.lua

local Activity104EquipListMo = pureTable("Activity104EquipListMo")

function Activity104EquipListMo:ctor()
	return
end

function Activity104EquipListMo:init(itemMO)
	self.id = itemMO.uid
	self.itemId = itemMO.itemId
	self.originMO = itemMO
end

return Activity104EquipListMo
