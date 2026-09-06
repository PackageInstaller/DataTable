-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/model/NeverLandAttackFmtMo.lua

module("logic.extensions.neverland.model.NeverLandAttackFmtMo", package.seeall)

local NeverLandAttackFmtMo = class("NeverLandAttackFmtMo", ICustomFmtMo)

function NeverLandAttackFmtMo:onReset()
	NeverLandAttackFmtMo.super.onReset(self)
end

function NeverLandAttackFmtMo:initParams(activityId)
	self._activityId = activityId
	self._actCfg = NeverLandConfig.instance:getActCfg(self._activityId)
end

function NeverLandAttackFmtMo:updateData()
	self.isShowOneKey = true

	local info = NeverLandConfig.instance:getMasterCfg(self._actCfg.attackModeMonsterId)

	self.topTitleStr = info.name
	self.ruleDescStr = info.WinDesc
	self.validatorDescStr = info.stageDesc

	self:setFormCondition(info.formCondition)
	self:updateFormationMo()
end

function NeverLandAttackFmtMo:initFightHandler()
	local function handler()
		NeverLandController.instance:fightResult()

		local simpleForm = self:getCurSimpleForm()
		local mode = "attack"

		NeverLandController.instance:sendPM_NeverLandChallengeReq(self._activityId, mode, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function NeverLandAttackFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local supportPetCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.attackModeSupportCreepsId)

	if not self._fpFmo then
		local fmo = FightingPowerPetMo.New()

		self._fpFmo = fmo

		for _, v in pairs(supportPetCfg) do
			fmo:fromChallengeCreepCo(v)
		end

		local petMo = fmo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function NeverLandAttackFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function NeverLandAttackFmtMo:getFinalFmoList(posList, petPool, needPets)
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

function NeverLandAttackFmtMo:getFixedPosList()
	local fixedPosList = {}
	local helpCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.attackModeSupportCreepsId)

	if helpCfg then
		for _, data in pairs(helpCfg) do
			if data.isFixedPos then
				table.insert(fixedPosList, data.posId)
			end
		end
	end

	return fixedPosList
end

function NeverLandAttackFmtMo:updateFormationMo()
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

	local helpCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.attackModeSupportCreepsId)

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

function NeverLandAttackFmtMo:getMonsterConfigList()
	return NeverLandConfig.instance:getCreepsCfg(self._actCfg.attackModeMonsterId)
end

function NeverLandAttackFmtMo:getFmtInfoConfig()
	return NeverLandConfig.instance:getMasterCfg(self._actCfg.attackModeMonsterId)
end

return NeverLandAttackFmtMo
