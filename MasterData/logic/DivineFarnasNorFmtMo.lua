-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/model/DivineFarnasNorFmtMo.lua

module("logic.extensions.divineeternaldragonclg.model.DivineFarnasNorFmtMo", package.seeall)

local DivineFarnasNorFmtMo = class("DivineFarnasNorFmtMo", BaseCustomFmtMo)

function DivineFarnasNorFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._groupId = DivineFarnasController.instance:getNorStageGroupId(activityId)
	self._creepsMasterId = DivineFarnasConfig.instance:getNorCreepsMasterId(activityId, self._groupId, stageId)
	self._masterData = DivineFarnasConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineFarnasConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._supportCfg = DivineFarnasConfig.instance:getSupportPetCfgs(activityId)
	self.ruleDescStr = self._masterData.ruleDesc
	self.useMaxFightPower = true

	self:setFormCondition(self._masterData.formCondition)
end

function DivineFarnasNorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineFarnasController.instance:sendPM_DivineFarnasClgNormalFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineFarnasNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineFarnasNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineFarnasNorFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, supportCfg in pairs(self._supportCfg) do
		fMo:fromChallengeCreepCo(supportCfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

return DivineFarnasNorFmtMo
