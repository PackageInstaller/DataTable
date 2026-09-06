-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/fightingpower/FightingPowerPetMo.lua

module("logic.extensions.fightingpower.FightingPowerPetMo", package.seeall)

local FightingPowerPetMo = class("FightingPowerPetMo")

function FightingPowerPetMo:ctor(raceId, level)
	self.petId = -1
	self.raceId = raceId
	self.curFaceId = raceId
	self.level = level
	self._speed = 0
	self.awakeLevel = 0
	self.talentLevel = 0
	self.summonMasterId = 0
	self.summonedPetId = 0
	self.isSupportedPet = nil
	self.isHirePet = nil
	self.supportedFightingPower = nil
	self.status = 0
	self.runeSuit = {}
	self.equipments = {}
	self.holyStripes = {}
	self.decoration = nil
	self.hoshigamis = {}
	self.throneList = {}
	self.goodFeelingInfos = {}
	self.assistTeamInfoList = {}
	self.benefitInfoList = {}
	self.teamInfo = {}
	self.mountInfo = {}
	self.collectRelationIds = {}
	self.starGodPlusSlots = {}
	self.formStrength = {}
	self.onlyUseExtProperties = false
	self.allPropertyExtZdl = 0
	self.allPropertyExtZdlRate = 0
	self.usePublicStrengthsFlag = false
	self.extpropertiesArr = {}
	self.zooAnimalFollowGeneIds = {}
	self.contractSkillId = 0
	self.normalSkillLv = 1
	self.ultimateSkillLv = 1
	self.passiveSkillLv = 1
	self.psychicedUltimateSkillLv = 1
	self.psychicedNormalSkillLv = 1
	self.carriedMasterId = 0
	self.carriedPetId = 0
	self.oracleMasterId = 0
	self.oraclePetId = 0
	self.oraclePetRaceId = 0
	self.heavenAwakenMasterId = 0
	self.heavenAwakenSummonPetId = 0
	self.isHeavenAwakenSummonedCharacter = false
	self.bookSpiritPetId = 0
	self.bookSpiritRaceId = 0
	self.sourceTraces = {}
	self.isMyPackPet = false
	self.activedOnFormRelationIds = nil
	self.cutePetShelter = {}
	self.attrMo = AttrMo.New()
end

function FightingPowerPetMo:getName()
	if string.nilorempty(self.name) then
		self.name = PetSkinConfig.instance:getPetSkinName(self.curFaceId)
	end

	return self.name
end

function FightingPowerPetMo:getStarGodPlusSlots()
	return self.starGodPlusSlots
end

function FightingPowerPetMo:calcAllAttr()
	if self.onlyUseExtProperties then
		self.attrMo:calcExtAttrs(self)
	else
		self.attrMo:calcBaseAttrs(self, true)
		self.attrMo:calcSourceTraceAttr(self, true)
		self.attrMo:calcEquipmentAttr(self, true)
		self.attrMo:calcMountAttr(self, true)
		self.attrMo:calcRuneAttr(self, true)
		self.attrMo:calcPetThroneAttr(self, true)
		self.attrMo:calcPetHandbookAttr(self, true)
		self.attrMo:calcAnimalAttr(self, true)
		self.attrMo:calcAssistAttr(self, true)
		self.attrMo:calcPetGoodfellingAttr(self, true)
		self.attrMo:calcPetHoshigamiAttr(self, true)
		self.attrMo:calcDecorationAttr(self, true)
		self.attrMo:calcPetTeamAttr(self, true)
		self.attrMo:calcPetRelationAttr(self, true)
		self.attrMo:calcStarGodPlusAttr(self, true)
		self.attrMo:calcHolyStripesAttr(self, true)
		self.attrMo:calcFormStrengthAttr(self, true)
		self.attrMo:calcCutePetAttr(self, true)
		self.attrMo:calcTotalAttrs()
	end

	self:refreshAllAttr()

	self.rare = CharacterConfig.instance:getRareByAwakenLv(self.awakeLevel, self.raceId)
end

function FightingPowerPetMo:refreshAllAttr()
	self.attrMo:calcFinalAttr()

	self._maxHp = self.attrMo._maxHp
	self._attack = self.attrMo._attack
	self._physicalAttack = self.attrMo._physicalAttack
	self._physicalDefence = self.attrMo._physicalDefence
	self._magicAttack = self.attrMo._magicAttack
	self._magicDefence = self.attrMo._magicDefence
	self._ultimateAttack = self.attrMo._ultimateAttack
	self._ultimateDefence = self.attrMo._ultimateDefence
	self._speed = self.attrMo._speed
	self._hitRate = self.attrMo._hitRate
	self._dodgeRate = self.attrMo._dodgeRate
	self._strikeRate = self.attrMo._strikeRate
	self._blockRate = self.attrMo._blockRate
	self._criticalRate = self.attrMo._criticalRate
	self._antiCriticalRate = self.attrMo._antiCriticalRate
	self._originalVigourRate = self.attrMo._originalVigourRate

	self.attrMo:calcFightPower(self.onlyUseExtProperties)

	self._zdl = self.attrMo._zdl
end

function FightingPowerPetMo.fromBasePetView(baseView, teams, posId)
	local bagPet = BagPetMo.New()

	bagPet:initBaseView(baseView)

	local mo = bagPet:toFightingPowerPetMo(teams)

	mo.position = posId

	return mo
end

function FightingPowerPetMo:getMatType()
	return MatType.Pet
end

function FightingPowerPetMo:getDefineId()
	return self.raceId
end

function FightingPowerPetMo:isSummonedPet()
	return self.summonMasterId > 0 or checknumber(self.contractSkillId) > 0
end

function FightingPowerPetMo:isSummonedMaster()
	if self._isSummonMaster == nil then
		self._isSummonMaster = PetSkinConfig.instance:checkHasJob(self.curFaceId, GameEnum.JobZhDefine.Zhaohuanshi)
	end

	return self._isSummonMaster
end

function FightingPowerPetMo:fromChallengeCreepCo(creepCo, creeps)
	self.raceId = creepCo.raceId
	self.petId = checknumber(creepCo.creepsId)
	self.level = checknumber(creepCo.lv)

	if creepCo.creepLevel and type(creepCo.creepLevel) == "table" then
		self.level = checknumber(creepCo.creepLevel[1])
	end

	self.curFaceId = checknumber(creepCo.faceId)

	if checknumber(self.curFaceId) == 0 then
		self.curFaceId = checknumber(self.raceId)
	end

	self:setAttrMo()

	self.talentLevel = creepCo.talentLv
	self.awakenLv = self:getAwakenLv(self.raceId, creepCo.awakenLv)
	self.awakeLevel = self.awakenLv

	self:parsEequipments(creepCo.equipment)

	self.holyStripes = self:parseHolyStripeAttrs(creepCo.holyStripes)
	self.cutePetShelter = self:parseCutePetAttrs(creepCo.cutePetShelter)

	self:parseRuneSuitValue(creepCo.runeSuitSeq)

	self.summonMasterId = checknumber(creepCo.summonMasterId)
	self.summonedPetId = checknumber(creepCo.summonedPetId)
	self.carriedMasterId = checknumber(creepCo.carriedMasterId)
	self.carriedPetId = checknumber(creepCo.carriedPetId)
	self.heavenAwakenMasterId = checknumber(creepCo.heavenAwakenMasterId)
	self.heavenAwakenSummonPetId = checknumber(creepCo.heavenAwakenSummonPetId)
	self.oracleMasterId = checknumber(creepCo.oracleMasterId)
	self.oraclePetId = checknumber(creepCo.oraclePetId)
	self.oraclePetRaceId = checknumber(creepCo.oraclePetRaceId)
	self.position = creepCo.posId
	self.contractSkillId = checknumber(creepCo.contractSkillId)
	self.onlyUseExtProperties = checkbool(creepCo.onlyUseExtProperties)
	self.extpropertiesArr = FightingPowerFormula.instance:parseAttrValues(creepCo.extproperties) or {}
	self.bookSpiritPetId = checknumber(creepCo.bookSpiritPetId)
	self.bookSpiritRaceId = checknumber(creepCo.bookSpiritRaceId)

	local petCfg = CharacterConfig.instance:getPetCo(self.raceId)

	if checknumber(petCfg.sourceTraceId) > 0 then
		local defaultNodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(petCfg.sourceTraceId, SourceTraceController.DEFAULT_ACTIVE_NODE_ID)
		local hasDefalult = false

		for i, v in ipairs(self.sourceTraces) do
			if v.nodeId == defaultNodeCfg.nodeId then
				hasDefalult = true

				break
			end
		end

		if not hasDefalult then
			table.insert(self.sourceTraces, {
				nodeId = defaultNodeCfg.nodeId,
				effectId = defaultNodeCfg.effectIds[1]
			})
		end
	end

	self:calcAllAttr()

	if checknumber(creepCo.powerCheat) > 0 then
		self._zdl = self._zdl * checknumber(creepCo.powerCheat)
		self._zdl = math.round(self._zdl)
	end
end

function FightingPowerPetMo:fromTaskCreepCo(creepCo, creeps)
	self.raceId = creepCo.raceId
	self.petId = checknumber(creepCo.creepsId)
	self.level = creepCo.lv
	self.curFaceId = checknumber(creepCo.faceId)

	if checknumber(self.curFaceId) == 0 then
		self.curFaceId = checknumber(self.raceId)
	end

	self:setAttrMo()

	self.talentLevel = creepCo.talentLv
	self.awakenLv = self:getAwakenLv(self.raceId, creepCo.awakenLv)
	self.awakeLevel = self.awakenLv

	self:parsEequipments(creepCo.equipment)

	self.holyStripes = self:parseHolyStripeAttrs(creepCo.holyStripes)
	self.cutePetShelter = self:parseCutePetAttrs(creepCo.cutePetShelter)

	self:parseRuneSuitValue(creepCo.runeSuitSeq)

	self.summonMasterId = checknumber(creepCo.summonMasterId)
	self.summonedPetId = checknumber(creepCo.summonedPetId)
	self.carriedMasterId = checknumber(creepCo.carriedMasterId)
	self.carriedPetId = checknumber(creepCo.carriedPetId)
	self.oracleMasterId = checknumber(creepCo.oracleMasterId)
	self.oraclePetId = checknumber(creepCo.oraclePetId)
	self.oraclePetRaceId = checknumber(creepCo.oraclePetRaceId)
	self.heavenAwakenMasterId = checknumber(creepCo.heavenAwakenMasterId)
	self.heavenAwakenSummonPetId = checknumber(creepCo.heavenAwakenSummonPetId)
	self.position = creepCo.posId
	self.contractSkillId = checknumber(creepCo.contractSkillId)
	self.onlyUseExtProperties = checkbool(creepCo.onlyUseExtProperties)
	self.extpropertiesArr = FightingPowerFormula.instance:parseAttrValues(creepCo.extproperties) or {}
	self.bookSpiritPetId = checknumber(creepCo.bookSpiritPetId)
	self.bookSpiritRaceId = checknumber(creepCo.bookSpiritRaceId)

	local petCfg = CharacterConfig.instance:getPetCo(self.raceId)

	if checknumber(petCfg.sourceTraceId) > 0 then
		local defaultNodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(petCfg.sourceTraceId, SourceTraceController.DEFAULT_ACTIVE_NODE_ID)
		local hasDefalult = false

		for i, v in ipairs(self.sourceTraces) do
			if v.nodeId == defaultNodeCfg.nodeId then
				hasDefalult = true

				break
			end
		end

		if not hasDefalult then
			table.insert(self.sourceTraces, {
				nodeId = defaultNodeCfg.nodeId,
				effectId = defaultNodeCfg.effectIds[1]
			})
		end
	end

	self:calcAllAttr()

	if checknumber(creepCo.powerCheat) > 0 then
		self._zdl = self._zdl * checknumber(creepCo.powerCheat)
		self._zdl = math.round(self._zdl)
	end
end

function FightingPowerPetMo:fromXinxiyaCreepCo(creepInfo, pos)
	self.raceId = creepInfo.raceId
	self.petId = creepInfo.petId
	self.level = creepInfo.curLv
	self.curFaceId = checknumber(creepInfo.curFaceId)

	if checknumber(self.curFaceId) == 0 then
		self.curFaceId = checknumber(self.raceId)
	end

	self:setAttrMo()

	self.talentLevel = creepInfo.talentLevel
	self.awakenLv = self:getAwakenLv(self.raceId, creepInfo.awakenLv)
	self.awakeLevel = self.awakenLv
	self.equipments = {}

	for _, info in pairs(creepInfo.equipments or {}) do
		if info and checknumber(info.defineId) > 0 then
			table.insert(self.equipments, info)
		end
	end

	self.holyStripes = self:parseHolyStripeAttrs(creepInfo.holyStripes)
	self.cutePetShelter = self:parseCutePetAttrs(creepInfo.cutePetShelter)

	self:parseRuneSuitValue(creepInfo.runeSuitSeq)

	self.summonMasterId = checknumber(creepInfo.summonMasterId)
	self.summonedPetId = checknumber(creepInfo.summonedPetId)
	self.carriedMasterId = checknumber(creepInfo.carriedMasterId)
	self.carriedPetId = checknumber(creepInfo.carriedPetId)
	self.oracleMasterId = checknumber(creepInfo.oracleMasterId)
	self.oraclePetId = checknumber(creepInfo.oraclePetId)
	self.oraclePetRaceId = checknumber(creepInfo.oraclePetRaceId)
	self.heavenAwakenMasterId = checknumber(creepInfo.heavenAwakenMasterId)
	self.heavenAwakenSummonPetId = checknumber(creepInfo.heavenAwakenSummonPetId)
	self.position = pos
	self.contractSkillId = checknumber(creepInfo.contractSkillId)
	self.onlyUseExtProperties = checkbool(creepInfo.onlyUseExtProperties)
	self.extpropertiesArr = FightingPowerFormula.instance:parseAttrValues(creepInfo.extproperties) or {}
	self.bookSpiritPetId = checknumber(creepInfo.bookSpiritPetId)
	self.bookSpiritRaceId = checknumber(creepInfo.bookSpiritRaceId)

	local petCfg = CharacterConfig.instance:getPetCo(self.raceId)

	if checknumber(petCfg.sourceTraceId) > 0 then
		local defaultNodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(petCfg.sourceTraceId, SourceTraceController.DEFAULT_ACTIVE_NODE_ID)
		local hasDefalult = false

		for i, v in ipairs(self.sourceTraces) do
			if v.nodeId == defaultNodeCfg.nodeId then
				hasDefalult = true

				break
			end
		end

		if not hasDefalult then
			table.insert(self.sourceTraces, {
				nodeId = defaultNodeCfg.nodeId,
				effectId = defaultNodeCfg.effectIds[1]
			})
		end
	end

	self:calcAllAttr()

	if checknumber(creepInfo.powerCheat) > 0 then
		self._zdl = self._zdl * checknumber(creepInfo.powerCheat)
		self._zdl = math.round(self._zdl)
	end
end

function FightingPowerPetMo:parseRuneSuitValue(str)
	self.runeSuit = FightingPowerFormula.instance:parseRuneSuitValue(str, self.raceId)

	return self.runeSuit
end

function FightingPowerPetMo:parsEequipments(str)
	self.equipments = FightingPowerFormula.instance:parsEequipments(str, self.raceId, self.curFaceId)

	return self.equipments
end

function FightingPowerPetMo:parseHolyStripeAttrs(str)
	return (FightingPowerFormula.instance:parseHolyStripeAttrs(str))
end

function FightingPowerPetMo:parseCutePetAttrs(str)
	return (FightingPowerFormula.instance:parseCutePetAttrs(str))
end

function FightingPowerPetMo:toBaseBagPetMo()
	local bagPet = BagPetMo.New()

	bagPet.petId = self.petId
	bagPet.raceId = self.raceId
	bagPet.curFaceId = checknumber(self.curFaceId)

	if checknumber(self.curFaceId) == 0 then
		bagPet.curFaceId = checknumber(self.raceId)
	end

	bagPet:setAttrMo()

	bagPet.name = bagPet:getName()
	bagPet.level = self.level
	bagPet.summonMasterId = checknumber(self.summonMasterId)
	bagPet.summonedPetId = checknumber(self.summonedPetId)
	bagPet.awakeLevel = checknumber(self.awakeLevel)
	bagPet.awakenLv = checknumber(self.awakeLevel)
	bagPet.talentLevel = checknumber(self.talentLevel)
	bagPet.runeSuit = self.runeSuit or {}
	bagPet.equipments = self.equipments or {}
	bagPet.holyStripes = self.holyStripes or {}
	bagPet.decoration = self.decoration or {}
	bagPet.hoshigamis = self.hoshigamis or {}
	bagPet.throneList = self.throneList or {}
	bagPet.starGodPlusSlots = self.starGodPlusSlots or {}
	bagPet.goodFeelingInfos = self.goodFeelingInfos or {}
	bagPet.assistTeamInfoList = self.assistTeamInfoList or {}
	bagPet.benefitInfoList = self.benefitInfoList or {}
	bagPet.teamInfo = self.teamInfo or {}
	bagPet.mountInfo = self.mountInfo or {}
	bagPet.collectRelationIds = self.collectRelationIds or {}
	bagPet.formStrength = self.formStrength or {}
	bagPet.onlyUseExtProperties = checkbool(self.onlyUseExtProperties)
	bagPet.allPropertyExtZdl = self.allPropertyExtZdl
	bagPet.allPropertyExtZdlRate = self.allPropertyExtZdlRate
	bagPet.extpropertiesArr = self.extpropertiesArr
	bagPet.normalSkillLv = self.normalSkillLv
	bagPet.ultimateSkillLv = self.ultimateSkillLv
	bagPet.passiveSkillLv = self.passiveSkillLv
	bagPet.contractSkillId = self.contractSkillId
	bagPet.psychicedUltimateSkillLv = self.psychicedUltimateSkillLv
	bagPet.psychicedNormalSkillLv = self.psychicedNormalSkillLv
	bagPet.carriedMasterId = self.carriedMasterId
	bagPet.carriedPetId = self.carriedPetId
	bagPet.oracleMasterId = self.oracleMasterId
	bagPet.oraclePetId = self.oraclePetId
	bagPet.oraclePetRaceId = self.oraclePetRaceId
	bagPet.heavenAwakenMasterId = self.heavenAwakenMasterId
	bagPet.heavenAwakenSummonPetId = self.heavenAwakenSummonPetId
	bagPet.sourceTraces = self.sourceTraces
	bagPet.bookSpiritPetId = self.bookSpiritPetId
	bagPet.bookSpiritRaceId = self.bookSpiritRaceId
	bagPet.isMyPackPet = self.isMyPackPet
	bagPet.isSupportedPet = self.isSupportedPet

	bagPet:calcAllAttr()

	return bagPet
end

function FightingPowerPetMo:getFightingPower()
	return FightingPowerFormula.instance:getPetFightingPowerByFightingPetMo(self)
end

function FightingPowerPetMo:getSpeed()
	return self._speed
end

function FightingPowerPetMo.getMaxPetMoByData(petMo)
	if not petMo then
		return
	end

	local mo = FightingPowerPetMo.getMaxPetMo(petMo.raceId)

	mo.petId = petMo.petId
	mo.curFaceId = checknumber(petMo.curFaceId)
	mo.summonMasterId = petMo.summonMasterId
	mo.summonedPetId = petMo.summonedPetId
	mo.carriedMasterId = petMo.carriedMasterId
	mo.carriedPetId = petMo.carriedPetId
	mo.oracleMasterId = petMo.oracleMasterId
	mo.oraclePetId = petMo.oraclePetId
	mo.oraclePetRaceId = petMo.oraclePetRaceId
	mo.heavenAwakenMasterId = petMo.heavenAwakenMasterId
	mo.heavenAwakenSummonPetId = petMo.heavenAwakenSummonPetId
	mo.bookSpiritPetId = petMo.bookSpiritPetId
	mo.bookSpiritRaceId = petMo.bookSpiritRaceId
	mo.isMyPackPet = petMo.isMyPackPet
	mo.deleted = petMo.deleted
	mo.expiredTime = petMo.expiredTime
	mo.status = petMo.status
	mo.isSupportedPet = petMo.isSupportedPet
	petMo._rankRaceLimitMaxZdl = checknumber(mo._zdl)

	return mo
end

function FightingPowerPetMo.getMaxPetMo(raceId, faceId)
	local bagPet = BagPetMo.New()

	bagPet.isMyPackPet = false
	bagPet.raceId = raceId
	bagPet.curFaceId = checknumber(faceId)

	if checknumber(bagPet.curFaceId) == 0 then
		bagPet.curFaceId = checknumber(raceId)
	end

	bagPet:setAttrMo()

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	bagPet.level = petCo.maxLv
	bagPet.awakeLevel = FightingPowerPetMo._getMaxAwakenLevel(raceId) or 1
	bagPet.awakenLv = bagPet.awakeLevel
	bagPet.talentLevel = FightingPowerPetMo._getMaxTalentLevel(raceId) or 1
	bagPet.equipments = FightingPowerFormula.instance:parsEequipments("&100", raceId, bagPet.curFaceId)
	bagPet.teamInfo = {
		isMax = true
	}
	bagPet.contractSkillId = 0
	bagPet.normalSkillLv = 1
	bagPet.ultimateSkillLv = 1
	bagPet.passiveSkillLv = 1
	bagPet.psychicedUltimateSkillLv = 1
	bagPet.psychicedNormalSkillLv = 1
	bagPet.rare = CharacterConfig.instance:getRareByAwakenLv(0, bagPet.raceId)
	bagPet.sourceTraces = FightingPowerPetMo._getMaxSourceTraces(bagPet.raceId) or {}

	bagPet:calcAllAttr()

	return bagPet
end

function FightingPowerPetMo.getRealMaxPetMo(raceId, faceId)
	local bagPet = BagPetMo.New()

	bagPet.isMyPackPet = false
	bagPet.raceId = raceId
	bagPet.curFaceId = checknumber(faceId)

	if checknumber(bagPet.curFaceId) == 0 then
		bagPet.curFaceId = checknumber(raceId)
	end

	bagPet:setAttrMo()

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	bagPet.level = petCo.maxLv
	bagPet.awakeLevel = FightingPowerPetMo._getMaxAwakenLevel(raceId) or 1
	bagPet.awakenLv = bagPet.awakeLevel
	bagPet.talentLevel = FightingPowerPetMo._getMaxTalentLevel(raceId) or 1
	bagPet.equipments = FightingPowerFormula.instance:parsEequipmentsClient("&100", raceId, bagPet.curFaceId)
	bagPet.cutePetShelter = FightingPowerFormula.instance:parseCutePetAttrs(CutePetConfig.instance:getCommonValue("MaxCutePet", false))
	bagPet.holyStripes = FightingPowerFormula.instance:parseHolyStripeAttrs(HolyStripeConfig.instance:getParamsValue("MAX_HOLYSTRIPES_SUIT"))
	bagPet.starGodPlusSlots = {}

	local petskinCfg = PetSkinConfig.instance:getPetSkinCfg(bagPet.curFaceId)
	local starIds = petskinCfg.recommendClient

	for i, v in ipairs(starIds) do
		if StargodplusConfig.instance:getFillerCfg(v) then
			local star = {}

			star.slot = i

			local _, exp = StargodplusModel.instance:getMaxSlotLevel(i)

			star.exp = exp
			star.fillerDefineId = v

			table.insert(bagPet.starGodPlusSlots, star)
		else
			printError(">>>>>>>>>>>>>>>>>>>> 配置的推荐星神错误，faceId_starId:", bagPet.curFaceId, v)
		end
	end

	bagPet.teamInfo = {
		isMax = true
	}
	bagPet.sourceTraces = FightingPowerPetMo._getMaxSourceTraces(bagPet.raceId) or {}

	local skillLevelStrategyId = petCo.skillLevelStrategyId
	local normalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.NORMAL)
	local ultimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.ULTIMATE)
	local passiveSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PASSIVE)
	local psychicedNormalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_NORMAL)

	bagPet.contractSkillId = 0
	bagPet.normalSkillLv = normalSkillLv
	bagPet.ultimateSkillLv = ultimateSkillLv
	bagPet.passiveSkillLv = passiveSkillLv
	bagPet.psychicedUltimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_ULTIMATE)
	bagPet.psychicedNormalSkillLv = psychicedNormalSkillLv
	bagPet.rare = CharacterConfig.instance:getRareByAwakenLv(0, bagPet.raceId)
	bagPet.collectRelationIds = CharacterConfig.instance:getBondCfgsCollectIds(raceId)
	bagPet.assistTeamInfoList = FightingPowerPetMo.getAssistMax()
	bagPet.throneList = FightingPowerPetMo.getThroneMax()
	bagPet.goodFeelingInfos = FightingPowerPetMo.getGoodFeelingMax()
	bagPet.benefitInfoList = FightingPowerPetMo.getBenefitMax()
	bagPet.formStrength = FightingPowerPetMo.getFormStrengthMax()
	bagPet.mountInfo = FightingPowerPetMo.getMountMax()
	bagPet.activedOnFormRelationIds = {}

	table.insert(bagPet.activedOnFormRelationIds, bagPet.raceId)
	bagPet:calcAllAttr()

	return bagPet
end

function FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)
	local bagPet = BagPetMo.New()

	bagPet.isMyPackPet = false
	bagPet.raceId = raceId
	bagPet.curFaceId = checknumber(skinId)

	if checknumber(bagPet.curFaceId) == 0 then
		bagPet.curFaceId = checknumber(raceId)
	end

	bagPet:setAttrMo()

	bagPet.level = level
	bagPet.talentLevel = 0

	local cfg = CharacterConfig.instance:getPetExpCfg(level)

	if cfg then
		bagPet.talentLevel = cfg.talentLevel
	end

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if petCo then
		bagPet.awakeLevel = petCo.initAwakenLv
		bagPet.awakenLv = bagPet.awakeLevel
	end

	if awakenLv then
		bagPet.awakenLv = awakenLv
	end

	bagPet:calcAllAttr()

	return bagPet
end

function FightingPowerPetMo._getMaxAwakenLevel(raceId)
	if not raceId then
		return
	end

	local _cgfPet = CharacterConfig.instance:getPetCo(raceId)

	if _cgfPet and _cgfPet.awakenCostStrategyId <= 0 then
		return _cgfPet.initAwakenLv
	end

	local _awakenCfg = CharacterConfig.instance:getPetAwakenCostListCfgs(CharacterConfig.instance:getPetCo(raceId).awakenCostStrategyId)

	if _awakenCfg then
		table.sort(_awakenCfg, function(a, b)
			return a.level < b.level
		end)

		return _awakenCfg[#_awakenCfg].level
	end
end

function FightingPowerPetMo._getMaxTalentLevel(raceId)
	if not raceId then
		return
	end

	local _talentCfg = CharacterConfig.instance:getPetTalentCfgByRaceId(raceId)

	if _talentCfg then
		table.sort(_talentCfg, function(a, b)
			return a.level < b.level
		end)

		return _talentCfg[#_talentCfg].level
	end
end

function FightingPowerPetMo._getMaxSourceTraces(raceId)
	if not raceId then
		return
	end

	local _cgfPet = CharacterConfig.instance:getPetCo(raceId)

	if _cgfPet then
		local nodesCfgs = SourceTraceConfig.instance:getSourceTraceNodeCfgs(_cgfPet.sourceTraceId)

		if nodesCfgs then
			local result = {}

			for i, v in ipairs(nodesCfgs) do
				table.insert(result, {
					nodeId = v.nodeId,
					effectId = v.effectIds[1]
				})
			end

			return result
		end
	end
end

function FightingPowerPetMo:getAwakenLv(raceId, awakenLv)
	awakenLv = checknumber(awakenLv)

	local maxAwakenLv, initAwakenLv = CharacterConfig.instance:getMaxAwaken(raceId)

	if awakenLv <= 0 then
		awakenLv = 0
	elseif maxAwakenLv < awakenLv then
		awakenLv = maxAwakenLv
	end

	return math.max(awakenLv, 0)
end

function FightingPowerPetMo:toFightingPowerPetMo()
	return self
end

function FightingPowerPetMo:getPetLv()
	return checknumber(self.level)
end

function FightingPowerPetMo:isExist()
	return true
end

function FightingPowerPetMo.getAssistMax()
	local assistTeamInfoList = {}

	assistTeamInfoList.assistTeamInfo = {}

	local petCfgList = CharacterConfig.instance:getPetCfg()
	local teamCfgs = PetAssistConfig.instance:getPetTeamCfgs()
	local maxAwakenLv = 0
	local maxEvaluateLevel = math.huge
	local maxEvaluateLevelRaceId = 0
	local maxPetLv = 0

	for _, petCfg in ipairs(petCfgList) do
		if petCfg.raceId < 20000 and checknumber(petCfg.bookIds) > 0 then
			local awakenLv = CharacterConfig.instance:getMaxAwaken(petCfg.raceId)

			if maxEvaluateLevel > petCfg.evaluateLevel then
				maxEvaluateLevel = petCfg.evaluateLevel
				maxEvaluateLevelRaceId = petCfg.raceId
			end

			if maxPetLv < petCfg.maxLv then
				maxPetLv = petCfg.maxLv
			end

			if maxAwakenLv < awakenLv then
				maxAwakenLv = awakenLv
			end
		end
	end

	for type = 1, #teamCfgs do
		local allLvCfgs = PetAssistConfig.instance:GetTeamUpgradeAllCfgs(type)
		local info = {}

		info.type = type
		info.level = allLvCfgs[#allLvCfgs].level
		info.assistPetDetailList = {}

		local pcfgs = PetAssistConfig.instance:GetTeamUnlockAllCfgs(type)

		for j = 1, #pcfgs do
			local petInfo = {}

			petInfo.raceId = maxEvaluateLevelRaceId
			petInfo.awakenLv = maxAwakenLv
			petInfo.petLv = maxPetLv

			table.insert(info.assistPetDetailList, petInfo)
		end

		table.insert(assistTeamInfoList.assistTeamInfo, info)
	end

	return assistTeamInfoList
end

function FightingPowerPetMo.getThroneMax()
	local throneList = {}
	local throneCfgs = ThroneConfig.instance:getThroneCfgs()

	for i, v in ipairs(throneCfgs) do
		local th = {}

		th.throneId = v.id
		th.lv = 15

		table.insert(throneList, th)
	end

	return throneList
end

function FightingPowerPetMo.getGoodFeelingMax()
	local petCfgList = CharacterConfig.instance:getPetCfg()
	local goodFeelingInfos = {}

	for _, petCfg in ipairs(petCfgList) do
		if petCfg.raceId < 20000 and checknumber(petCfg.bookIds) > 0 then
			local hdCfg = HandbookConfig.instance:getPetDetailsCfgById(petCfg.raceId)

			if hdCfg then
				local lvPropCfgs = GoodFeelConfig.instance:getLvPropCfgs(hdCfg.propertyPlan)

				if lvPropCfgs then
					local maxUnlockLv = 0

					for i, ssCfg in pairs(lvPropCfgs) do
						maxUnlockLv = math.max(maxUnlockLv, ssCfg.unlockLv)
					end

					table.insert(goodFeelingInfos, {
						raceId = petCfg.raceId,
						level = maxUnlockLv
					})
				end
			else
				printError(">>>>>>>>>>>>>>>>>>>>>此精灵在精灵基础信息配置了 bookIds 有值  但没有图鉴信息表却找不到它的配置：", petCfg.raceId)
			end
		end
	end

	return goodFeelingInfos
end

function FightingPowerPetMo.getBenefitMax()
	local petCfgList = CharacterConfig.instance:getPetCfg()
	local benefitInfoList = {}

	benefitInfoList.benefitInfo = {}

	local map = {}
	local map2 = {}

	for _, cfg in ipairs(petCfgList) do
		local petDetail = HandbookConfig.instance:getPetDetailsCfgById(cfg.raceId)
		local manualBenefitId = cfg.manualBenefitId

		if (not petDetail or petDetail.unproved ~= 1) and manualBenefitId > 0 and not string.nilorempty(cfg.bookIds) then
			if cfg.awakenCostStrategyId < 0 then
				local info = map2[manualBenefitId]

				if info == nil then
					info = {}

					table.insert(benefitInfoList.benefitInfo, info)
				end

				info.benefitId = manualBenefitId
				info.benefitLv = 0
				info.num = checknumber(info.num) + 1
				map2[manualBenefitId] = info
			else
				local info = map[manualBenefitId]

				if info == nil then
					info = {}

					table.insert(benefitInfoList.benefitInfo, info)
				end

				info.benefitId = manualBenefitId
				info.benefitLv = 6
				info.num = checknumber(info.num) + 1
				map[manualBenefitId] = info
			end
		end
	end

	return benefitInfoList
end

function FightingPowerPetMo.getFormStrengthMax()
	local formStrength = {}

	formStrength.formStrengths = {}

	for i = 1, 8 do
		local info = {}

		info.formStrengthId = i
		info.formStrengthLv = 20

		table.insert(formStrength.formStrengths, info)
	end

	return formStrength
end

function FightingPowerPetMo.getMountMax()
	return {
		isMax = true
	}
end

function FightingPowerPetMo:printAttrs()
	BagPetMo.printAttrs(self)
end

function FightingPowerPetMo:setSupportedPet(isSupport)
	self.isSupportedPet = isSupport
	self.isMyPackPet = not isSupport
end

function FightingPowerPetMo:isBorrowPet()
	return self.status == BagPetsController.PET_STATUS_BORROW
end

function FightingPowerPetMo:setAttrMo()
	local checkRaceId = self.curFaceId

	if checknumber(checkRaceId) <= 0 then
		checkRaceId = self.raceId
	end

	local isSourceTrace = PetSkinConfig.instance:checkHasJob(checkRaceId, GameEnum.JobZhDefine.SourceTrace)

	self.attrMo = isSourceTrace == true and SourceTraceAttrMo.New() or AttrMo.New()
end

return FightingPowerPetMo
