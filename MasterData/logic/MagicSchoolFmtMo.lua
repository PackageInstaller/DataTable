-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/model/MagicSchoolFmtMo.lua

module("logic.extensions.magicschool.model.MagicSchoolFmtMo", package.seeall)

local MagicSchoolFmtMo = class("MagicSchoolFmtMo", BaseCustomFmtMo)

function MagicSchoolFmtMo:updateCfg(activityId, campId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = MagicSchoolConfig.instance:getCreepMasterId(activityId, campId, stageId)
	self._masterData = MagicSchoolConfig.instance:getMonsterCfgs(self._creepsMasterId)
	self._creepsCfg = MagicSchoolConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._systemPetCfgs = MagicSchoolConfig.instance:getSystemPetCfgsByStageId(activityId, campId, stageId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.isOnlyUpdateExistPet = true

	self:setFormCondition(self._masterData.formCondition)
end

function MagicSchoolFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		MagicSchoolController.instance:sendPM_MagicSchoolChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function MagicSchoolFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function MagicSchoolFmtMo:getFmtInfoConfig()
	return self._masterData
end

function MagicSchoolFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, supportCfg in pairs(self._systemPetCfgs) do
		fMo:fromChallengeCreepCo(supportCfg)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(petMo))
	end
end

return MagicSchoolFmtMo
