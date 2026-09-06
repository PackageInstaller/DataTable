-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/model/OriginaresmomNorFmtMo.lua

module("logic.extensions.originaresmom.model.OriginaresmomNorFmtMo", package.seeall)

local OriginaresmomNorFmtMo = class("OriginaresmomNorFmtMo", BaseCustomFmtMo)

function OriginaresmomNorFmtMo:initParams(activityId, teamIndex, creepsMasterId)
	self._activityId = activityId
	self._teamIndex = teamIndex
	self._creepsMasterId = creepsMasterId
	self._masterData = OriginaresmomConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginaresmomConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.useMaxFightPower = true
end

function OriginaresmomNorFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginaresmomNorFmtMo:initPetList()
	OriginaresmomNorFmtMo.super.initPetList(self)

	local supportCfgs = OriginaresmomConfig.instance:getNorSupportPetsCfgs(self._activityId) or {}

	for k, v in pairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function OriginaresmomNorFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgNormalChallengeReq(self._activityId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginaresmomNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginaresmomNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginaresmomNorFmtMo
