-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/model/GoddessTrialBossFmtMo.lua

module("logic.extensions.goddesstrial.model.GoddessTrialBossFmtMo", package.seeall)

local GoddessTrialBossFmtMo = class("GoddessTrialBossFmtMo", BaseCustomFmtMo)

function GoddessTrialBossFmtMo:initParams(activityId, stepId, mode)
	self.activityId = activityId
	self.stepId = stepId
	self.mode = mode

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self.activityId, self.stepId)
	local bossCfg = GoddessTrialConfig.instance:getBossCfg(stepCfg.bossId)
	local creepsMasterId = checknumber(bossCfg.creepsMasterId)

	self._cfgEnemy = GoddessTrialConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = GoddessTrialConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.validatorDescStr = lang("当前挑战仅可上阵女性精灵")

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function GoddessTrialBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local isPractice = self.mode == 2

		GoddessTrialController.instance:sendPM_GoddessTrialBossFightReq(self.activityId, self.stepId, isPractice, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GoddessTrialBossFmtMo:initPetList()
	self:clearAllPetList()

	local activityCfg = GoddessTrialConfig.instance:getActivityCfg(self.activityId)
	local pets = self:getFightBagPet()

	for i, petMo in ipairs(pets) do
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

		if skinCfg.genderId == checknumber(activityCfg.superStageScoreGender) then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function GoddessTrialBossFmtMo:_updatePetMoEx(mo, indexMap, removeIdxMap)
	mo = self:_changePetMo(mo)

	local activityCfg = GoddessTrialConfig.instance:getActivityCfg(self.activityId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
	local idx = indexMap[mo.petId]

	if idx and idx > 0 then
		if mo:isExist() and skinCfg.genderId == checknumber(activityCfg.superStageScoreGender) then
			self._rightPetList[idx] = mo
			self._rightPetMap[mo.petId] = mo
		else
			self._rightPetMap[mo.petId] = nil
			removeIdxMap[idx] = true
		end
	elseif mo:isExist() and skinCfg.genderId == checknumber(activityCfg.superStageScoreGender) then
		table.insert(self._rightPetList, mo)

		self._rightPetMap[mo.petId] = mo
		indexMap[mo.petId] = #self._rightPetList
	end
end

function GoddessTrialBossFmtMo:getMonsterConfigList()
	return self._masterList
end

function GoddessTrialBossFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return GoddessTrialBossFmtMo
