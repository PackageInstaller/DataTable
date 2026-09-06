-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/model/TunTianExtClgCustomFmtMo.lua

module("logic.extensions.tuntianchallenge.model.TunTianExtClgCustomFmtMo", package.seeall)

local TunTianExtClgCustomFmtMo = class("TunTianExtClgCustomFmtMo", ICustomFmtMo)

function TunTianExtClgCustomFmtMo:onReset()
	TunTianExtClgCustomFmtMo.super.onReset(self)
end

function TunTianExtClgCustomFmtMo:updateCfg(activityId, stageType, stageId)
	self._activityId = activityId
	self._stageType = stageType
	self._stageId = stageId
	self._activityType = TunTianChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._stagData = TunTianChallengeConfig.instance:getTtExtStageData(self._activityId, self._stageType, self._stageId)
	self._masterData = TunTianChallengeConfig.instance:getTtMasterData(self._stagData.creepsMasterId)
	self._creepsCfg = TunTianChallengeConfig.instance:getTtCreepsDataList(self._stagData.creepsMasterId)
end

function TunTianExtClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function TunTianExtClgCustomFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		TunTianChallengeController.instance:sendPM_TunTianExtremeClgFightReq(self._activityId, self._stageType, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TunTianExtClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TunTianExtClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function TunTianExtClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function TunTianExtClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return TunTianExtClgCustomFmtMo
