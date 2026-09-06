-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/model/RecommendFmtModel.lua

module("logic.extensions.recommendfmt.model.RecommendFmtModel", package.seeall)

local RecommendFmtModel = class("RecommendFmtModel", BaseModel)

function RecommendFmtModel:ctor()
	RecommendFmtModel.super.ctor(self)
end

function RecommendFmtModel:onInit()
	self:onReset()
end

function RecommendFmtModel:onReset()
	self.petMap = nil
	self.formationMO = FormationMO.New(function(petId)
		return self:getPet(petId)
	end)
	self.activityId = -1
	self.curMaxZdl = 0
	self.posLvList = {}
	self.rankInfoList = {}
	self.myRank = -1
	self.posList = {}
	self.recommendMap = {}
	self.maxFmoPower = 0
	self.curHeroSkillId = 0
end

function RecommendFmtModel:onRecommendFormGetInfo(msg)
	self.activityId = msg.activityId
	self.curMaxZdl = msg.curMaxZdl
	self.rankInfoList = msg.rankInfoList
	self.myRank = msg.myRank
	self.posLvList = GameUtil.pbToTable(msg.posLvList)

	self:initMaxFmo()
end

function RecommendFmtModel:getPetPosMap()
	local posLvMap = {}

	for i, v in ipairs(self.posLvList or {}) do
		posLvMap[checknumber(v.posId)] = v
	end

	return posLvMap
end

function RecommendFmtModel:updatePetLv(posId, petId, petLv)
	local has = false

	self.posLvList = self.posLvList or {}

	for i, v in ipairs(self.posLvList) do
		if v.posId == posId then
			has = true
			v.petId = petId
			v.petLv = petLv

			break
		end
	end

	if has == false then
		local obj = {}

		obj.posId = posId
		obj.petId = petId
		obj.petLv = petLv

		table.insert(self.posLvList, obj)
	end
end

function RecommendFmtModel:onRecommendFormGetRank(msg)
	self.activityId = msg.activityId
	self.rankInfoList = msg.rankInfoList
	self.myRank = msg.myRank
end

function RecommendFmtModel:onUpdateCheckFmt(msg)
	self.curMaxZdl = math.max(self.curMaxZdl, msg.newZdl)
	self.myRank = msg.myRank
end

function RecommendFmtModel:initMaxFmo()
	local positions = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	local teams = {}
	local _curMasterId = 0
	local _targetId = 0
	local curFaceId = 0
	local masterId = 0
	local summonId = 0

	self.posList = {}
	self.recommendMap = {}
	self.curFormCfg = RecommendFmtConfig.instance:getFmtMaxCfg(self.activityId)
	self.creepCfg = RecommendFmtConfig.instance:getFmtCreeps(self.activityId)

	for i, creepCo in pairs(self.creepCfg or {}) do
		local curFaceId = checknumber(creepCo.faceId)

		if checknumber(curFaceId) == 0 then
			curFaceId = checknumber(creepCo.raceId)
		end

		local petMo = FightingPowerPetMo.getRealMaxPetMo(creepCo.raceId, curFaceId)

		petMo.petId = self:createPetId(self.activityId, creepCo.creepsId)

		if checknumber(creepCo.summonMasterId) > 0 then
			petMo.summonMasterId = self:createPetId(self.activityId, checknumber(creepCo.summonMasterId))
			summonId = petMo.petId
		end

		if checknumber(creepCo.summonedPetId) > 0 then
			petMo.summonedPetId = self:createPetId(self.activityId, checknumber(creepCo.summonedPetId))
			masterId = petMo.petId
		end

		petMo.contractSkillId = checknumber(creepCo.contractSkillId)
		self.posList[creepCo.posId] = petMo
		self.recommendMap[petMo.petId] = petMo

		table.insert(teams, petMo)

		positions[creepCo.posId] = petMo.petId

		local elementalMasterId = checknumber(creepCo.elementalMasterId)
		local elementalTargetId = checknumber(creepCo.elementalTargetId)

		if elementalMasterId > 0 then
			_curMasterId = elementalMasterId
			curFaceId = petMo.curFaceId
		end

		if elementalTargetId > 0 then
			_targetId = elementalTargetId
		end
	end

	local _elementRelationMap = {}

	if _targetId > 0 then
		_elementRelationMap[_targetId] = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)
	end

	local heroSkillId = self:getheroSkillId(self.curFormCfg, teams)

	self.curHeroSkillId = heroSkillId

	local fid = 0
	local flvl = 0
	local info = self:_refreshBuffForm(positions, function(petId)
		return self.recommendMap[petId]
	end)

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = 20
	end

	local cutePetRaceId, cutePetQuality = 0, 0

	self.maxFmoPower = FightingPowerFormula.instance:getTeamFightingPower(teams, heroSkillId, fid, flvl, _elementRelationMap, cutePetRaceId, cutePetQuality, masterId, summonId)
end

function RecommendFmtModel:_refreshBuffForm(positions, getPetCallBack)
	local cfgs = BattleConfig.instance:getFormStrengthTriggerCfgs()
	local posDataList = {}
	local compA = 0

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = getPetCallBack and getPetCallBack(petId) or self:_getPet(petId)

			if mo and mo.summonMasterId <= 0 then
				table.insert(posDataList, i)

				compA = compA + math.pow(2, i)
			end
		end
	end

	local fsMap = FormationNewModel.instance:getAllFormStrengthInfo()

	for k, v in pairs(fsMap or {}) do
		local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(v.formStrengthId)

		if posCfg then
			local posList = posCfg.posList

			if posList and #posList == #posDataList then
				local compB = 0

				for i = 1, #posList do
					local pp_b = posList[i]

					compB = compB + math.pow(2, pp_b)
				end

				if compA == compB then
					return v
				end
			end
		end
	end
end

function RecommendFmtModel:GetFormStrengthIdAndLv(formationMO)
	local fid = 0
	local flvl = 0
	local info = formationMO:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, 20
end

function RecommendFmtModel:initData()
	self.petMap = {}

	local list = RecommendFmtConfig.instance:getCfgsList()

	for i, cfg in ipairs(list) do
		local creepCfg = ChallengeConfig.instance:getCreepCfg(cfg.fightId)

		if creepCfg then
			for i, creepCo in pairs(creepCfg) do
				local curFaceId = creepCo.faceId

				if checknumber(curFaceId) == 0 then
					curFaceId = creepCo.raceId
				end

				local petMo = FightingPowerPetMo.getRealMaxPetMo(creepCo.raceId, curFaceId)

				petMo.petId = self:createPetId(cfg.fightId, creepCo.creepsId)

				if checknumber(creepCo.summonMasterId) > 0 then
					petMo.summonMasterId = self:createPetId(cfg.fightId, checknumber(creepCo.summonMasterId))
				end

				if checknumber(creepCo.summonedPetId) > 0 then
					petMo.summonedPetId = self:createPetId(cfg.fightId, checknumber(creepCo.summonedPetId))
				end

				petMo.contractSkillId = checknumber(creepCo.contractSkillId)
				self.petMap[petMo.petId] = petMo
			end
		end
	end
end

function RecommendFmtModel:createPetId(fightId, i)
	return checknumber(fightId .. "" .. i)
end

function RecommendFmtModel:getPet(petId)
	if self.petMap then
		return self.petMap[petId]
	end
end

function RecommendFmtModel:getPetMax(petId)
	if self.recommendMap then
		return self.recommendMap[petId]
	end
end

function RecommendFmtModel:intFmtData(fightId)
	self.petMap = self.petMap or {}

	local creepCfg = ChallengeConfig.instance:getCreepCfg(fightId)

	if creepCfg then
		for i, creepCo in pairs(creepCfg) do
			local petId = self:createPetId(fightId, creepCo.creepsId)

			if self.petMap[petId] == nil then
				local curFaceId = creepCo.faceId

				if checknumber(curFaceId) == 0 then
					curFaceId = creepCo.raceId
				end

				local petMo = FightingPowerPetMo.getRealMaxPetMo(creepCo.raceId, curFaceId)

				petMo.petId = petId

				if checknumber(creepCo.summonMasterId) > 0 then
					petMo.summonMasterId = self:createPetId(fightId, checknumber(creepCo.summonMasterId))
				end

				if checknumber(creepCo.summonedPetId) > 0 then
					petMo.summonedPetId = self:createPetId(fightId, checknumber(creepCo.summonedPetId))
				end

				petMo.contractSkillId = checknumber(creepCo.contractSkillId)
				self.petMap[petMo.petId] = petMo
			end
		end
	end
end

function RecommendFmtModel:setFmt(id)
	local cfg = RecommendFmtConfig.instance:getCfgsById(id)
	local posList = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	if cfg then
		self:intFmtData(cfg.fightId)

		local creepCfg = ChallengeConfig.instance:getCreepCfg(cfg.fightId)
		local mcfg = ChallengeConfig.instance:getMissionCfg(cfg.fightId)

		if creepCfg then
			local teams = {}

			for i, creepCo in pairs(creepCfg) do
				local petId = self:createPetId(cfg.fightId, creepCo.creepsId)

				posList[creepCo.posId] = petId

				table.insert(teams, self:getPet(petId))
			end

			local heroSkillId = self:getheroSkillId(mcfg, teams)

			self.formationMO:SetHeroSkillId(heroSkillId)
		end
	end

	self.formationMO:setPositionForce(posList)
end

function RecommendFmtModel:setPhycgucFmt(id)
	local cfg = RecommendFmtConfig.instance:getPsychicCfg(id)
	local posList = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	if cfg then
		self:intFmtData(cfg.fightId)

		local creepCfg = ChallengeConfig.instance:getCreepCfg(cfg.fightId)
		local mcfg = ChallengeConfig.instance:getMissionCfg(cfg.fightId)

		if creepCfg then
			local teams = {}

			for i, creepCo in pairs(creepCfg) do
				local petId = self:createPetId(cfg.fightId, creepCo.creepsId)

				posList[creepCo.posId] = petId

				table.insert(teams, self:getPet(petId))
			end

			local heroSkillId = self:getheroSkillId(mcfg, teams)

			self.formationMO:SetHeroSkillId(heroSkillId)
		end
	end

	self.formationMO:setPositionForce(posList)
end

function RecommendFmtModel:getheroSkillId(monsterCo, teams)
	local heroSkillId = 0

	if monsterCo and monsterCo.heroSkillId then
		heroSkillId = checknumber(monsterCo.heroSkillId)
	end

	if heroSkillId <= 0 and teams then
		local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams)

		if heroSkillIs and #heroSkillIs > 0 then
			heroSkillId = heroSkillIs[1]
		end
	end

	return heroSkillId
end

function RecommendFmtModel:getFmt()
	return self.formationMO
end

function RecommendFmtModel:getTabList()
	local list = RecommendFmtConfig.instance:getCfgsList()
	local res = {}

	for i, cfg in ipairs(list) do
		if checknumber(cfg.isOnline) == 1 then
			table.insert(res, cfg)
		end
	end

	ArraySort.sortOn(res, "order", ArraySort.NUMERIC)

	return res
end

function RecommendFmtModel:getPsychicTabList()
	local list = RecommendFmtConfig.instance:getPsychicCfgsList()
	local res = {}

	for i, cfg in ipairs(list) do
		if checknumber(cfg.isOnline) == 1 then
			res[cfg.raceId] = res[cfg.raceId] or {}

			table.insert(res[cfg.raceId], cfg)
		end
	end

	local finalList = {}

	for raceId, cfgs in pairs(res) do
		ArraySort.sortOn(cfgs, "order", ArraySort.NUMERIC)
		table.insert(finalList, {
			raceId = raceId,
			cfgs = cfgs
		})
	end

	ArraySort.sortOn(finalList, "raceId", ArraySort.NUMERIC)

	return finalList
end

RecommendFmtModel.instance = RecommendFmtModel.New()

return RecommendFmtModel
