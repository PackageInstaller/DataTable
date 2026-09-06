-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/model/StorySummaryCustomFmtMo.lua

module("logic.extensions.storysummary.model.StorySummaryCustomFmtMo", package.seeall)

local StorySummaryCustomFmtMo = class("StorySummaryCustomFmtMo", ICustomFmtMo)

function StorySummaryCustomFmtMo:onReset()
	StorySummaryCustomFmtMo.super.onReset(self)
end

function StorySummaryCustomFmtMo:initFightHandler()
	local function handler()
		StorySummaryController.instance:startSotrySummaryStageBattle(self._chapterId, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function StorySummaryCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
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

function StorySummaryCustomFmtMo:getFixedPosList()
	local fixedPosList = {}
	local supportCfg = StorySummaryConfig.instance:getSsSupportCfgByCSId(self._chapterId, self._stageId)

	for _, data in pairs(supportCfg) do
		if data.isFixedPos then
			table.insert(fixedPosList, data.posId)
		end
	end

	return fixedPosList
end

function StorySummaryCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function StorySummaryCustomFmtMo:initPetList()
	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, mo in pairs(bagPetMoList) do
		self:addPetToList(mo)
	end

	local isHaveSupport = StorySummaryController.instance:isSupportStage(self._chapterId, self._stageId)

	if isHaveSupport then
		local supportCfg = StorySummaryConfig.instance:getSsSupportCfgByCSId(self._chapterId, self._stageId)
		local fmo = FightingPowerPetMo.New()

		for _, data in pairs(supportCfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function StorySummaryCustomFmtMo:getMonsterConfigList()
	return StorySummaryConfig.instance:getSsCreepsCfgByCSId(self._chapterId, self._stageId)
end

function StorySummaryCustomFmtMo:getFmtInfoConfig()
	return StorySummaryConfig.instance:getSsCreepsCfgByCSId(self._chapterId, self._stageId)
end

function StorySummaryCustomFmtMo:updateCfg(chapterId, stageId)
	self._chapterId, self._stageId = checknumber(chapterId), checknumber(stageId)

	if self._chapterId == 0 or self._stageId == 0 then
		printError("布阵数据传入配置参数错误,检查 chapterId 与 stageId")

		return
	end
end

function StorySummaryCustomFmtMo:updateData()
	local stageData = StorySummaryConfig.instance:getSsStageData(self._chapterId, self._stageId)

	self.topTitleStr = stageData.stageName
	self.ruleDescStr = stageData.passDesc
	self.isShowBtnFormation = false

	self:updateFormationMo()
end

function StorySummaryCustomFmtMo:updateFormationMo()
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

	local supportCfg = StorySummaryConfig.instance:getSsSupportCfgByCSId(self._chapterId, self._stageId)

	for _, data in pairs(supportCfg) do
		if data.isFixedPos then
			table.insert(fixPosList, data.posId)
			table.insert(fixPetMoList, self:getPetMoById(checknumber(data.creepsId)))
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

return StorySummaryCustomFmtMo
