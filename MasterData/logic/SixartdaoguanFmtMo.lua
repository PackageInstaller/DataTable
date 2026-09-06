-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/model/SixartdaoguanFmtMo.lua

module("logic.extensions.sixartdaoguan.model.SixartdaoguanFmtMo", package.seeall)

local SixartdaoguanFmtMo = class("SixartdaoguanFmtMo", BaseCustomFmtMo)

function SixartdaoguanFmtMo:initParams(activityId, challengeId, stageId)
	self._activityId = activityId
	self._challengeId = challengeId
	self._stageId = stageId
	self.useMaxFightPower = true

	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(activityId, challengeId, stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._masterData = SixartdaoguanConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = SixartdaoguanConfig.instance:getCreepsCfgs(self._creepsMasterId)

	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, self._challengeId)

	if self._challengeId == SixartdaoguanController.ChallengeType.Defense then
		local waveId = 1
		local stageCfgs = SixartdaoguanConfig.instance:getStageCfgs(activityId, challengeId)

		for i, v in ipairs(stageCfgs) do
			if v.stageId == stageId then
				self.topTitleStr = string.format("%s-第%s关", challengeCfg.desc, waveId)

				break
			elseif v.dropBuffPlanId > 0 then
				waveId = waveId + 1
			end
		end
	else
		self.topTitleStr = string.format("%s-第%s关", challengeCfg.desc, stageCfg.stageId)
	end

	self.ruleDescStr = self._masterData.ruleDesc

	if self._challengeId == SixartdaoguanController.ChallengeType.Shooting then
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_Always or ICustomFmtMo.EEnterShowRuleFlag_None
	end

	self:_addRentPets()
end

function SixartdaoguanFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView)
		SixartdaoguanModel.instance:clearBattleResultMsg()

		local stageId = self._stageId

		if self._challengeId == SixartdaoguanController.ChallengeType.Defense then
			stageId = 0
		end

		BattleFacade.instance:startSixArtBattle(self._challengeId)
		SixartdaoguanController.instance:sendPM_SixArtDaoguanStartFightReq(self._activityId, self._challengeId, stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SixartdaoguanFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SixartdaoguanFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SixartdaoguanFmtMo:getExtendViewName()
	if self._challengeId == SixartdaoguanController.ChallengeType.Music then
		return ViewName.SixartdaoguanyueextView
	elseif self._challengeId == SixartdaoguanController.ChallengeType.Writing then
		return ViewName.SixartdaoguanyueextView
	elseif self._challengeId == SixartdaoguanController.ChallengeType.Numbers then
		return ViewName.SixartdaoguanyueextView
	end

	return ""
end

function SixartdaoguanFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	local rentPets = SixartdaoguanModel.instance:getRentPetMos(self._activityId)

	if rentPets then
		for i, petMo in pairs(rentPets) do
			self:addPetToList(petMo)
		end
	end
end

function SixartdaoguanFmtMo:_addRentPets()
	if self._rightPetMap then
		local rentPets = SixartdaoguanModel.instance:getRentPetMosByIds(self._activityId)

		if rentPets then
			for i, petMo in pairs(rentPets) do
				local rentCfg = SixartdaoguanConfig.instance:getRentPetCfg(self._activityId, petMo.petId)
				local summonedPetId = checknumber(rentCfg.summonedPetId)

				if summonedPetId > 0 then
					local summonRentCfg = SixartdaoguanConfig.instance:getRentPetCfg(self._activityId, summonedPetId)
					local summonPetMo = SixartdaoguanModel.instance:getRentPetMo(self._activityId, summonedPetId)

					if not self._rightPetMap[summonPetMo.petId] then
						self:addPetToList(self:_changePetMo(summonPetMo))
					end
				end

				if not self._rightPetMap[petMo.petId] then
					self:addPetToList(self:_changePetMo(petMo))
				end
			end
		end
	end
end

return SixartdaoguanFmtMo
