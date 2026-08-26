-- chunkname: @modules/logic/season/model/Activity104EquipComposeMo.lua

local Activity104EquipComposeMo = pureTable("Activity104EquipComposeMo")

function Activity104EquipComposeMo:ctor()
	return
end

function Activity104EquipComposeMo:init(itemMO)
	self.id = itemMO.uid
	self.itemId = itemMO.itemId
	self.originMO = itemMO
end

return Activity104EquipComposeMo
