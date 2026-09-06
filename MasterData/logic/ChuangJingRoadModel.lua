-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadModel.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadModel", package.seeall)

local ChuangJingRoadModel = class("ChuangJingRoadModel")

ChuangJingRoadModel.ZONE_LIGHT = 1
ChuangJingRoadModel.ZONE_WATER = 2
ChuangJingRoadModel.ZONE_FIRE = 3
ChuangJingRoadModel.ZONE_GRASS = 4
ChuangJingRoadModel.ZONE_DARK = 5

function ChuangJingRoadModel:onInit()
	self:onReset()
end

function ChuangJingRoadModel:onReset()
	self._infoMap = {}
	self._petInfoMap = {}
	self._petMoMap = {}
	self._fistPassMap = {}
	self._rankMap = {}
end

function ChuangJingRoadModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function ChuangJingRoadModel:getPetInfo(activityId)
	return self._petInfoMap[activityId]
end

function ChuangJingRoadModel:getFirstPassInfo(activityId, zoneId)
	if self._fistPassMap[activityId] then
		return self._fistPassMap[activityId][zoneId]
	end
end

function ChuangJingRoadModel:getRankInfo(activityId, zoneId)
	if self._rankMap[activityId] then
		return self._rankMap[activityId][zoneId]
	end
end

function ChuangJingRoadModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = GameUtil.pbToTable(msg)
end

function ChuangJingRoadModel:onGetPetInfo(msg)
	local activityId = msg.activityId

	self._petInfoMap[activityId] = GameUtil.pbToTable(msg)
end

function ChuangJingRoadModel:onGetRank(msg)
	local activityId = msg.activityId
	local zoneId = msg.zoneId

	self._rankMap[activityId] = self._rankMap[activityId] or {}
	self._rankMap[activityId][zoneId] = GameUtil.pbToTable(msg)
end

function ChuangJingRoadModel:onGetFirstTeamInfo(msg)
	local activityId = msg.activityId
	local zoneId = msg.zoneId

	self._fistPassMap[activityId] = self._fistPassMap[activityId] or {}
	self._fistPassMap[activityId][zoneId] = GameUtil.pbToTable(msg)
end

function ChuangJingRoadModel:onBuyPet(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.unlockCreepIds = info.unlockCreepIds or {}

		local newCreepIds = msg.newCreepIds

		for i, v in ipairs(newCreepIds) do
			if table.indexof(info.unlockCreepIds, v) == false then
				table.insert(info.unlockCreepIds, v)
			end
		end
	end
end

function ChuangJingRoadModel:onEquipLvlUp(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.equipmentLv = msg.equipmentLv
	end
end

function ChuangJingRoadModel:onPetLvlUp(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.level = msg.level
	end
end

function ChuangJingRoadModel:onHolyStripeLvlUp(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.holyStripeLv = msg.holyStripeLv
	end
end

function ChuangJingRoadModel:onStarGodLvlUp(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.starGodPlusLv = msg.starGodPlusLv
	end
end

function ChuangJingRoadModel:onAwakenLvlUp(msg)
	local activityId = msg.activityId
	local info = self._petInfoMap[activityId]

	if info then
		info.awakenLv = msg.awakenLv
	end
end

function ChuangJingRoadModel:onGetePrize(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		local zones = info.zones

		if zones then
			for i, v in ipairs(zones) do
				if v.zoneId == msg.zoneId then
					v.gainProgressPrizeId = v.gainProgressPrizeId or {}

					table.insert(v.gainProgressPrizeId, msg.prizeId)
				end
			end
		end
	end
end

function ChuangJingRoadModel:onResetBossFight(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		local zones = info.zones

		if zones then
			for i, v in ipairs(zones) do
				if v.zoneId == msg.zoneId then
					if msg.zoneId == ChuangJingRoadModel.ZONE_WATER then
						v.waterBoss = v.waterBoss or {}

						if checknumber(msg.param) == 0 then
							v.waterBoss.teamABanRaceIds = {}
							v.waterBoss.teamADamage = 0
						else
							v.waterBoss.teamBanRaceIds = {}
							v.waterBoss.teamBDamage = 0
						end
					elseif msg.zoneId == ChuangJingRoadModel.ZONE_FIRE then
						v.fireBoss = v.fireBoss or {}

						if checknumber(msg.param) == 0 then
							v.fireBoss.teamABanRaceIds = {}
							v.fireBoss.teamALeftPetNum = 0
						else
							v.fireBoss.teamBanRaceIds = {}
							v.fireBoss.teamBLeftPetNum = 0
						end
					end
				end
			end
		end
	end
end

function ChuangJingRoadModel:getPetMoMap(activityId)
	local map = self._petMoMap[activityId]

	if map == nil then
		map = {}

		local temp = ChuangJingRoadConfig.instance:getSupportListById(activityId) or {}

		for k, v in pairs(temp) do
			local petMo = self:createCfgPetMo(activityId, v)

			map[petMo.petId] = petMo
		end

		self._petMoMap[activityId] = map
	end

	return map
end

function ChuangJingRoadModel:createCfgPetMo(activityId, creepCo)
	local petMo = BagPetMo.New()

	petMo.isMyPackPet = false
	petMo.isSupportedPet = true
	petMo.raceId = creepCo.raceId
	petMo.petId = creepCo.creepsId
	petMo.level = creepCo.lv
	petMo.curFaceId = checknumber(creepCo.faceId)

	if checknumber(petMo.curFaceId) == 0 then
		petMo.curFaceId = checknumber(petMo.raceId)
	end

	petMo:setAttrMo()

	self.awakenLv = 0
	petMo.awakeLevel = 0
	petMo.talentLevel = creepCo.talentLv
	petMo.summonMasterId = checknumber(creepCo.summonMasterId)
	petMo.summonedPetId = checknumber(creepCo.summonedPetId)
	petMo.carriedMasterId = checknumber(creepCo.carriedMasterId)
	petMo.carriedPetId = checknumber(creepCo.carriedPetId)
	petMo.heavenAwakenMasterId = checknumber(creepCo.heavenAwakenMasterId)
	petMo.heavenAwakenSummonPetId = checknumber(creepCo.heavenAwakenSummonPetId)
	petMo.oracleMasterId = checknumber(creepCo.oracleMasterId)
	petMo.oraclePetId = checknumber(creepCo.oraclePetId)
	petMo.oraclePetRaceId = checknumber(creepCo.oraclePetRaceId)
	petMo.bookSpiritPetId = checknumber(creepCo.bookSpiritPetId)
	petMo.bookSpiritRaceId = checknumber(creepCo.bookSpiritRaceId)

	local petCo = CharacterConfig.instance:getPetCo(creepCo.raceId)
	local skillLevelStrategyId = petCo.skillLevelStrategyId
	local normalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.NORMAL)
	local ultimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.ULTIMATE)
	local passiveSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PASSIVE)
	local psychicedNormalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_NORMAL)
	local psychicedUltimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_ULTIMATE)

	petMo.contractSkillId = checknumber(creepCo.contractSkillId)
	petMo.normalSkillLv = normalSkillLv
	petMo.ultimateSkillLv = ultimateSkillLv
	petMo.passiveSkillLv = passiveSkillLv
	petMo.psychicedUltimateSkillLv = psychicedUltimateSkillLv
	petMo.psychicedNormalSkillLv = psychicedNormalSkillLv
	petMo.starGodPlusSlots = {}

	local fixedStarGodId = creepCo.fixedStarGodId

	if fixedStarGodId then
		for i, v in ipairs(fixedStarGodId) do
			local star = {}

			star.slot = i
			star.exp = 0
			star.fillerDefineId = v

			table.insert(petMo.starGodPlusSlots, star)
		end
	end

	petMo.equipments = {}

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	for i = 1, 4 do
		local eqCfg = ChuangJingRoadConfig.instance:getEquipCfg(activityId, firstJobIdx, i, 0)
		local obj = {}

		obj.positionId = i
		obj.defineId = eqCfg.defineId
		obj.lv = 0
		obj.levelExt = 0

		table.insert(petMo.equipments, obj)
	end

	petMo:calcAllAttr()

	return petMo
end

function ChuangJingRoadModel:updatePetMo(activityId, petMo, level, awakenLv, equipmentLv, starGodPlusLv, holyStripeLv)
	local lvlCfg = ChuangJingRoadConfig.instance:getLevelCostById(activityId, level) or {}

	petMo.level = checknumber(lvlCfg.lv)
	petMo.talentLevel = checknumber(lvlCfg.talentLv)

	local awakenCfg = ChuangJingRoadConfig.instance:getAwakenCostById(activityId, awakenLv) or {}

	petMo.awakeLevel = checknumber(awakenCfg.level)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	for i, obj in ipairs(petMo.equipments) do
		local eqCfg = ChuangJingRoadConfig.instance:getEquipCfg(activityId, firstJobIdx, i, equipmentLv)

		obj.defineId = eqCfg.defineId
		obj.lv = eqCfg.equipmentLv
		obj.levelExt = eqCfg.level
	end

	if starGodPlusLv > 0 then
		local starGodCfg = ChuangJingRoadConfig.instance:getStarGodCostById(activityId, starGodPlusLv) or {}
		local starGodLv = checknumber(starGodCfg.starGodLv)

		for i, star in ipairs(petMo.starGodPlusSlots) do
			local slotCfg = StargodplusConfig.instance:getSlotCfg(i)
			local cc = StargodplusConfig.instance:getSlotLvPlanByLv(slotCfg.slotLvPlan, starGodLv) or {}

			star.exp = checknumber(cc.exp)
		end
	end

	local hsList = ChuangJingRoadConfig.instance:getHolyStripeListById(activityId) or {}
	local res = {}

	for key, cfgMap in pairs(hsList) do
		local cfg = cfgMap[holyStripeLv]

		if cfg then
			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.extproperties) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	petMo.extpropertiesArr = res

	petMo:calcAllAttr()

	return petMo
end

ChuangJingRoadModel.instance = ChuangJingRoadModel.New()

return ChuangJingRoadModel
