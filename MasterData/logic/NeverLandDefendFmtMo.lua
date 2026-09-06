-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/model/NeverLandDefendFmtMo.lua

module("logic.extensions.neverland.model.NeverLandDefendFmtMo", package.seeall)

local NeverLandDefendFmtMo = class("NeverLandDefendFmtMo", ICustomFmtMo)

function NeverLandDefendFmtMo:onReset()
	NeverLandDefendFmtMo.super.onReset(self)
end

function NeverLandDefendFmtMo:initParams(activityId)
	self._activityId = activityId
	self._actCfg = NeverLandConfig.instance:getActCfg(self._activityId)
end

function NeverLandDefendFmtMo:updateData()
	self.isShowOneKey = true

	local info = NeverLandConfig.instance:getMasterCfg(self._actCfg.defenseModeMonsterId)

	self.topTitleStr = info.name
	self.ruleDescStr = info.WinDesc
	self.validatorDescStr = info.stageDesc

	self:setFormCondition(info.formCondition)
	self:updateFormationMo()
end

function NeverLandDefendFmtMo:initFightHandler()
	local function handler()
		NeverLandController.instance:fightResult()

		local simpleForm = self:getCurSimpleForm()
		local mode = "defense"

		NeverLandController.instance:sendPM_NeverLandChallengeReq(self._activityId, mode, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function NeverLandDefendFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local supportPetCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.defenseModeSupportCreepsId)

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

function NeverLandDefendFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function NeverLandDefendFmtMo:getFinalFmoList(posList, petPool, needPets)
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

function NeverLandDefendFmtMo:getFixedPosList()
	local fixedPosList = {}
	local helpCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.defenseModeSupportCreepsId)

	if helpCfg then
		for _, data in pairs(helpCfg) do
			if data.isFixedPos then
				table.insert(fixedPosList, data.posId)
			end
		end
	end

	return fixedPosList
end

function NeverLandDefendFmtMo:updateFormationMo()
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

	local helpCfg = NeverLandConfig.instance:getSupportCfg(self._actCfg.defenseModeSupportCreepsId)

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

function NeverLandDefendFmtMo:getMonsterConfigList()
	return NeverLandConfig.instance:getCreepsCfg(self._actCfg.defenseModeMonsterId)
end

function NeverLandDefendFmtMo:getFmtInfoConfig()
	return NeverLandConfig.instance:getMasterCfg(self._actCfg.defenseModeMonsterId)
end

return NeverLandDefendFmtMo
