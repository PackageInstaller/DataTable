-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/fightingpower/FightingPowerFormula.lua

module("logic.extensions.common.fightingpower.FightingPowerFormula", package.seeall)

local FightingPowerFormula = class("FightingPowerFormula")
local EMPTY_TB = {}

function FightingPowerFormula:ctor()
	return
end

function FightingPowerFormula:getAttrTypeByName(name)
	if self.attrNameMap == nil then
		self.attrNameMap = {}

		local cnt = #GameEnum.AttrTypeName

		for i = 1, cnt do
			local key = GameEnum.AttrTypeName[i]

			self.attrNameMap[key] = i
		end
	end

	return self.attrNameMap[name]
end

function FightingPowerFormula:getAttrNameValue(attr)
	local isNe = 1
	local startP, endP = string.find(attr, "+")

	if not startP then
		isNe = -1
		startP, endP = string.find(attr, "-")
	end

	if startP and endP then
		local attrName = string.sub(attr, 1, endP - 1)
		local attrVal = string.sub(attr, endP + 1, #attr)

		return attrName, self:strToNumber(attrVal) * isNe
	else
		return "", 0
	end
end

function FightingPowerFormula:strToNumber(attrVal)
	local startP, endP = string.find(attrVal, "%%")

	if startP then
		attrVal = string.sub(attrVal, 1, endP - 1)
		attrVal = checknumber(attrVal) / 100

		return attrVal
	end

	return tonumber(attrVal)
end

function FightingPowerFormula:parseAttrValues(str)
	if string.nilorempty(str) then
		return
	end

	local attrs = string.split(str, "#")
	local attrValues

	for i = 1, #attrs do
		local attrName, attrVal = self:getAttrNameValue(attrs[i])
		local attrType = self:getAttrTypeByName(attrName)

		if attrType then
			attrValues = attrValues or {}
			attrValues[attrType] = attrVal
		end
	end

	return attrValues
end

function FightingPowerFormula:parseGeniusValues(geniusStr)
	if not geniusStr or #geniusStr == 0 then
		return
	end

	local attrs = string.split(geniusStr, "#")
	local attrValues

	for i = 1, #attrs do
		local attrName, attrVal = self:getAttrNameValue(attrs[i])
		local attrType = self:getAttrTypeByName(attrName)
		local star = TalentConfig.instance:GetStar(attrVal)

		attrValues = attrValues or {}
		attrValues[attrType] = {
			value = attrVal,
			star = star
		}
	end

	return attrValues
end

function FightingPowerFormula:parseRuneSuitValue(str, raceId)
	local runeSuit = {}

	if not string.nilorempty(str) then
		if string.find(str, "&") ~= nil then
			local temStr = string.gsub(str, "&", "")
			local lvl = checknumber(temStr)
			local petCo = CharacterConfig.instance:getPetCo(raceId)

			if petCo then
				runeSuit.runeSuitId = petCo.recmdRuneSuitId

				local list = {}
				local slots = petCo.recmdRune

				if slots then
					for k, v in pairs(slots) do
						local level = RuneConfig.instance:getRuneMaxLevel(checknumber(v))
						local obj = {}

						obj.pos = checknumber(k)
						obj.defineId = checknumber(v)
						obj.level = math.min(lvl, level)

						table.insert(list, obj)
					end
				end

				runeSuit.slots = list
			end
		else
			local arr = string.split(str, "_")

			if arr then
				local _runeSuitId = checknumber(arr[1])
				local _slots = {}
				local tem = arr[2]
				local temArr = string.split(tem, "#")

				for i, v in ipairs(temArr) do
					if v ~= "0" then
						local matArr = string.split(tarStr, ":")
						local level = RuneConfig.instance:getRuneMaxLevel(checknumber(matArr[1]))
						local obj = {
							pos = i,
							defineId = checknumber(matArr[1]),
							level = math.min(level, checknumber(matArr[2]))
						}

						table.insert(_slots, obj)
					end
				end

				runeSuit = {
					runeSuitId = _runeSuitId,
					slots = _slots
				}
			end
		end
	end

	return runeSuit
end

function FightingPowerFormula:parsEequipments(str, raceId, skinId)
	local equipments = {}

	if not string.nilorempty(str) then
		if string.find(str, "&") ~= nil then
			local temStr = string.gsub(str, "&", "")
			local temArr = string.split(temStr, "#")
			local lvl = checknumber(temArr[1])
			local quailty = checknumber(temArr[2])
			local petskinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if petskinCfg then
				local recmdEquipmentId = petskinCfg.recmdEquipmentId

				for i, v in ipairs(recmdEquipmentId) do
					local _defineId = v
					local positionType = EquipmentConfig.instance:GetEquipDefineInfoById(v).positionType
					local maxLvl = PetEquipModel.instance:GetEquipUpgradeMaxLevel(v)

					if quailty > 0 then
						local cc = EquipmentConfig.instance:getSameGropWitQuality(v, quailty)

						_defineId = cc.id
					end

					local tem = {
						positionId = positionType,
						defineId = _defineId,
						lv = math.min(maxLvl, lvl)
					}

					table.insert(equipments, tem)
				end
			end
		else
			local temArr = string.split(str, "#")

			for i, v in ipairs(temArr) do
				local matArr = string.split(temArr[i], ":")
				local _defineId = checknumber(matArr[1])
				local maxLvl = PetEquipModel.instance:GetEquipUpgradeMaxLevel(_defineId)
				local positionType = EquipmentConfig.instance:GetEquipDefineInfoById(_defineId).positionType
				local tem = {
					positionId = positionType,
					defineId = _defineId,
					lv = math.min(maxLvl, checknumber(matArr[2]))
				}

				table.insert(equipments, tem)
			end
		end
	end

	return equipments
end

function FightingPowerFormula:parsEequipmentsClient(str, raceId, skinId)
	local equipments = {}

	if not string.nilorempty(str) then
		if string.find(str, "&") ~= nil then
			local temStr = string.gsub(str, "&", "")
			local temArr = string.split(temStr, "#")
			local lvl = checknumber(temArr[1])
			local quailty = checknumber(temArr[2])
			local petskinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if petskinCfg then
				local recmdEquipmentId = petskinCfg.recmdEquipmentIdClient

				for i, v in ipairs(recmdEquipmentId) do
					local _defineId = v
					local equipDefineCfg = EquipmentConfig.instance:GetEquipDefineInfoById(v)

					if equipDefineCfg then
						local positionType = equipDefineCfg.positionType
						local maxLvl = PetEquipModel.instance:GetEquipUpgradeMaxLevel(v)

						if quailty > 0 then
							local cc = EquipmentConfig.instance:getSameGropWitQuality(v, quailty)

							_defineId = cc.id
						end

						local tem = {
							positionId = positionType,
							defineId = _defineId,
							lv = math.min(maxLvl, lvl),
							bonusRaceId = (checknumber(petskinCfg.raceEquipmentWeight) > 0 or nil) and raceId
						}

						table.insert(equipments, tem)
					else
						printError(">>>>>>>> 装备配置错误 t_pet_skin :recmdEquipmentIdClient SkinId ,EquipID:", skinId, _defineId)
					end
				end
			end
		else
			local temArr = string.split(str, "#")

			for i, v in ipairs(temArr) do
				local matArr = string.split(temArr[i], ":")
				local _defineId = checknumber(matArr[1])
				local maxLvl = PetEquipModel.instance:GetEquipUpgradeMaxLevel(_defineId)
				local positionType = EquipmentConfig.instance:GetEquipDefineInfoById(_defineId).positionType
				local tem = {
					positionId = positionType,
					defineId = _defineId,
					lv = math.min(maxLvl, checknumber(matArr[2])),
					bonusRaceId = checknumber(matArr[3])
				}

				table.insert(equipments, tem)
			end
		end
	end

	return equipments
end

function FightingPowerFormula:parseHolyStripeAttrs(str)
	local holyStripes = {}

	if not string.nilorempty(str) then
		local list = string.split(str, "#")

		for i, v in ipairs(list) do
			local arr = string.split(v, ":")
			local obj = {}

			obj.id = checknumber(arr[1])
			obj.configId = checknumber(arr[2])
			obj.propertyId = checknumber(arr[3])
			obj.strengthenLv = checknumber(arr[4])
			obj.quenchingIds = {}

			local qStr = arr[5]

			if not string.nilorempty(qStr) then
				local tmpList = string.splitToNumber(qStr, ",")

				for j, value in ipairs(tmpList) do
					table.insert(obj.quenchingIds, value)
				end
			end

			table.insert(holyStripes, obj)
		end
	end

	return holyStripes
end

function FightingPowerFormula:parseCutePetAttrs(str)
	local cutePetShelter = {}

	if not string.nilorempty(str) then
		local arr = string.split(str, ":")

		cutePetShelter.cutePetRaceId = checknumber(arr[1])
		cutePetShelter.initialTalent = checknumber(arr[2])
		cutePetShelter.quality = checknumber(arr[3])
		cutePetShelter.lvl = checknumber(arr[4])
		cutePetShelter.star = checknumber(arr[5])
		cutePetShelter.initialProps = {}

		local len = #arr
		local propsIndex = 6

		if propsIndex <= len then
			for i = propsIndex, len do
				local propInfo = string.splitToNumber(arr[i], ",")

				table.insert(cutePetShelter.initialProps, {
					propClientIndex = propInfo[1],
					propValue = propInfo[2]
				})
			end
		elseif cutePetShelter.cutePetRaceId > 0 then
			local cutePetCfg = CutePetConfig.instance:getCutePetById(cutePetShelter.cutePetRaceId)
			local propCfg = CutePetConfig.instance:getInitPropCfgs(cutePetCfg.initPropertyPlan)

			for i, v in pairs(propCfg) do
				local typeIndex = self:getAttrTypeByName(i)

				if checknumber(typeIndex) > 0 and checknumber(v.genRange[2]) > 0 then
					table.insert(cutePetShelter.initialProps, {
						propClientIndex = typeIndex,
						propValue = v.genRange[2]
					})
				end
			end
		end
	end

	return cutePetShelter
end

function FightingPowerFormula:getSpeed(petMo, extproperties)
	if petMo:isSummonedPet() then
		return 0
	end

	local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
	local raceSpd = petCo.speed
	local runeSpd, runeSpdRate = 0, 0
	local talentSpd, talentSpdRate = 0, 0

	for i = 0, checknumber(petMo.talentLevel) do
		local cfg = CharacterConfig.instance:getPetTalentCfg(petMo.raceId, i)

		if cfg then
			local tem, temRate = self:_getSpeedInfoFromString(cfg.levelProps)

			talentSpd = talentSpd + tem
			talentSpdRate = talentSpdRate + temRate
		end
	end

	local awakenSpd, awakenSpdRate = 0, 0

	for i = 0, checknumber(petMo.awakeLevel) do
		local cfg = CharacterConfig.instance:getPetAwakenStrategyCfg(petCo.awakenStrategyId, i)

		if cfg then
			local tem, temRate = self:_getSpeedInfoFromString(cfg.propertyParam)

			awakenSpd = awakenSpd + tem
			awakenSpdRate = awakenSpdRate + temRate
		end
	end

	local equipSpd, equipSpdRate = 0, 0

	for k, tem in pairs(petMo.equipments or {}) do
		local id = tem.id
		local cfgId = checknumber(tem.defineId)
		local lvl = checknumber(tem.lv)
		local bonusRaceId = checknumber(tem.bonusRaceId)
		local equip

		if checknumber(id) > 0 then
			equip = PetEquipModel.instance:GetEquipInfo(id)
			cfgId = equip:getDefineId()
			lvl = equip.starCount
		end

		local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)
		local equipInfo = EquipmentConfig.instance:GetEquipInfoByLvl(cfg.equipmentLvStrategy, lvl)

		if bonusRaceId > 0 and bonusRaceId == petMo.raceId then
			equipSpd, equipSpdRate = self:_getSpeedInfoFromString(equipInfo.racePropertyApp)
		elseif PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, cfg.additionRaceType) then
			equipSpd, equipSpdRate = self:_getSpeedInfoFromString(equipInfo.propertyApp2)
		else
			equipSpd, equipSpdRate = self:_getSpeedInfoFromString(equipInfo.propertyApp)
		end
	end

	local extSpd, extSpdRate = self:_getSpeedInfoFromString(extproperties)
	local speed_total = (raceSpd * petMo.level * 0.06 + petMo.level * 20) / 20

	speed_total = speed_total + talentSpd + awakenSpd + equipSpd + runeSpd + extSpd
	speed_total = speed_total * (1 + talentSpdRate + awakenSpdRate + equipSpdRate + runeSpdRate + extSpdRate)
	speed_total = math.round(speed_total)

	return speed_total
end

function FightingPowerFormula:_getSpeedInfoFromString(attrsStr)
	local attrs = self:parseAttrValues(attrsStr)
	local spd = 0
	local spdRate = 0

	if attrs then
		spd = attrs[GameEnum.AttrType.Speed] or 0
		spdRate = attrs[GameEnum.AttrType.SpeedRate] or 0
	end

	return checknumber(spd), checknumber(spdRate)
end

function FightingPowerFormula:getLevelFightingPower(raceId, curLv)
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if petCo then
		return math.round(petCo.zdlRadix * curLv / 100 + petCo.zdlRadix * 0.06)
	end

	return 0
end

function FightingPowerFormula:getAwakenFightingPower(raceId, curLv)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local awakenCo = CharacterConfig.instance:getPetAwakenStrategyCfg(cfg.awakenStrategyId, curLv)

	if awakenCo then
		return math.round(awakenCo.awakenZdl)
	end

	return 0
end

function FightingPowerFormula:getGeniusTrainingFightingPower(raceId, level)
	local talentCo = CharacterConfig.instance:getPetTalentCfg(raceId, level)

	if talentCo then
		return math.round(talentCo.zdl)
	end

	return 0
end

function FightingPowerFormula:getRuneFightingPower(raceId, runeSuit, isMypet)
	return math.round(RuneConfig.instance:getSuitZDL(runeSuit, isMypet))
end

function FightingPowerFormula:getEquipFightingPower(raceId, skinId, equipments)
	return math.round(EquipmentConfig.instance:getEquipmentsZDL(raceId, skinId, equipments))
end

function FightingPowerFormula:getPetTeamFightingPower(raceId, teamInfo, isMyTeam)
	return math.round(HandbookConfig.instance:getPetTeamFightingPower(raceId, teamInfo, isMyTeam))
end

function FightingPowerFormula:getPetFightingPowerByPetMo(petMo)
	return self:getPetFightingPowerByFightingPetMo(petMo)
end

function FightingPowerFormula:getPetFightingPowerByFightingPetMo(petMo)
	if petMo.isSupportedPet and checknumber(petMo.supportedFightingPower) > 0 then
		return checknumber(petMo.supportedFightingPower)
	end

	return checknumber(petMo._zdl)
end

function FightingPowerFormula:getPetMaxFightingPower(raceId)
	self.pet_max_pool = self.pet_max_pool or {}

	if self.pet_max_pool[raceId] == nil then
		local pet = FightingPowerPetMo.getMaxPetMo(raceId)

		self.pet_max_pool[raceId] = pet._zdl
	end

	return self.pet_max_pool[raceId]
end

function FightingPowerFormula:getPetMaxFightingPowerForRankRace(raceId, _heroSkillId)
	return self:getPetMaxFightingPower(raceId)
end

function FightingPowerFormula:getRealMaxFightingPowerPetMo(raceId)
	self.real_max_petmo_pool = self.real_max_petmo_pool or {}

	if self.real_max_petmo_pool[raceId] == nil then
		self.real_max_petmo_pool[raceId] = FightingPowerPetMo.getRealMaxPetMo(raceId)
	end

	return self.real_max_petmo_pool[raceId]
end

function FightingPowerFormula:getMaxLevelFightingPower(raceId)
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if petCo then
		local maxLvl = petCo.maxLv

		return math.round(petCo.zdlRadix * maxLvl / 100 + petCo.zdlRadix * 0.06)
	end

	return 0
end

function FightingPowerFormula:getMaxAwakenFightingPower(raceId)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local _initAwakenLv

	if cfg.awakenCostStrategyId <= 0 then
		_initAwakenLv = cfg.initAwakenLv
	end

	local awakenCfgs = CharacterConfig.instance:getPetAwakenCfgs(cfg.awakenStrategyId)
	local maxPower = 0

	if _initAwakenLv then
		if awakenCfgs[tonumber(_initAwakenLv)] == nil then
			return 0
		else
			maxPower = awakenCfgs[tonumber(_initAwakenLv)].awakenZdl
		end
	else
		for k, v in pairs(awakenCfgs) do
			if maxPower < v.awakenZdl then
				maxPower = v.awakenZdl
			end
		end
	end

	return maxPower
end

function FightingPowerFormula:getMaxGeniusTrainingFightingPower(raceId)
	local geniusCfgs = CharacterConfig.instance:getPetTalentCfgByRaceId(raceId)
	local maxPower = 0

	if geniusCfgs then
		for k, v in pairs(geniusCfgs) do
			if maxPower < v.zdl then
				maxPower = v.zdl
			end
		end
	end

	return maxPower
end

function FightingPowerFormula:getMaxEquipmentFightingPower(raceId, skinId)
	return (EquipmentConfig.instance:getMaxEquipmentsZDL(raceId, skinId))
end

function FightingPowerFormula:getMaxRuneFightingPower(raceId)
	return (RuneConfig.instance:getMaxRuneZDL(raceId))
end

function FightingPowerFormula:getMaxTeamFightingPower(raceId)
	return (HandbookConfig.instance:getMaxTeamZdl())
end

function FightingPowerFormula:getFormStrength(positions, summonPetId)
	summonPetId = checknumber(summonPetId)

	local cfgs = BattleConfig.instance:getFormStrengthTriggerCfgs().dataList
	local posDataList = {}
	local compA = 0

	for i, petId in ipairs(positions) do
		if petId > 0 and petId ~= summonPetId then
			table.insert(posDataList, i)

			compA = compA + math.pow(2, i)
		end
	end

	for k, posCfg in pairs(cfgs) do
		local posList = posCfg.posList

		if posList and #posList == #posDataList then
			local compB = 0

			for i = 1, #posList do
				local pp_b = posList[i]

				compB = compB + math.pow(2, pp_b)
			end

			if compA == compB then
				return posCfg
			end
		end
	end

	return nil
end

function FightingPowerFormula:getFightingPowerWithHeroSkill(petMo, team, heroSkillId, formStrengthId, formStrengthLv, elementRelationMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
	summonMasterId = checknumber(summonMasterId)
	summonPetId = checknumber(summonPetId)
	heroSkillId = checknumber(heroSkillId)

	local fzdl1 = 0
	local fzdl2 = 0

	if formStrengthId and formStrengthId > 0 then
		local cfg = BattleConfig.instance:getFormStrengthLvCfg(formStrengthId, formStrengthLv)

		if cfg then
			fzdl1 = cfg.fixedZdl
			fzdl2 = cfg.zdlFactor
		end
	end

	local fightingPower = self:getPetFightingPowerByFightingPetMo(petMo)

	if petMo.petId == summonPetId then
		for k, mo in pairs(team or {}) do
			if mo.petId == summonMasterId then
				local zdlFactor = ContractConfig.instance:getBtlSummonFactor(mo.raceId, petMo.raceId)

				fightingPower = fightingPower * zdlFactor

				break
			end
		end
	end

	local zdl1 = 0
	local zdl2 = 0

	if heroSkillId > 0 then
		local heroBuffs = self:_getHeroSkillsValidBuffForPet(heroSkillId, petMo, team, elementRelationMap, summonMasterId, summonPetId)

		if heroBuffs then
			for i = 1, #heroBuffs do
				zdl1 = zdl1 + heroBuffs[i].zdl1
				zdl2 = zdl2 + heroBuffs[i].zdl2
			end
		end
	end

	local zdl3 = 0
	local zdl4 = 0
	local fromPool = {}

	if petMo.activedOnFormRelationIds then
		for k, id in pairs(petMo.activedOnFormRelationIds) do
			if id > 0 then
				local cfg = CharacterConfig.instance:getBondCfgsFormByID(id)

				if cfg and fromPool[cfg.raceId] == nil then
					fromPool[cfg.raceId] = cfg
					zdl3 = zdl3 + cfg.fixedZdl
					zdl4 = zdl4 + cfg.factorZdl
				end
			end
		end
	end

	local arr = CharacterConfig.instance:getBondCfgsOnForm(petMo.raceId)

	for k, cfg in pairs(arr or {}) do
		if fromPool[cfg.raceId] == nil then
			local isHasOne = false

			for k, raceId in ipairs(cfg.relativeRaceIds) do
				for k, temMo in pairs(team) do
					if temMo.raceId == raceId then
						isHasOne = true

						break
					end
				end
			end

			if isHasOne then
				zdl3 = 0
				zdl4 = 0
				fromPool[cfg.raceId] = cfg
				zdl3 = zdl3 + cfg.fixedZdl
				zdl4 = zdl4 + cfg.factorZdl
			end
		end
	end

	local cuteRate = 0

	cutePetRaceId = checknumber(cutePetRaceId)
	cutePetQuality = checknumber(cutePetQuality)

	if cutePetRaceId > 0 then
		local cuteCfg = CutePetConfig.instance:getAssistanceCfgByRaceId(cutePetRaceId, cutePetQuality)

		if cuteCfg then
			cuteRate = cuteCfg.zdlRate
		end
	end

	local maxLv = CharacterConfig.instance:GetMaxLevel(petMo.raceId)

	fightingPower = (fightingPower + fzdl1 + zdl3 + zdl1 * (petMo.level / maxLv)) * (1 + zdl2 + zdl4 + fzdl2 + cuteRate)

	return math.round(fightingPower)
end

function FightingPowerFormula:getFightingPowerOfFmt(cCfg, heroSkillId)
	local _curMasterId = 0
	local _targetId = 0
	local curFaceId = 0
	local masterId = 0
	local summonId = 0
	local teams = {}
	local formations = {}

	for i, v in pairs(cCfg) do
		local petMo = FightingPowerPetMo.New()

		petMo:fromChallengeCreepCo(v, cCfg)

		if checknumber(v.posId) > 0 then
			table.insert(teams, petMo)

			formations[v.posId] = petMo
		end

		local elementalMasterId = checknumber(v.elementalMasterId)
		local elementalTargetId = checknumber(v.elementalTargetId)

		if elementalMasterId > 0 then
			_curMasterId = elementalMasterId
			curFaceId = petMo.curFaceId
		end

		if elementalTargetId > 0 then
			_targetId = elementalTargetId
		end

		if checknumber(v.summonMasterId) > 0 then
			masterId = checknumber(v.summonMasterId)
		end

		if checknumber(v.summonedPetId) > 0 then
			summonId = checknumber(v.summonedPetId)
		end
	end

	local _elementRelationMap = {}

	if _targetId > 0 then
		_elementRelationMap[_targetId] = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)
	end

	local cutePetRaceId = 0
	local cutePetQuality = 0

	heroSkillId = heroSkillId or 0

	if heroSkillId <= 0 then
		local heroSkillIs = self:getHeroValidSkills(teams, _elementRelationMap, masterId, summonId)

		if heroSkillIs and #heroSkillIs > 0 then
			heroSkillId = heroSkillIs[1]
		end
	end

	local zdlRadix = 0

	for i = 1, 9 do
		local petMo = formations[i]

		if petMo then
			zdlRadix = zdlRadix + self:getFightingPowerWithHeroSkill(petMo, teams, heroSkillId, 0, 0, _elementRelationMap, cutePetRaceId, cutePetQuality)
		end
	end

	return zdlRadix
end

function FightingPowerFormula:getTeamFightingPower(team, heroSkillId, formStrengthId, formStrengthLv, elementRelationMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
	if not team or #team == 0 then
		return 0
	end

	local fightingPowers = 0
	local cnt = #team

	for i = 1, cnt do
		local fightingPower = self:getFightingPowerWithHeroSkill(team[i], team, heroSkillId, formStrengthId, formStrengthLv, elementRelationMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)

		fightingPowers = fightingPowers + fightingPower
	end

	return math.round(fightingPowers)
end

function FightingPowerFormula:getTeamMaxFightingPowerForRankRace(team)
	if not team or #team == 0 then
		return 0
	end

	local fightingPowers = 0
	local cnt = #team

	for i = 1, cnt do
		local fightingPower = self:getPetMaxFightingPowerForRankRace(team[i].raceId)

		fightingPowers = fightingPowers + fightingPower
	end

	return math.round(fightingPowers)
end

function FightingPowerFormula:getTeamMaxFightingPower(team)
	if not team or #team == 0 then
		return 0
	end

	local fightingPowers = 0
	local cnt = #team

	for i = 1, cnt do
		local fightingPower = self:getPetMaxFightingPower(team[i].raceId)

		fightingPowers = fightingPowers + fightingPower
	end

	return math.round(fightingPowers)
end

function FightingPowerFormula:getTeamSpeed(team)
	if not team or #team == 0 then
		return 0
	end

	local totalSpeed = 0
	local cnt = #team

	for i = 1, cnt do
		local speed = team[i]:getSpeed()

		if not team[i]:isSummonedPet() then
			totalSpeed = totalSpeed + speed
		end
	end

	return totalSpeed
end

function FightingPowerFormula:getHeroSkills(team)
	local heroSkills = {}

	if not team or #team == 0 then
		return heroSkills
	end

	for i = 1, #team do
		local skinId = checknumber(team[i].curFaceId)

		if skinId == 0 then
			skinId = team[i].raceId
		end

		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if petCo.heroSkillId > 0 and not table.indexof(heroSkills, petCo.heroSkillId) then
			table.insert(heroSkills, petCo.heroSkillId)
		end
	end

	return heroSkills
end

function FightingPowerFormula:getHeroSkillsByPetIds(petIds)
	local heroSkills = {}

	if not petIds or #petIds == 0 then
		return heroSkills
	end

	for i = 1, #petIds do
		local skinId = checknumber(petIds[i].curFaceId)

		if skinId == 0 then
			skinId = petIds[i].raceId
		end

		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if petCo and petCo.heroSkillId > 0 and not table.indexof(heroSkills, petCo.heroSkillId) then
			table.insert(heroSkills, petCo.heroSkillId)
		end
	end

	return heroSkills
end

function FightingPowerFormula:getHeroValidSkills(team, elementRelationMap, masterId, summonId)
	local heroSkills = {}

	if not team or #team == 0 then
		return heroSkills
	end

	if team[1] and team[1].position and team[1].position > 0 then
		ArraySort.sortOn(team, "position")
	end

	for i = 1, #team do
		local skinId = checknumber(team[i].curFaceId)

		if skinId == 0 then
			skinId = team[i].raceId
		end

		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if petCo.heroSkillId > 0 and not table.indexof(heroSkills, petCo.heroSkillId) and self:_isHeroSkillsValid(petCo.heroSkillId, team, elementRelationMap, masterId, summonId) then
			table.insert(heroSkills, petCo.heroSkillId)
		end
	end

	return heroSkills
end

function FightingPowerFormula:isSpiritInvocationSkillValid(spiritInvocationSkillId, team, elementRelationMap)
	spiritInvocationSkillId = checknumber(spiritInvocationSkillId)

	if spiritInvocationSkillId <= 0 then
		return false
	end

	local cfg = ContractConfig.instance:getSpiritInvocationCfg(spiritInvocationSkillId)

	if not cfg then
		return false
	end

	return self:_exePlayerLimitClazz(cfg.playerLimitClazz, cfg.playerLimitParams, team or {}, elementRelationMap)
end

function FightingPowerFormula:getSpiritInvocationValidPets(team, elementRelationMap)
	local spiritInvocationPets = {}

	if not team or #team == 0 then
		return spiritInvocationPets
	end

	for i = 1, #team do
		local skinId = checknumber(team[i].curFaceId)

		if skinId == 0 then
			skinId = team[i].raceId
		end

		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local spiritInvocationSkillId = petCo and checknumber(petCo.spiritInvocationSkillId) or 0

		if spiritInvocationSkillId > 0 and self:isSpiritInvocationSkillValid(spiritInvocationSkillId, team, elementRelationMap) then
			table.insert(spiritInvocationPets, team[i])
		end
	end

	return spiritInvocationPets
end

function FightingPowerFormula:getCombinationValidSkills(formations)
	if not formations or table.nums(formations) == 0 then
		return nil, nil, nil
	end

	local skillsList = {}
	local skillsFormulaIdList = {}
	local map = {}

	for k, pet in pairs(formations) do
		map[pet.raceId] = map[pet.raceId] or {}

		table.insert(map[pet.raceId], pet)
	end

	local finalMap = {}
	local finalList = {}

	for i = 1, 9 do
		local petMo = formations[i]

		if petMo then
			local raceId = petMo.raceId
			local petCfg = MaterialMgr.getMatCfg(MatType.Pet, raceId)
			local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

			if petCfg and checknumber(petSkinCfg.combinationSkillId) > 0 then
				local csId = checknumber(petSkinCfg.combinationSkillId)
				local skCfg = BattleConfig.instance:getCombinionSkillCfg(csId)

				if skCfg and skCfg.raceIds then
					local isActive = true
					local temPool = {}

					for _, rid in ipairs(skCfg.raceIds) do
						local temArr = map[rid]

						if temArr then
							for _, pp in ipairs(temArr) do
								if temPool[pp.petId] == nil and finalMap[pp.petId] == nil then
									temPool[pp.petId] = pp
								end
							end
						else
							isActive = false

							break
						end
					end

					if isActive and table.nums(temPool) == #skCfg.raceIds then
						local list = BattleConfig.instance:getCombinionSkillformulaCfg(csId)

						for _, formulaCfg in ipairs(list) do
							local str = formulaCfg.raceIdLimit

							if self:checkCanCombinion(str, formations) then
								table.insert(finalList, temPool)
								table.merge(finalMap, temPool)
								table.insert(skillsList, csId)
								table.insert(skillsFormulaIdList, formulaCfg.formulaId)

								break
							end
						end
					end
				end
			end
		end
	end

	return skillsList, skillsFormulaIdList, finalList, finalMap
end

function FightingPowerFormula:checkCanCombinion(str, formations)
	if not string.nilorempty(str) then
		local arr = string.split(str, "_")

		for i, v in ipairs(arr) do
			local arr2 = string.splitToNumber(v, "#")
			local raceId = arr2[1]
			local pos = arr2[2]
			local pet = formations[pos]

			if pet and pet.raceId == raceId then
				-- block empty
			else
				return false
			end
		end
	end

	return true
end

function FightingPowerFormula:_isHeroSkillsValid(heroSkillId, team, elementRelationMap, masterId, summonId)
	local buffs = BattleConfig.instance:getHeroSkillBuffs(heroSkillId)

	if not buffs then
		return
	end

	for i = 1, #buffs do
		local filterTeam = self:_exePlayerFilter(buffs[i], team, masterId, summonId)

		if #filterTeam > 0 and self:_exePlayerLimitClazz(buffs[i].playerLimitClazz, buffs[i].playerLimitParams, team, elementRelationMap) then
			return true
		end
	end
end

function FightingPowerFormula:_getHeroSkillsValidBuffForPet(heroSkillId, petMo, team, elementRelationMap, masterId, summonId)
	local buffs = BattleConfig.instance:getHeroSkillBuffs(heroSkillId)

	if not buffs then
		return
	end

	local validBuffs

	for i = 1, #buffs do
		local filterTeam = self:_exePlayerFilter(buffs[i], team, masterId, summonId)

		if #filterTeam > 0 and self:_exePetFilter(petMo, buffs[i].petFilter) and self:_exePlayerLimitClazz(buffs[i].playerLimitClazz, buffs[i].playerLimitParams, team, elementRelationMap) then
			validBuffs = validBuffs or {}

			table.insert(validBuffs, buffs[i])
		end
	end

	return validBuffs
end

function FightingPowerFormula:getHeroSkillsWhichPetValid(heroSkillId, team, elementRelationMap, masterId, summonId)
	local res

	if heroSkillId > 0 then
		for i, petMo in ipairs(team) do
			local heroBuffs = self:_getHeroSkillsValidBuffForPet(heroSkillId, petMo, team, elementRelationMap, masterId, summonId)

			if heroBuffs and #heroBuffs > 0 then
				res = res or {}
				res[petMo] = heroBuffs
			end
		end
	end

	return res
end

function FightingPowerFormula:_exePlayerFilter(buff, team, masterId, summonId)
	if not buff.playerFilter or #buff.playerFilter == 0 then
		return team
	end

	if masterId == nil then
		masterId = -1
	end

	if summonId == nil then
		summonId = -1
	end

	local cnt = #team
	local filterTeam = {}

	if buff.playerFilter == "!SummonedPet" then
		for i = 1, cnt do
			if checknumber(team[i].petId) ~= summonId then
				table.insert(filterTeam, team[i])
			end
		end
	elseif buff.playerFilter == "SummonedPet" then
		for i = 1, cnt do
			if checknumber(team[i].petId) == summonId then
				table.insert(filterTeam, team[i])
			end
		end
	end

	return filterTeam
end

function FightingPowerFormula:_exePlayerLimitClazz(playerLimitClazz, playerLimitParams, team, elementRelationMap)
	if not playerLimitClazz or #playerLimitClazz == 0 then
		return true
	end

	if playerLimitClazz == "AllEffected" then
		return true
	end

	elementRelationMap = elementRelationMap or EMPTY_TB

	if playerLimitClazz == "HadRaceIds" then
		return self:_hasRaceIds(team, playerLimitParams)
	end

	if playerLimitClazz == "RaceTypeKind" then
		return self:_hasRaceTypeKind(team, playerLimitParams, elementRelationMap)
	end

	if playerLimitClazz == "RaceTypeCreature" then
		return self:_hasRaceTypeCreature(team, playerLimitParams, false, elementRelationMap)
	end

	if playerLimitClazz == "StrictRaceTypeCreature" then
		return self:_hasRaceTypeCreature(team, playerLimitParams, true, elementRelationMap)
	end

	if playerLimitClazz == "StrictRaceTypeCreatureV2" then
		return self:_hasRaceTypeCreatureV2(team, playerLimitParams, true, elementRelationMap)
	end

	if playerLimitClazz == "StrictGenderCreature" then
		return self:_hasGenderCreature(team, playerLimitParams)
	end

	if playerLimitClazz == "RaceTypeCreatureV2" then
		local arr = string.split(playerLimitParams, ",")
		local boo = true

		for i, v in ipairs(arr or {}) do
			boo = boo and self:_hasRaceTypeCreature(team, v, false, elementRelationMap)
		end

		return boo
	end

	if playerLimitClazz == "SignKind" then
		return self:_hasSignKind(team, playerLimitParams)
	end

	if playerLimitClazz == "SignCreature" then
		return self:_hasSignCreature(team, playerLimitParams)
	end

	if playerLimitClazz == "LogicExpression" then
		return self:_exeLogicExpression(team, playerLimitParams, elementRelationMap)
	end

	if playerLimitClazz == "DifferentAttributes" then
		return self:_exeDifferentAttributes(team, playerLimitParams, elementRelationMap)
	end

	if playerLimitClazz == "RaceTypeOrGender" then
		return self:_exeRaceTypeOrGender(team, playerLimitParams, elementRelationMap)
	end

	if playerLimitClazz == "GenderCreature" then
		return self:_exeGenderCreature(team, playerLimitParams)
	end

	printError(">>>>>》 FightingPowerFormula:_exePlayerLimitClazz 未实现的 BUFF 请通知前端：" .. playerLimitClazz)
end

function FightingPowerFormula:_exeRaceTypeOrGender(team, playerLimitParams, elementRelationMap)
	local arr = string.split(playerLimitParams, ",")
	local eleName = arr[1]
	local raceParam = GameEnum.Races[eleName]
	local gender = checknumber(arr[2])

	for i = 1, #team do
		local skinCo = MaterialMgr.getMatCfg(MatType.PET_SKIN, team[i].curFaceId)
		local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

		if elementRelationMap[team[i].petId] then
			local race = elementRelationMap[team[i].petId]

			if skinCo.genderId ~= gender and race ~= raceParam then
				return false
			end
		else
			local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

			for k = 1, #races do
				local raceName = races[k]

				if skinCo.genderId ~= gender and eleName ~= raceName then
					return false
				end
			end
		end
	end

	return true
end

function FightingPowerFormula:_exeDifferentAttributes(team, playerLimitParams, elementRelationMap)
	local racesMap = {}

	for i = 1, #team do
		if elementRelationMap[team[i].petId] then
			local race = elementRelationMap[team[i].petId]

			racesMap[race] = racesMap[race] or racesMap[race] + 1
		else
			local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

			for k = 1, #races do
				local race = races[k]
				local r = GameEnum.Races[race]

				racesMap[r] = racesMap[r] or racesMap[r] + 1
			end
		end
	end

	local len = table.nums(racesMap)

	return len >= checknumber(playerLimitParams)
end

function FightingPowerFormula:_exeGenderCreature(team, playerLimitParams)
	local arr = string.split(playerLimitParams, "#")
	local genderName = arr[1]
	local genderParam = GameEnum.FormationGenderId[genderName]

	if not genderParam then
		return false
	end

	local count = 0

	for i = 1, #team do
		local skinCo = MaterialMgr.getMatCfg(MatType.PET_SKIN, team[i].curFaceId)

		if skinCo.genderId == genderParam then
			count = count + 1
		end
	end

	local countRange = string.split(arr[2] or "", "-")
	local min = checknumber(countRange[1])
	local max = countRange[2] and checknumber(countRange[2]) or math.huge

	return min <= count and count <= max
end

function FightingPowerFormula:_hasRaceIds(team, playerLimitParams)
	local idsMap = {}

	for i = 1, #team do
		idsMap[team[i].raceId] = true
	end

	local success = true
	local raceIds = string.split(playerLimitParams, "||")

	for j = 1, #raceIds do
		local rIds = string.split(raceIds[j], "&&")

		success = true

		for m = 1, #rIds do
			local id = tonumber(rIds[m])

			if not idsMap[id] then
				success = nil

				break
			end
		end

		if success then
			return true
		end
	end
end

function FightingPowerFormula:_hasRaceTypeKind(team, playerLimitParams, elementRelationMap)
	local racesMap = {}

	for i = 1, #team do
		if elementRelationMap[team[i].petId] then
			local race = elementRelationMap[team[i].petId]

			racesMap[race] = true
		else
			local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

			for k = 1, #races do
				local race = GameEnum.Races[races[k]]

				racesMap[race] = true
			end
		end
	end

	local raceInfos = string.split(playerLimitParams, "#")
	local eleTypes = string.split(raceInfos[1], ",")
	local raceNums = raceInfos[2]
	local limitNum = 0

	if raceNums then
		local nums = string.split(raceNums, "-")
		local minNum = 999999

		for i = 1, #nums do
			local n = checknumber(nums[i])

			if n < minNum then
				minNum = n
			end
		end

		limitNum = minNum
	end

	local kindNum = 0

	for j = 1, #eleTypes do
		local rId = checknumber(eleTypes[j])

		if racesMap[rId] then
			kindNum = kindNum + 1
		end
	end

	return limitNum <= kindNum
end

function FightingPowerFormula:_hasRaceTypeCreature(team, playerLimitParams, isStricty, elementRelationMap)
	local raceInfos = string.split(playerLimitParams, "#")
	local eleTypes = string.split(raceInfos[1], ",")

	if not raceInfos[2] then
		local raceNums = ""
		local nums = string.split(raceNums, "-")
		local min = checknumber(nums[1])
		local eleList = {}

		for j, eleName in ipairs(eleTypes) do
			local r = GameEnum.Races[eleName]

			table.insert(eleList, r)
		end

		local count = 0

		for i = 1, #team do
			if elementRelationMap[team[i].petId] then
				local race = elementRelationMap[team[i].petId]

				if table.indexof(eleList, race) ~= false then
					count = count + 1
				elseif isStricty == true then
					return false
				end
			else
				local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

				for k = 1, #races do
					local race = races[k]

					if table.indexof(eleTypes, race) ~= false then
						count = count + 1
					elseif isStricty == true then
						return false
					end
				end
			end
		end

		return min <= count and count <= ((nums[2] or nil) and checknumber(nums[2]))
	end
end

function FightingPowerFormula:_hasRaceTypeCreatureV2(team, playerLimitParams, isStricty, elementRelationMap)
	local raceList = {}
	local numList = {}
	local eleList = {}
	local raceInfos = string.split(playerLimitParams, ",")

	for i, v in ipairs(raceInfos) do
		local eleTypes = string.split(v, "#")

		if not eleTypes[1] then
			local raceType = ""

			if not eleTypes[2] then
				local raceNums = ""
				local r = GameEnum.Races[raceType]

				table.insert(eleList, r)
				table.insert(raceList, raceType)
				table.insert(numList, raceNums)
			end
		end
	end

	local countMap = {}

	for i = 1, #team do
		if elementRelationMap[team[i].petId] then
			local race = elementRelationMap[team[i].petId]
			local raceType = table.keyof(GameEnum.Races, race)
			local idx = table.indexof(eleList, race)

			if idx ~= false and raceType then
				countMap[raceType] = checknumber(countMap[raceType]) + 1
			elseif isStricty == true then
				return false
			end
		else
			local races = PetSkinConfig.instance:getAllElementAttrs(team[i].curFaceId)

			for k = 1, #races do
				local race = races[k]
				local idx = table.indexof(raceList, race)

				if idx ~= false then
					countMap[race] = checknumber(countMap[race]) + 1
				elseif isStricty == true then
					return false
				end
			end
		end
	end

	local canPass = true

	for i, v in ipairs(raceList) do
		local count = checknumber(countMap[v])
		local raceNums = numList[i]
		local nums = string.split(raceNums, "-")
		local min = checknumber(nums[1])
		local boo = min <= count and count <= ((nums[2] or nil) and checknumber(nums[2]))

		if not boo then
			return false
		end

		canPass = canPass and boo
	end

	return canPass
end

function FightingPowerFormula:_hasGenderCreature(team, playerLimitParams)
	local genderInfos = string.split(playerLimitParams, "#")
	local genderNums = checknumber(genderInfos[2])
	local gender = genderInfos[1] == "男性" and 2 or 1
	local count = 0
	local count2 = 0

	for i = 1, #team do
		local skinCo = MaterialMgr.getMatCfg(MatType.PET_SKIN, team[i].curFaceId)

		if skinCo.genderId == gender then
			count = count + 1
		else
			count2 = count2 + 1
		end
	end

	return genderNums <= count and count2 == 0
end

function FightingPowerFormula:_hasSignKind(team, playerLimitParams)
	local signsMap = {}

	for i = 1, #team do
		local petCo = CharacterConfig.instance:getPetCo(team[i].raceId)
		local signs = string.split(petCo.signs, ",")

		for k = 1, #signs do
			signsMap[signs[k]] = true
		end
	end

	local signsInfos = string.split(playerLimitParams, "#")
	local signsTypes = string.split(signsInfos[1], ",")
	local kindNum = 0

	for j = 1, #signsTypes do
		local sign = signsTypes[j]

		if signsMap[sign] then
			kindNum = kindNum + 1
		end
	end

	local signsNums = signsInfos[2]

	if signsNums then
		local nums = string.split(signsNums, "-")
		local boo = false

		for i = 1, #nums do
			local n = checknumber(nums[i])

			if i == 1 then
				if n <= kindNum then
					boo = true
				end
			elseif n < kindNum then
				boo = false
			end
		end

		return boo
	end

	return false
end

function FightingPowerFormula:_hasSignCreature(team, playerLimitParams)
	local signsMap = {}

	for i = 1, #team do
		local petCo = CharacterConfig.instance:getPetCo(team[i].raceId)
		local signs = string.split(petCo.signs, ",")

		for k = 1, #signs do
			if not signsMap[signs[k]] then
				local num = 0

				signsMap[signs[k]] = num + 1
			end
		end
	end

	local signsInfos = string.split(playerLimitParams, "#")
	local signsTypes = string.split(signsInfos[1], ",")
	local signsNums = signsInfos[2]
	local limitNum = 0

	if signsNums then
		local nums = string.split(signsNums, "-")
		local minNum = 999999

		for i = 1, #nums do
			local n = checknumber(nums[i])

			if n < minNum then
				minNum = n
			end
		end

		limitNum = minNum
	end

	local kindNum = 0

	for j = 1, #signsTypes do
		local sign = signsTypes[j]

		if signsMap[sign] then
			kindNum = kindNum + signsMap[sign]
		end
	end

	return limitNum <= kindNum
end

function FightingPowerFormula:_exeLogicExpression(team, playerLimitParams, elementRelationMap)
	local exps = string.split(playerLimitParams, "&&")

	for i = 1, #exps do
		local playerLimit = string.split(exps[i], "$")

		if not self:_exePlayerLimitClazz(playerLimit[1], playerLimit[2], team, elementRelationMap) then
			return
		end
	end

	return true
end

function FightingPowerFormula:_exePetFilter(petMo, filter)
	if not filter or #filter == 0 then
		return true
	else
		return GameUtil.expScript(filter, GameUtil.handler(self.OnFilter, self, petMo))
	end
end

function FightingPowerFormula:OnFilter(petMo, str)
	local arr = string.split(str, "$")
	local type = arr[1]

	if type == "Race" then
		if checknumber(arr[2]) == petMo.raceId then
			return true
		end
	elseif type == "RaceType" then
		return PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, arr[2])
	elseif type == "Signs" then
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)

		if cfg then
			local tem = string.split(cfg.signs, ",")
			local idx = table.indexof(tem, arr[2])

			return idx ~= false
		end
	elseif type == "Level" then
		local str = arr[2]
		local tem = string.split(str, ",")
		local tt = tem[1]
		local myLvl = petMo.level
		local lvl = checknumber(tem[2])

		return self:_compareByParam(tt, myLvl, lvl)
	elseif type == "SummonedPet" then
		if petMo.isSummonedPet then
			return petMo:isSummonedPet()
		else
			return petMo.summonMasterId > 0
		end
	elseif type == "InitRare" then
		local str = arr[2]
		local tem = string.split(str, ",")
		local tt = tem[1]
		local myLvl = CharacterConfig.instance:getInitRare(petMo.raceId)
		local lvl = checknumber(tem[2])

		return self:_compareByParam(tt, myLvl, lvl)
	elseif type == "AwakenLevel" then
		local str = arr[2]
		local tem = string.split(str, ",")
		local tt = tem[1]
		local myLvl = petMo:getAwakenLv()
		local lvl = checknumber(tem[2])

		return self:_compareByParam(tt, myLvl, lvl)
	elseif type == "Job" then
		local jobId = checknumber(GameEnum.JobZh[arr[2]])

		return PetSkinConfig.instance:checkHasJob(petMo.curFaceId, jobId)
	elseif type == "Gender" then
		return PetSkinConfig.instance:checkIsSameGender(petMo.curFaceId, checknumber(arr[2]))
	end

	return false
end

function FightingPowerFormula:_compareByParam(tt, myLvl, lvl)
	if tt == GameEnum.GREATER_THAN then
		return lvl < myLvl
	elseif tt == GameEnum.GREATER_THAN_OR_EQUAL_TO then
		return lvl <= myLvl
	elseif tt == GameEnum.LESS_THAN then
		return myLvl < lvl
	elseif tt == GameEnum.LESS_THAN_OR_EQUAL_TO then
		return myLvl <= lvl
	elseif tt == GameEnum.EQUAL_TO then
		return myLvl == lvl
	end

	return false
end

FightingPowerFormula.instance = FightingPowerFormula.New()

return FightingPowerFormula
