-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/model/KingKaYaExtCustomFmtMo.lua

module("logic.extensions.kingkaya.model.KingKaYaExtCustomFmtMo", package.seeall)

local KingKaYaExtCustomFmtMo = class("KingKaYaExtCustomFmtMo", ICustomFmtMo)

function KingKaYaExtCustomFmtMo:onReset()
	KingKaYaExtCustomFmtMo.super.onReset(self)
end

function KingKaYaExtCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._kingKaYaMo = KingKaYaController.instance:getKingKaYaMo(self._activityId)
	self._stageData = KingKaYaConfig.instance:getExtStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._selfPositionBuffs = self._stageData.selfPositionBuffs
	self._enemyPositionBuffs = self._stageData.enemyPositionBuffs
	self._winScoreRequirements = self._stageData.winScoreRequirements
	self._masterData = KingKaYaConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = KingKaYaConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local lockRaceIds = self._kingKaYaMo:getLockRaceIdsInExt(stageId)

	self._lockedRaceIdMap = {}

	for i, v in ipairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = v
	end
end

function KingKaYaExtCustomFmtMo:getActivityId()
	return self._activityId
end

function KingKaYaExtCustomFmtMo:getWinScoreRequirements()
	return self._winScoreRequirements
end

function KingKaYaExtCustomFmtMo:getSelfPositionBuffs()
	return self._selfPositionBuffs
end

function KingKaYaExtCustomFmtMo:getEnemyPositionBuffs()
	return self._enemyPositionBuffs
end

function KingKaYaExtCustomFmtMo:getCreepsMasterId()
	return self._creepsMasterId
end

function KingKaYaExtCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function KingKaYaExtCustomFmtMo:initFightHandler()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingKaYa, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	local function handler()
		local dic = {}
		local positions = self:getCurFormation():GetPositions()

		for posId, petId in pairs(positions) do
			local petMo = self:getPetMoById(petId)

			if petMo then
				dic[posId] = petMo:getDefineId()
			end
		end

		self._kingKaYaMo:savePetPosInExt(self._stageId, dic)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KingKaYaController.instance:sendPM_KingKaYaExtremeChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KingKaYaExtCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KingKaYaExtCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KingKaYaExtCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KingKaYaExtCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KingKaYaExtCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotCanUp(petMo:getDefineId())
end

function KingKaYaExtCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotCanUp(petMo:getDefineId()) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function KingKaYaExtCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if KingKaYaExtCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			return not self:_isPetNotCanUp(petMo:getDefineId())
		else
			return true
		end
	else
		return false
	end
end

function KingKaYaExtCustomFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] ~= nil
	else
		return false
	end
end

function KingKaYaExtCustomFmtMo:getExtendViewName()
	return ViewName.KingKaYaFmtExtisonView
end

return KingKaYaExtCustomFmtMo
