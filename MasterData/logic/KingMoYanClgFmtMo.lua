-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/model/KingMoYanClgFmtMo.lua

module("logic.extensions.kingmoyanclg.model.KingMoYanClgFmtMo", package.seeall)

local KingMoYanClgFmtMo = class("KingMoYanClgFmtMo", BaseCustomFmtMo)

function KingMoYanClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = KingMoYanClgConfig.instance:getStageData(activityId, stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = KingMoYanClgConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = KingMoYanClgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._actData = KingMoYanClgConfig.instance:getActData(self._activityId)
	self._raceId = self._actData.raceId
	self._supportPetId = self._actData.supportPetId
	self._supportData = KingMoYanClgConfig.instance:getSupportData(self._supportPetId)
end

function KingMoYanClgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function KingMoYanClgFmtMo:initPetList()
	KingMoYanClgFmtMo.super.initPetList(self)

	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(self._supportData)

	local petMo = fMo:toBaseBagPetMo()

	petMo:setSupportedPet(true)
	self:addPetToList(petMo)
	self:_updateCurMaxPetMo()
end

function KingMoYanClgFmtMo:refreshPetList(changePetMoMap)
	KingMoYanClgFmtMo.super.refreshPetList(self, changePetMoMap)

	if changePetMoMap and _G.next(changePetMoMap) and self._rightPetMap then
		for k, petMo in pairs(changePetMoMap) do
			if petMo:getDefineId() == self._raceId then
				self:_updateCurMaxPetMo()
			end
		end
	end
end

function KingMoYanClgFmtMo:_updateCurMaxPetMo()
	local maxPetMo

	if self._rightPetList then
		for _, mo in ipairs(self._rightPetList) do
			if mo:getDefineId() == self._raceId and (maxPetMo == nil or mo:getFightingPower() > maxPetMo:getFightingPower()) then
				maxPetMo = mo
			end
		end
	end

	self._petMo = maxPetMo
end

function KingMoYanClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		local fmo = self:getCurFormation()

		if not fmo:HasRace(self._raceId) then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			local petName = CharacterConfig.instance:getPetName(self._raceId)

			FloatWordMgr.instance:show(string.format("阵容缺失%s，无法挑战", petName))

			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KingMoYanClgController.instance:sendPM_KingMoYanClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function KingMoYanClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KingMoYanClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KingMoYanClgFmtMo:getFinalFmoList(posList, petPool, needPets)
	local posList, petPool = KingMoYanClgFmtMo.super.getFinalFmoList(self, posList, petPool, needPets)

	if self._petMo and self._petMo:isExist() then
		local isHave = false
		local fitIndex = 0
		local minZdl = -1

		for index, petMo in pairs(petPool) do
			if petMo:getDefineId() == self._raceId then
				isHave = true

				break
			end

			local zdl = petMo:getFightingPower()

			if minZdl <= 0 or zdl < minZdl then
				minZdl = zdl
				fitIndex = index
			end
		end

		if not isHave and fitIndex > 0 then
			petPool[fitIndex] = self._petMo
		end
	end

	return posList, petPool
end

return KingMoYanClgFmtMo
