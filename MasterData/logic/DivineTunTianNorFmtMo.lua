-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/model/DivineTunTianNorFmtMo.lua

module("logic.extensions.divinetuntian.model.DivineTunTianNorFmtMo", package.seeall)

local DivineTunTianNorFmtMo = class("DivineTunTianNorFmtMo", BaseCustomFmtMo)

function DivineTunTianNorFmtMo:updateCfg(activityId, day, index)
	self._activityId = checknumber(activityId)
	self._day = checknumber(day)
	self._index = checknumber(index)
	self._creepsMasterId = DivineTunTianConfig.instance:getNorCreepMasterId(activityId, day, index)
	self._masterData = DivineTunTianConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineTunTianConfig.instance:getCreepCfg(self._creepsMasterId)
	self._supportCfgs = DivineTunTianConfig.instance:getNorSupportPetCfgs()
	self.topTitleStr = self._masterData.name
	self.useMaxFightPower = true
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineTunTianNorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineTunTianController.instance:sendPM_DivineTunTianClgNormalChallengeReq(self._activityId, self._index, simpleForm)
	end, nil)
end

function DivineTunTianNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineTunTianNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineTunTianNorFmtMo:getExtendViewName()
	return ViewName.DivineTunTianFmtView
end

function DivineTunTianNorFmtMo:getActivityId()
	return self._activityId
end

function DivineTunTianNorFmtMo:getDay()
	return self._day
end

function DivineTunTianNorFmtMo:getIndex()
	return self._index
end

function DivineTunTianNorFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	for _, supportCfg in ipairs(self._supportCfgs) do
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

return DivineTunTianNorFmtMo
