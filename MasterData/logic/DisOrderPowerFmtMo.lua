-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/model/DisOrderPowerFmtMo.lua

module("logic.extensions.disorderpower.model.DisOrderPowerFmtMo", package.seeall)

local DisOrderPowerFmtMo = class("DisOrderPowerFmtMo", BaseCustomFmtMo)

function DisOrderPowerFmtMo:onReset()
	DisOrderPowerFmtMo.super.onReset(self)
end

function DisOrderPowerFmtMo:updateCfg(activityId, cardId)
	self._activityId = activityId
	self.cardId = cardId
	self._creepsMasterId = DisOrderPowerConfig.instance:GetCreepsId(activityId, self.cardId)
	self._masterData = DisOrderPowerConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = DisOrderPowerConfig.instance:getCreepsData(self._creepsMasterId)
	self._sysCfg = DisOrderPowerConfig.instance:getSupportData(self._activityId)
	self.isOnlyUpdateExistPet = true
end

function DisOrderPowerFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DisOrderPowerFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DisOrderPowerController.instance:sendPM_DisorderPowerFightReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DisOrderPowerFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DisOrderPowerFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DisOrderPowerFmtMo:initPetList()
	self:clearAllPetList()

	local fmo = FightingPowerPetMo.New()

	for _, data in pairs(self._sysCfg or {}) do
		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

return DisOrderPowerFmtMo
