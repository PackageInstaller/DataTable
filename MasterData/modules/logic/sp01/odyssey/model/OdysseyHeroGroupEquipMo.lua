-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyHeroGroupEquipMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupEquipMo", package.seeall)

local OdysseyHeroGroupEquipMo = pureTable("OdysseyHeroGroupEquipMo")

function OdysseyHeroGroupEquipMo:init(info)
	self.index = info.position - 1
	self.equipUid = {}

	local mainHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local mainCountConstCo = info and info.trialId and info.trialId > 0 and info.trialId == tonumber(mainHeroConstCo.value) and OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount) or OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.NormalHeroEquipCount)

	for i = 1, tonumber(mainCountConstCo.value) do
		table.insert(self.equipUid, "0")
	end

	if not info.equips then
		return
	end

	for i, v in ipairs(info.equips) do
		self.equipUid[v.slotId] = v.equipUid
	end
end

function OdysseyHeroGroupEquipMo:getEquipUID(slot)
	if not self.equipUid then
		return nil
	end

	return self.equipUid[slot]
end

return OdysseyHeroGroupEquipMo
