-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/model/FireDimensionModel.lua

module("logic.extensions.firedimension.model.FireDimensionModel", package.seeall)

local FireDimensionModel = class("FireDimensionModel", BaseModel)

function FireDimensionModel:ctor()
	return
end

function FireDimensionModel:onInit()
	self:onReset()
end

function FireDimensionModel:onReset()
	self._activityId = 274001
	self._stageId = 0
	self._actStateMap = {}
	self._finishNum = 0
	self._stageInfo = nil
	self._actStageInfoMap = {}
	self._actDailyBuffLvMap = {}
	self._actIsGainBuffMap = {}
	self._tempStageId = 0
	self._tempTeamId = 0
	self._isWin = false
	self._isNextStage = false
	self._customFmtMo = nil
	self.formationMO = FormationMO.New(function(petId)
		return self:getPet(petId)
	end)
	self.petMap = nil
	self._fpFmo = nil
end

function FireDimensionModel:onFireDimensionClgInfoRes(msg)
	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._actStateMap[msg.activityId] = msg.stageId
	self._finishNum = msg.finishNum

	if msg:HasField("stageInfo") then
		self._stageInfo = GameUtil.pbToTable(msg.stageInfo)
		self._stageInfo.banTeamIds = self._stageInfo.banTeamIds or {}
		self._stageInfo.finishedTeamids = self._stageInfo.finishedTeamids or {}
	else
		self._stageInfo = nil
	end

	self._actStageInfoMap[msg.activityId] = self._stageInfo
	self._isGainDailyBuff = msg.hasSignInToday
	self._dailyBuffLv = msg.signInBuffLv
	self._actDailyBuffLvMap[msg.activityId] = self._dailyBuffLv
	self._actIsGainBuffMap[msg.activityId] = self._isGainDailyBuff
end

function FireDimensionModel:onFireDimensionChallengeRes(msg)
	self._tempStageId = msg.stageId
	self._tempTeamId = msg.teamId
end

function FireDimensionModel:onFireDimensionClgBanRes(activityId, msg)
	self._stageInfo = GameUtil.pbToTable(msg.stageInfo)
	self._stageInfo.banTeamIds = self._stageInfo.banTeamIds or {}
	self._stageInfo.finishedTeamids = self._stageInfo.finishedTeamids or {}
	self._actStageInfoMap[activityId] = self._stageInfo
end

function FireDimensionModel:onFireDimensionClgResetRes(activityId, msg)
	self._stageInfo = nil
	self._actStageInfoMap[activityId] = self._stageInfo
	self._finishNum = 0
end

function FireDimensionModel:onFireDimensionClgFightEndRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)

	self._isWin = msg.isWin
	self._isNextStage = msg.nextStage

	if msg.nextStage then
		self._stageInfo = nil
		self._stageId = self._stageId + 1
		self._actStageInfoMap[msg.activityId] = self._stageInfo
		self._actStateMap[msg.activityId] = checknumber(self._actStateMap[msg.activityId]) + 1
		self._finishNum = 0
	else
		self._stageInfo = self._actStageInfoMap[msg.activityId]

		if msg.isWin and self._stageInfo and self._stageInfo.stageId == msg.stageId and self._stageInfo.finishedTeamids and not TableUtil.isHad(self._stageInfo.finishedTeamids, msg.teamId) then
			table.insert(self._stageInfo.finishedTeamids, msg.teamId)
		end
	end
end

function FireDimensionModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = FireDimensionCustomFmtMo.New()
	end

	return self._customFmtMo
end

function FireDimensionModel:getActivityId()
	return self._activityId
end

function FireDimensionModel:getActivityType()
	return GameEnum.ActivityType.FireDimension
end

function FireDimensionModel:isStageLock(activityId, stageId)
	local passId = checknumber(self._actStateMap[activityId])

	return passId + 1 < checknumber(stageId)
end

function FireDimensionModel:isStagePass(activityId, stageId)
	local passId = checknumber(self._actStateMap[activityId])

	return stageId <= passId
end

function FireDimensionModel:isStageBaned(activityId, stageId)
	self._stageInfo = self._actStageInfoMap[activityId]

	if self._stageInfo then
		if self._stageInfo.stageId == stageId then
			return #self._stageInfo.banTeamIds > 0
		else
			return false
		end
	else
		return false
	end
end

function FireDimensionModel:isTeamBaned(activityId, stageId, teamId)
	if not self:isStageBaned(activityId, stageId) then
		return false
	end

	self._stageInfo = self._actStageInfoMap[activityId]

	return TableUtil.isHad(self._stageInfo.banTeamIds, teamId)
end

function FireDimensionModel:getBanedList(activityId, stageId)
	if self:isStageBaned(activityId, stageId) then
		self._stageInfo = self._actStageInfoMap[activityId]

		return self._stageInfo.banTeamIds
	else
		return {}
	end
end

function FireDimensionModel:isTeamPassed(activityId, stageId, teamId)
	self._stageInfo = self._actStageInfoMap[activityId]

	if self._stageInfo then
		return TableUtil.isHad(self._stageInfo.finishedTeamids, teamId)
	else
		return false
	end
end

function FireDimensionModel:getPassNum(activityId, stageId)
	self._stageInfo = self._actStageInfoMap[activityId]

	if self._stageInfo then
		if self._stageInfo.stageId == stageId then
			return #self._stageInfo.finishedTeamids
		else
			return 0
		end
	else
		return 0
	end
end

function FireDimensionModel:clearFmt()
	self.formationMO:SetHeroSkillId(0)

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

	self.formationMO:setPositionForce(posList)
end

function FireDimensionModel:setFmt(creepsMasterId)
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

	self:intFmtData(creepsMasterId)

	local creepCfg = FireDimensionConfig.instance:getCreepsCfgList(creepsMasterId)
	local mcfg = FireDimensionConfig.instance:getMonsterCfg(creepsMasterId)

	if creepCfg then
		local teams = {}

		for i, creepCo in pairs(creepCfg) do
			local petId = self:createPetId(creepsMasterId, creepCo.creepsId)

			posList[creepCo.posId] = petId

			table.insert(teams, self:getPet(petId))
		end

		local heroSkillId = self:getheroSkillId(mcfg, teams)

		self.formationMO:SetHeroSkillId(heroSkillId)
	end

	self.formationMO:setPositionForce(posList)
end

function FireDimensionModel:intFmtData(creepsMasterId)
	self.petMap = self.petMap or {}
	self._fpFmo = self._fpFmo or FightingPowerPetMo.New()

	local creepCfg = FireDimensionConfig.instance:getCreepsCfgList(creepsMasterId)

	if creepCfg then
		for i, creepCo in pairs(creepCfg) do
			local petId = self:createPetId(creepsMasterId, creepCo.creepsId)

			if self.petMap[petId] == nil then
				local curFaceId = creepCo.faceId

				if checknumber(curFaceId) == 0 then
					curFaceId = creepCo.raceId
				end

				self._fpFmo:fromChallengeCreepCo(creepCo)

				local petMo = self._fpFmo:toBaseBagPetMo()

				petMo.petId = petId

				if checknumber(creepCo.summonMasterId) > 0 then
					petMo.summonMasterId = self:createPetId(creepsMasterId, checknumber(creepCo.summonMasterId))
				end

				if checknumber(creepCo.summonedPetId) > 0 then
					petMo.summonedPetId = self:createPetId(creepsMasterId, checknumber(creepCo.summonedPetId))
				end

				petMo.contractSkillId = checknumber(creepCo.contractSkillId)
				self.petMap[petMo.petId] = petMo
			end
		end
	end
end

function FireDimensionModel:createPetId(creepsMasterId, creepsId)
	return checknumber(creepsMasterId .. "" .. creepsId)
end

function FireDimensionModel:getheroSkillId(monsterCo, teams)
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

function FireDimensionModel:getFmt()
	return self.formationMO
end

function FireDimensionModel:getPet(petId)
	if self.petMap then
		return self.petMap[petId]
	end
end

function FireDimensionModel:getDailyBuffLv(activityId)
	return checknumber(self._actDailyBuffLvMap[activityId])
end

function FireDimensionModel:getIsGainDailyBuff(activityId)
	return checkbool(self._actIsGainBuffMap[activityId])
end

function FireDimensionModel:gainDailyBuff(msg)
	self._isGainDailyBuff = true
	self._dailyBuffLv = msg.signInBuffLv
	self._actDailyBuffLvMap[msg.activityId] = self._dailyBuffLv
	self._actIsGainBuffMap[msg.activityId] = self._isGainDailyBuff
end

FireDimensionModel.instance = FireDimensionModel.New()

return FireDimensionModel
