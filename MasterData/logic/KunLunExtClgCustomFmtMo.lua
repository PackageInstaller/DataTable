-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/model/KunLunExtClgCustomFmtMo.lua

module("logic.extensions.kunlunchallenge.model.KunLunExtClgCustomFmtMo", package.seeall)

local KunLunExtClgCustomFmtMo = class("KunLunExtClgCustomFmtMo", ICustomFmtMo)

function KunLunExtClgCustomFmtMo:onReset()
	KunLunExtClgCustomFmtMo.super.onReset(self)

	self._winIdOfCard = 0
	self._formConditionOfCard = 0
end

function KunLunExtClgCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._activityType = KunLunChallengeController.instance:getActivityType()
	self._stageId = stageId
	self._extClgMo = KunLunChallengeController.instance:getKunLunExtClgMo(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local winId = 0
	local formCondition = 0
	local cardIdList = self._extClgMo:getCardIdListOfStage(self._stageId)

	for _, cardId in ipairs(cardIdList) do
		local data = KunLunChallengeConfig.instance:getKlExtCardDataById(self._activityId, cardId)

		if not data or data.type == KunLunCardTypeEnum.Type_Buff then
			-- block empty
		elseif data.type == KunLunCardTypeEnum.Type_WinId then
			winId = checknumber(data.param)
		elseif data.type == KunLunCardTypeEnum.Type_FormCondition then
			formCondition = checknumber(data.param)
		end
	end

	self._winIdOfCard = winId
	self._formConditionOfCard = formCondition

	local actData = KunLunChallengeConfig.instance:getKlActData(self._activityId)
	local stageData = KunLunChallengeConfig.instance:getKlExtStageData(self._activityId, self._stageId)

	self._monsterId = stageData.creepsMasterId

	local masterData = KunLunChallengeConfig.instance:getKlExtremeMonsterData(self._monsterId)

	self._masterData = TableUtil.deepcopy(masterData)
	self._masterData.winId = self._winIdOfCard
	self._creepsCfg = KunLunChallengeConfig.instance:getKlChallengeCreepsDataList(self._monsterId)
end

function KunLunExtClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	if self._formConditionOfCard > 0 then
		self:setFormCondition(self._formConditionOfCard)
	else
		self:setFormCondition(self._masterData.formCondition)
	end

	self.isHideFmtZdl = true

	local ruleDesc = ""
	local cardIdList = self._extClgMo:getCardIdListOfStage(self._stageId)
	local totalNum = self._extClgMo:getTotalNumOfCardInStage()

	for idx = 1, totalNum do
		local cardId = cardIdList[idx]

		if cardId > 0 then
			local data = KunLunChallengeConfig.instance:getKlExtCardDataById(self._activityId, cardId)

			ruleDesc = totalNum >= idx + 1 and ruleDesc .. data.desc .. "\n" or ruleDesc .. data.desc
		end
	end

	self.ruleDescStr = ruleDesc
	self.isPopRuleDesc = true

	self:initFormationMo()
end

function KunLunExtClgCustomFmtMo:initFormationMo()
	local key = self:_getFormationMoKey()

	if key == nil then
		return
	end

	self._formationMoPool = self._formationMoPool or {}
	self.formationMo = self._formationMoPool[key] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self._formationMoPool[key] = self.formationMo
end

function KunLunExtClgCustomFmtMo:_getFormationMoKey()
	return self._stageId
end

function KunLunExtClgCustomFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local result, tips = self._extClgMo:getTryStartExtFightResultAndTips(self._stageId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, nil)

			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KunLunChallengeController.instance:sendPM_KunLunExtremeClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KunLunExtClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KunLunExtClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function KunLunExtClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KunLunExtClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return KunLunExtClgCustomFmtMo
