-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyEquipSuitMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyEquipSuitMo", package.seeall)

local OdysseyEquipSuitMo = pureTable("OdysseyEquipSuitMo")

function OdysseyEquipSuitMo:init(suitId, config, type)
	self.suitId = suitId
	self.config = config
	self.type = type
end

return OdysseyEquipSuitMo
