-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/model/KingmmExtremeCustomFmtMo.lua

module("logic.extensions.kingmengmeng.model.KingmmExtremeCustomFmtMo", package.seeall)

local KingmmExtremeCustomFmtMo = class("KingmmExtremeCustomFmtMo", ICustomFmtMo)

function KingmmExtremeCustomFmtMo:initParams(activityId, challengeType, stageId, creepsMasterId)
	self._activityId = activityId
	self._challengeType = challengeType
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._activityType = KingmmController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._monsterCfg = KingmmConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = KingmmConfig.instance:getCreepsCfgList(creepsMasterId)
end

function KingmmExtremeCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.description

	self:setFormCondition(self._formCheckId)
	self:initPetList()
end

function KingmmExtremeCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function KingmmExtremeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KingmmExtremeCustomFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		KingmmController.instance:regFightResultInExt(self._activityId)

		local form = self:getCurSimpleForm()

		KingmmAgent.instance:sendPM_KMMChallengeExtremeChallengeReq(self._activityId, self._challengeType, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function KingmmExtremeCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function KingmmExtremeCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function KingmmExtremeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function KingmmExtremeCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._challengeType == KingmmModel.GuardChallenge then
		return KingmmModel.instance:isLockRaceId(petMo.raceId)
	else
		return false
	end
end

function KingmmExtremeCustomFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show(string.format("%s已上阵过,请使用其他精灵破阵", petMo.name))
end

return KingmmExtremeCustomFmtMo
