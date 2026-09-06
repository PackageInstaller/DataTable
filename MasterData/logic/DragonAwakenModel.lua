-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/model/DragonAwakenModel.lua

module("logic.extensions.dragonawaken.model.DragonAwakenModel", package.seeall)

local DragonAwakenModel = class("DragonAwakenModel", BaseModel)

function DragonAwakenModel:ctor()
	return
end

function DragonAwakenModel:onInit()
	self:onReset()
end

function DragonAwakenModel:onReset()
	self._baseInfoList = {}
	self._rankInfoList = {}
	self._petMoMap = {}
	self._curBaseInfo = nil
	self._lastTrainResult = nil
end

function DragonAwakenModel:setCurActId(actId)
	self._curBaseInfo = self._baseInfoList[actId]
end

function DragonAwakenModel:getCurBaseInfo()
	return self._curBaseInfo
end

function DragonAwakenModel:getBaseInfoByActId(actId)
	if not self._baseInfoList[actId] then
		printInfo("龙脉觉醒数据未初始化")
	end

	return self._baseInfoList[actId]
end

function DragonAwakenModel:getRankInfoByActId(actId)
	if not self._rankInfoList[actId] then
		printInfo("龙脉觉醒排行榜数据未初始化")
	end

	return self._rankInfoList[actId]
end

function DragonAwakenModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoList[info.activityId] = info
end

function DragonAwakenModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfoList[info.activityId] = info
end

function DragonAwakenModel:onNotifyTraining(msg)
	local info = GameUtil.pbToTable(msg)
	local hard = info.hard

	self._lastTrainResult = info

	self:_saveCurTrainingHard(info.activityId, hard)
end

function DragonAwakenModel:getLastTrainResult()
	return self._lastTrainResult
end

function DragonAwakenModel:onConfirmTrainingResult(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfoByActId(info.activityId)

	baseInfo.todayTrainingTimes = info.todayTrainingTimes
	baseInfo.trainingFormList = info.trainingFormList

	self:resetCurTrainingHard(info.activityId)
end

function DragonAwakenModel:onRandomTrainingForm(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfoByActId(info.activityId)

	baseInfo.trainingFormList = info.trainingFormList

	self:resetCurTrainingHard(info.activityId)
end

function DragonAwakenModel:onUpgrade(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfoByActId(info.activityId)

	if not baseInfo.strengthLvList then
		for i, data in ipairs(baseInfo.strengthLvList) do
			if info.strengthLv.strengthType == data.strengthType then
				data.level = info.strengthLv.level
			end
		end
	end
end

function DragonAwakenModel:onBuyPet(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfoByActId(info.activityId)

	baseInfo.unlockCreepIds = info.newCreepIds
end

function DragonAwakenModel:onNotifyFightRes(msg)
	local info = GameUtil.pbToTable(msg)

	if info.isWin then
		local baseInfo = self:getBaseInfoByActId(info.activityId)

		baseInfo.curPhaseId = info.curPhaseId
		baseInfo.curStageId = info.curStageId
	end
end

function DragonAwakenModel:_saveCurTrainingHard(actId, hard)
	local saveKey = self:_getSaveHardUserDataKey(actId)

	GameUtil.saveUserDayData(saveKey, checknumber(hard))
end

function DragonAwakenModel:resetCurTrainingHard(actId)
	self:_saveCurTrainingHard(actId, 0)
end

function DragonAwakenModel:getCurTrainingHard(actId)
	local saveKey = self:_getSaveHardUserDataKey(actId)

	return checknumber(GameUtil.getUserDayData(saveKey))
end

function DragonAwakenModel:_getSaveHardUserDataKey(actId)
	return "Dragon_Awaken_Cur_Training_Hard_" .. actId
end

function DragonAwakenModel:getCurCreepIds(actId)
	local baseInfo = self:getBaseInfoByActId(actId)
	local creepIds = {}

	if baseInfo then
		local curPhaseId = baseInfo.curPhaseId

		if not baseInfo.unlockCreepIds then
			for i, creepId in ipairs(baseInfo.unlockCreepIds) do
				local supportCfg = DragonAwakenConfig.instance:getSupportCfgById(actId, creepId)

				if supportCfg.mustFormPhase == 0 or supportCfg.mustFormPhase == curPhaseId then
					table.insert(creepIds, creepId)
				end
			end
		end
	end

	return creepIds
end

function DragonAwakenModel:getCurUpgradeLevelByType(actId, type)
	local level = -1
	local baseInfo = self:getBaseInfoByActId(actId)

	if baseInfo then
		if not baseInfo.strengthLvList then
			for i, upgradeInfo in ipairs(baseInfo.strengthLvList) do
				if upgradeInfo.strengthType == type then
					return upgradeInfo.level
				end
			end
		end
	end

	return level
end

function DragonAwakenModel:getPetMoMap(activityId)
	local map = self._petMoMap[activityId]

	if map == nil then
		map = {}

		local temp = DragonAwakenConfig.instance:getAllSupportCfgs(activityId) or {}

		for k, v in pairs(temp) do
			local petMo = self:createCfgPetMo(activityId, v)

			map[petMo.petId] = petMo
		end

		self._petMoMap[activityId] = map
	end

	return map
end

function DragonAwakenModel:createCfgPetMo(activityId, creepCo)
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
	petMo.oracleMasterId = checknumber(creepCo.oracleMasterId)
	petMo.oraclePetId = checknumber(creepCo.oraclePetId)
	petMo.oraclePetRaceId = checknumber(creepCo.oraclePetRaceId)
	petMo.heavenAwakenMasterId = checknumber(creepCo.heavenAwakenMasterId)
	petMo.heavenAwakenSummonPetId = checknumber(creepCo.heavenAwakenSummonPetId)
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
		local eqCfg = DragonAwakenConfig.instance:getEquipCfg(activityId, firstJobIdx, i, 0)
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

function DragonAwakenModel:updatePetMo(activityId, petMo, level, awakenLv, equipmentLv, starGodPlusLv, holyStripeLv)
	local lvlCfg = DragonAwakenConfig.instance:getPetLvUpCostById(activityId, level) or {}

	petMo.level = checknumber(lvlCfg.lv)
	petMo.talentLevel = checknumber(lvlCfg.talentLv)

	local awakenCfg = DragonAwakenConfig.instance:getAwakenCostCfgByLv(activityId, awakenLv) or {}

	petMo.awakeLevel = checknumber(awakenCfg.level)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	for i, obj in ipairs(petMo.equipments) do
		local eqCfg = DragonAwakenConfig.instance:getEquipCfg(activityId, firstJobIdx, i, equipmentLv)

		obj.defineId = eqCfg.defineId
		obj.lv = eqCfg.equipmentLv
		obj.levelExt = eqCfg.level
	end

	if starGodPlusLv > 0 then
		local starGodCfg = DragonAwakenConfig.instance:getStarGodCfgByLv(activityId, starGodPlusLv) or {}
		local starGodLv = checknumber(starGodCfg.starGodLv)

		for i, star in ipairs(petMo.starGodPlusSlots) do
			local slotCfg = StargodplusConfig.instance:getSlotCfg(i)
			local cc = StargodplusConfig.instance:getSlotLvPlanByLv(slotCfg.slotLvPlan, starGodLv) or {}

			star.exp = checknumber(cc.exp)
		end
	end

	local hsList = DragonAwakenConfig.instance:getHolyStripeCfgs(activityId) or {}
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

DragonAwakenModel.instance = DragonAwakenModel.New()

return DragonAwakenModel
