-- chunkname: @modules/logic/season/model/Activity104EquipBookMo.lua

local Activity104EquipBookMo = pureTable("Activity104EquipBookMo")

function Activity104EquipBookMo:ctor()
	return
end

function Activity104EquipBookMo:init(itemId)
	self.id = itemId
	self.count = 0
	self.isNew = false
end

function Activity104EquipBookMo:setIsNew(isNew)
	self.isNew = isNew
end

return Activity104EquipBookMo
