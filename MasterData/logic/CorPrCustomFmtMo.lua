-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/model/CorPrCustomFmtMo.lua

module("logic.extensions.corpr.model.CorPrCustomFmtMo", package.seeall)

local CorPrCustomFmtMo = class("CorPrCustomFmtMo", ICustomFmtMo)

function CorPrCustomFmtMo:onReset()
	CorPrCustomFmtMo.super.onReset(self)
end

function CorPrCustomFmtMo:updateCfg(challengeId, identityId, stageId)
	self._challengeId = challengeId
	self._identityId = identityId
	self._stageId = stageId
	self._monsterData = CorPrChallengeConfig.instance:getcpMonsterData(self._identityId, self._stageId)
	self._creepsCfg = CorPrChallengeConfig.instance:getCpCreepsCfg(self._identityId, self._stageId)
end

function CorPrCustomFmtMo:updateData()
	self.topTitleStr = self._monsterData.name
	self.ruleDescStr = self._monsterData.WinDesc
	self.validatorDescStr = self._monsterData.missionDesc

	self:setFormCondition(self._monsterData.formCondition)
	self:initPetList()
	self:updateFormationMo()
end

function CorPrCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack()
		UIJumper.instance:removeTopState(ViewName.CustomMissionView)

		local simpleForm = self:getCurSimpleForm()

		CorPrChallengeController.instance:sendPM_CorrectPrincipleChallengeFightReq(self._challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function CorPrCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local helpCfg = CorPrChallengeConfig.instance:getCpHelperCfg(self._monsterData.helpPetPlanId)

	if helpCfg then
		local fmo = FightingPowerPetMo.New()

		for _, helpData in pairs(helpCfg) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end

		fmo = nil
	end
end

function CorPrCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function CorPrCustomFmtMo:getFmtInfoConfig()
	return self._monsterData
end

function CorPrCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function CorPrCustomFmtMo:getExtendViewName()
	return ViewName.CorPrBuffHelperView
end

function CorPrCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	local fixPosList = {}
	local fixPetMoList = {}

	for posId = 1, 9 do
		if MissionModel.instance:isFixedPos(posId) then
			local petId = self:getCurFormation():GetPosition(posId)
			local petMo = self:getPetMoById(petId)

			if petMo then
				table.insert(fixPosList, posId)
				table.insert(fixPetMoList, petMo)
			end
		end
	end

	return CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petPool, needPets, fixPosList, fixPetMoList, self.needUpPetCount)
end

function CorPrCustomFmtMo:getFixedPosList()
	local fixedPosList = {}
	local helpCfg = CorPrChallengeConfig.instance:getCpHelperCfg(self._monsterData.helpPetPlanId)

	if helpCfg then
		for _, data in pairs(helpCfg) do
			if data.isFixedPos then
				table.insert(fixedPosList, data.posId)
			end
		end
	end

	return fixedPosList
end

function CorPrCustomFmtMo:updateFormationMo()
	local posList = {}
	local petPool = {}
	local needPets = {}
	local fixPosList = {}
	local fixPetMoList = {}
	local curPosPetList = self:getCurFormation():GetPositions()

	for curPosId, curPetId in ipairs(curPosPetList) do
		table.insert(posList, curPosId)

		petPool[curPosId] = self:getPetMoById(curPetId)
	end

	local helpCfg = CorPrChallengeConfig.instance:getCpHelperCfg(self._monsterData.helpPetPlanId)

	if helpCfg then
		for _, data in pairs(helpCfg) do
			if data.isFixedPos then
				table.insert(fixPosList, data.posId)
				table.insert(fixPetMoList, self:getPetMoById(checknumber(data.creepsId)))
			end
		end
	end

	local posIds, petMos = CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petPool, needPets, fixPosList, fixPetMoList, self.needUpPetCount)
	local posPetList = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	for idx, posId in ipairs(posIds) do
		local petMo = petMos[posId]

		if petMo then
			posPetList[posId] = petMo:getId()
		end
	end

	self:getCurFormation():_setAllPositions(posPetList)
end

return CorPrCustomFmtMo
