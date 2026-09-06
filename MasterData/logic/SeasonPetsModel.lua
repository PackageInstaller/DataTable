-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonPetsModel.lua

module("logic.extensions.season.model.SeasonPetsModel", package.seeall)

local SeasonPetsModel = class("SeasonPetsModel", BaseModel)

function SeasonPetsModel:ctor()
	return
end

function SeasonPetsModel:onInit()
	self:onReset()
end

function SeasonPetsModel:onReset()
	self._seasonBagPetList = {}
	self.infos = nil
	self.petdefineids = nil
	self.day = 0
	self.leftTimes = 0
	self.maxTimes = 0
end

function SeasonPetsModel:onSetAllPetInfo(msg)
	self._seasonBagPetList = {}

	local petInfos = msg.petInfos

	for i, info in ipairs(petInfos or {}) do
		local mo = SeasonPetsModel.instance:createHirePetMo(info.petDefineId)

		if mo then
			mo.petId = info.petId

			table.insert(self._seasonBagPetList, mo)
		end
	end

	local petIds = msg.petIds

	for i, petId in ipairs(petIds or {}) do
		local mo = SeasonPetsModel.instance:createPetMoById(petId)

		if mo then
			table.insert(self._seasonBagPetList, mo)
		end
	end
end

function SeasonPetsModel:getSeasonBagPetList()
	return self._seasonBagPetList or {}
end

function SeasonPetsModel:onUpdateAllHirePetList(msg)
	self.petdefineids = msg.petDefineIds
	self.maxTimes = msg.maxTimes

	self:onUpdateMyHirePetList(msg)
end

function SeasonPetsModel:onUpdateMyHirePetList(msg)
	local infos = msg.infos

	self.infos = GameUtil.pbToTable(infos)
	self.day = msg.day
	self.leftTimes = msg.leftTimes
end

function SeasonPetsModel:createHirePetMo(petDefineId)
	local spPetCo = SeasonConfig.instance:getHirePetCfgById(petDefineId)

	if spPetCo then
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(spPetCo)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.isHirePet = true

		return petMo
	end
end

function SeasonPetsModel:createPetMoById(petId)
	local petMo = BagModel.instance:getBagPetById(petId)

	if petMo then
		local mo = petMo:GetClone()

		mo.level = 100
		mo.talentLevel = 0
		mo.summonMasterId = 0
		mo.summonedPetId = 0
		mo.carriedMasterId = 0
		mo.carriedPetId = 0
		mo.oracleMasterId = 0
		mo.oraclePetId = 0
		mo.oraclePetRaceId = 0
		mo.formStrength = nil
		mo.bookSpiritPetId = 0
		mo.bookSpiritRaceId = 0
		mo.contractSkillId = 0
		mo.isMyPackPet = false

		return mo
	end

	return nil
end

function SeasonPetsModel:calcPetAttr(mo, teamMo)
	local petMo = BagModel.instance:getBagPetById(mo.petId)

	if petMo and teamMo then
		mo.attrMo:resetPrivateAttr()
		mo.attrMo:resetPublicAttr()

		mo.activedOnFormRelationIds = petMo.activedOnFormRelationIds

		local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, petMo.curFaceId)

		mo.attrMo.baseAttr = mo.attrMo:getBaseAttr(skinCfg.propertyStrategyId, 100)
		mo.equipments = self:getOriginEquipment(petMo)
		mo.attrMo.equipAttr = mo.attrMo:getEquipmentAttr(mo)
		mo.attrMo.mountAttr = MountModel.instance:getMountAttr()

		mo.attrMo:calcTotalAttrs(true)

		local res = 1
		local petCo = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
		local awakenScfg = CharacterConfig.instance:getPetAwakenCostCfg(petCo.awakenCostStrategyId, mo.awakeLevel)

		if awakenScfg then
			res = res + checknumber(awakenScfg.allPropertyWanPercent) / 10000
		end

		for k, v in pairs(mo.attrMo.totalAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour then
				mo.attrMo.totalAttr[k] = (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) and v * res or v
			end
		end
	end

	if mo.isHirePet then
		mo.attrMo.isCalcAttr = false
		mo.attrMo.isCalcPower = false
		mo.attrMo.totalAttr = {}
		mo.attrMo.totalAttr = AttrMo.addSameAttrs(mo.attrMo.extAttr, mo.attrMo.totalAttr)
	end

	local totemPoleRes = SeasonTeamsModel.instance:getRaceTypeAttr(mo)

	mo.attrMo.totalAttr = AttrMo.addSameAttrs(totemPoleRes, mo.attrMo.totalAttr)

	local badgeRes = SeasonTeamsModel.instance:getBadgeAttr(mo)

	mo.attrMo.totalAttr = AttrMo.addSameAttrs(badgeRes, mo.attrMo.totalAttr)

	if teamMo then
		local trainRes = teamMo:getCurrTeamTrainingAttrs()

		mo.attrMo.totalAttr = AttrMo.addSameAttrs(trainRes, mo.attrMo.totalAttr)

		local holySpRes = teamMo:getCurrHolySpriteAttrs(mo)

		mo.attrMo.totalAttr = AttrMo.addSameAttrs(holySpRes, mo.attrMo.totalAttr)

		local cutePetRes = teamMo:getCurrCutePetAttrs(mo)

		mo.attrMo.totalAttr = AttrMo.addSameAttrs(cutePetRes, mo.attrMo.totalAttr)
	end

	mo:refreshAllAttr()

	local holyZdlPer = 0
	local cutePetZdlPer = 0
	local totemPoleZdlWanPercent = SeasonTeamsModel.instance:getRaceZdlWanPercent(mo)

	if teamMo then
		holyZdlPer = teamMo:getCurrHolySpriteZdlWanPercent(mo)
		cutePetZdlPer = teamMo:getCurrCutePetZdlWanPercent(mo)
	end

	mo._zdl = mo._zdl * (1 + totemPoleZdlWanPercent / 10000 + holyZdlPer / 10000 + cutePetZdlPer / 10000)
	mo._zdl = math.round(mo._zdl)

	return mo
end

function SeasonPetsModel:getOriginEquipment(petMo)
	local equipments = {}

	for k, tem in pairs(petMo.equipments) do
		local positionId = tem.positionId
		local id = tem.id
		local cfgId = checknumber(tem.defineId)
		local lvl = checknumber(tem.lv)
		local bonusRaceId = checknumber(tem.bonusRaceId)
		local equip

		if checknumber(id) > 0 then
			equip = PetEquipModel.instance:GetEquipInfo(id)
			lvl = equip.starCount
			cfgId = equip:getDefineId()

			if bonusRaceId <= 0 then
				bonusRaceId = checknumber(equip.exclRaceId)
			end
		end

		local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)

		if checknumber(cfg.throneRelatedSkinId) > 0 then
			local obj = {}

			obj.positionId = positionId
			obj.id = id
			obj.defineId = cfgId
			obj.lv = lvl
			obj.bonusRaceId = bonusRaceId

			table.insert(equipments, obj)
		end
	end
end

SeasonPetsModel.instance = SeasonPetsModel.New()

return SeasonPetsModel
