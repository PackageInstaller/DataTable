-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyItemListMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyItemListMo", package.seeall)

local OdysseyItemListMo = pureTable("OdysseyItemListMo")

function OdysseyItemListMo:init(mo, type, isEquip)
	self.itemId = mo.id
	self.uid = mo.uid
	self.itemMo = mo
	self.type = type
	self.isEquip = isEquip or false
end

return OdysseyItemListMo
