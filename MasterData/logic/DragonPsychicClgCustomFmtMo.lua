-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/model/DragonPsychicClgCustomFmtMo.lua

module("logic.extensions.dragonpsychicclg.model.DragonPsychicClgCustomFmtMo", package.seeall)

local DragonPsychicClgCustomFmtMo = class("DragonPsychicClgCustomFmtMo", ICustomFmtMo)

function DragonPsychicClgCustomFmtMo:onReset()
	DragonPsychicClgCustomFmtMo.super.onReset(self)
end

function DragonPsychicClgCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageData = DragonPsychicClgConfig.instance:getDpcUniversalStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = DragonPsychicClgConfig.instance:getDpcMasterData(self._creepsMasterId)
	self._creepsCfg = DragonPsychicClgConfig.instance:getDpcCreepsCfg(self._creepsMasterId)
	self._myCreepsIds = DragonPsychicClgController.instance:getCanUseCreepsIdsOfNor(activityId)
end

function DragonPsychicClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function DragonPsychicClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DragonPsychicClgController.instance:sendPM_DPClgUniversalChallengeReq(self._activityId, simpleForm, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function DragonPsychicClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DragonPsychicClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DragonPsychicClgCustomFmtMo:checkIsSummonMasterPetsNotInBag(petMo, limitLv)
	return checknumber(petMo.summonedPetId) > 0
end

function DragonPsychicClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local fmo = FightingPowerPetMo.New()

	for _, creepsId in ipairs(self._myCreepsIds) do
		local creepsData = DragonPsychicClgConfig.instance:getDpcSystemPetData(self._activityId, creepsId)

		if creepsData == nil then
			printError(string.format("精灵为空( activityId=%s, creepsId=%s )", self._activityId, creepsId))
		else
			fmo:fromChallengeCreepCo(creepsData)

			local petMo = fmo:toBaseBagPetMo()

			self:addPetToList(petMo)

			local summonedPetId = petMo.summonedPetId

			if summonedPetId > 0 then
				local summonedCreepsData = DragonPsychicClgConfig.instance:getDpcSystemPetData(self._activityId, summonedPetId)

				if summonedCreepsData == nil then
					printError(string.format("召唤兽为空( activityId=%s, 召唤师creepsId=%s, 召唤兽creepsId=%s )", self._activityId, creepsId, summonedPetId))
				else
					fmo:fromChallengeCreepCo(summonedCreepsData)

					local petMo = fmo:toBaseBagPetMo()

					self:updatePetMo(petMo)
				end
			end
		end
	end
end

return DragonPsychicClgCustomFmtMo
