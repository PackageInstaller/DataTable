-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/model/KingjiCustomFmtMo.lua

module("logic.extensions.kingjichallenge.model.KingjiCustomFmtMo", package.seeall)

local KingjiCustomFmtMo = class("KingjiCustomFmtMo", ICustomFmtMo)

function KingjiCustomFmtMo:initParams(challengeType, stageId, creepsMasterId, extStageId)
	self.isShowTab = false
	self.isShowBtnSave = true
	self._stageId = stageId
	self._challengeType = challengeType
	self._creepsMasterId = creepsMasterId
	self._extStageId = extStageId
	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._masterList = KingjichallengeConfig.instance:getCreepMonstersCfgs(creepsMasterId)
	self._creepsCfg = KingjichallengeConfig.instance:getCreepMasterCfg(creepsMasterId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
	self.validatorDescStr = self._creepsCfg.missionDesc

	self:setFormCondition(self._creepsCfg.formCondition)
	self:clearAllPetList()
end

function KingjiCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local lockRaceIds = self:_getLockRaceIds()

	for i, petMo in ipairs(pets) do
		if not lockRaceIds[petMo.raceId] then
			self:addPetToList(petMo)
		end
	end
end

function KingjiCustomFmtMo:refreshPetList(changePetMoMap)
	return
end

function KingjiCustomFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local form = self:getCurFormation():createFormPb()

		UIJumper.instance:pushOneStack(ViewName.KingjichallengemainView)

		local extInfo = ""

		if self._challengeType == GameEnum.KingjiChallengeType.Hun then
			extInfo = self._extStageId

			UIJumper.instance:pushOneStack(ViewName.KingjichallengesoulView)
			UIJumper.instance:pushOneStack(ViewName.KingjisoulsmallView, nil, self._stageId)
		elseif self._challengeType == GameEnum.KingjiChallengeType.Shizhe then
			UIJumper.instance:pushOneStack(ViewName.KingjichallengecourierView)
		elseif self._challengeType == GameEnum.KingjiChallengeType.Ronghe then
			extInfo = self._creepsMasterId

			UIJumper.instance:pushOneStack(ViewName.KingjimixView)
		end

		BattleFacade.instance:startKingji(self._challengeType)

		if self._challengeType == GameEnum.KingjiChallengeType.Shizhe then
			KingjichallengeController.instance:setCurrChallengeCourierStageId(self._stageId)
		else
			KingjichallengeController.instance:setCurrChallengeCourierStageId(nil)
		end

		KingJiChallengeAgent.instance:sendPM_KingJiChallengeChallengeReq(self._activityId, self._challengeType, self._stageId, extInfo, form)
	end

	self:setFightHandler(handler, nil)
end

function KingjiCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function KingjiCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function KingjiCustomFmtMo:_getLockRaceIds()
	if self._challengeType == GameEnum.KingjiChallengeType.Ronghe then
		return KingjichallengeModel.instance:getAllLockRaceIds(self._stageId)
	end

	return {}
end

return KingjiCustomFmtMo
