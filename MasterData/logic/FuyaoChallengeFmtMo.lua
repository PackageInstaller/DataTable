-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/model/FuyaoChallengeFmtMo.lua

module("logic.extensions.fuyao.model.FuyaoChallengeFmtMo", package.seeall)

local FuyaoChallengeFmtMo = class("FuyaoChallengeFmtMo", ICustomFmtMo)

function FuyaoChallengeFmtMo:onReset()
	FuyaoChallengeFmtMo.super.onReset(self)
end

function FuyaoChallengeFmtMo:initParams(activityId, challengeId, creepsMasterId, isExtreme)
	self._activityId = activityId
	self._activityType = FuYaoController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._challengeId = challengeId
	self._creepsMasterId = creepsMasterId
	self._isExtreme = isExtreme
	self.isShowBtnCutePet = not not self._isExtreme
end

function FuyaoChallengeFmtMo:updateData()
	local cfg = FuYaoConfig.instance:getFuyaoMasterCfg(self._creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.missionDesc
	self.validatorDescStr = cfg.WinDesc

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function FuyaoChallengeFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		FuYaoController.instance:fightResult(self._activityId, self._isExtreme)

		local simpleForm = self:getCurSimpleForm()

		if self._isExtreme then
			FuYaoController.instance:sendPM_FuyaoExtremeChallengeReq(self._activityId, self._challengeId, simpleForm)
		else
			FuYaoController.instance:sendPM_FuyaoCommonChallengeReq(self._activityId, self._challengeId, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function FuyaoChallengeFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		if self._isExtreme then
			self:addPetToList(petMo)
		else
			self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
		end
	end
end

function FuyaoChallengeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		if self._isExtreme then
			self:updatePetMo(petMo)
		else
			self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
		end
	end
end

function FuyaoChallengeFmtMo:getMonsterConfigList()
	return FuYaoConfig.instance:getFuyaoCreepCfg(self._creepsMasterId)
end

function FuyaoChallengeFmtMo:getFmtInfoConfig()
	return FuYaoConfig.instance:getFuyaoMasterCfg(self._creepsMasterId)
end

return FuyaoChallengeFmtMo
