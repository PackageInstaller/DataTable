-- chunkname: @modules/logic/equip/model/CharacterEquipMO.lua

module("modules.logic.equip.model.CharacterEquipMO", package.seeall)

local CharacterEquipMO = class("CharacterEquipMO", EquipMO)

function CharacterEquipMO:setTempMo(equipId)
	self.equipId = equipId
	self.config = EquipConfig.instance:getEquipCo(equipId)
	self.id = -1 * equipId
	self.uid = self.id
	self.level = 1
	self.exp = 1
	self.breakLv = 0
	self.count = 1
	self.refineLv = 1
	self.isLock = false
	self.equipType = EquipEnum.ClientEquipType.RecommedNot
end

return CharacterEquipMO
