-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/model/ScenariocopyModel.lua

module("logic.extensions.scenariocopy.model.ScenariocopyModel", package.seeall)

local ScenariocopyModel = class("ScenariocopyModel", BaseModel)

ScenariocopyModel.TIANYAN_TAB = 2
ScenariocopyModel.WATER_TAB = 3
ScenariocopyModel.CHAPTER_TYPE_PLOT = 1
ScenariocopyModel.CHAPTER_TYPE_EASY = 2
ScenariocopyModel.CHAPTER_TYPE_NORMAL = 3
ScenariocopyModel.CHAPTER_TYPE_HARD = 4
ScenariocopyModel.TAB_STATE_EASY = 1
ScenariocopyModel.TAB_STATE_NORMAL = 2
ScenariocopyModel.TAB_STATE_HARD = 3
ScenariocopyModel.OnePeoplePlotId = 5
ScenariocopyModel.MoYanPlotId = 6
ScenariocopyModel.DUNGEONMAINHUDFIRSTCLICKREDPOINT = "DungeonMainHudFirstClickRedPoint"
ScenariocopyModel.COPYVIEWSHOPDAYFIRSTCLICKREDPOINT = "CopyViewShopDayFirstClickRedPoint"

function ScenariocopyModel:ctor()
	return
end

function ScenariocopyModel:onInit()
	self:onReset()
end

function ScenariocopyModel:onReset()
	self._activityId = 10001
	self._typeId = nil
	self._isStagePass = {}
	self._supportCfgs = {}
	self._supportPet = {}
	self._creepsIds = {}
	self._plotId = nil
	self._hasGetInfo = false
	self._selectTab = ScenariocopyModel.TAB_STATE_EASY
	self._buffLevel = 0
	self._hasGainBuffPrize = false
	self._formation = nil
	self.allPetList = nil
end

function ScenariocopyModel:refreshActIdandPlotId()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.OperationPlot)

	if actCfg == nil then
		return false
	end

	self:setActivityId(actCfg.activityId)

	local sccCfg = ScenariocopyConfig.instance:getActCfg(actCfg.activityId)

	if sccCfg then
		self._plotId = sccCfg.plotId
		self._trialId = sccCfg.trialId
	end

	return true
end

function ScenariocopyModel:isInActivityTime()
	return self:refreshActIdandPlotId() and self._hasGetInfo
end

function ScenariocopyModel:setStagePass(chapterId, stageId, isPerfert)
	if self._isStagePass[chapterId] == nil then
		self._isStagePass[chapterId] = {}
	end

	if self._isStagePass[chapterId][stageId] == nil then
		self._isStagePass[chapterId][stageId] = {}
	end

	self._isStagePass[chapterId][stageId].pass = true
	self._isStagePass[chapterId][stageId].perfert = isPerfert or self._isStagePass[chapterId][stageId].perfert
end

function ScenariocopyModel:getStagePass(chapterId, stageId)
	if chapterId == nil or stageId == nil then
		return true, false
	end

	if self._isStagePass[chapterId] == nil or self._isStagePass[chapterId][stageId] == nil then
		return false, false
	end

	return self._isStagePass[chapterId][stageId].pass, self._isStagePass[chapterId][stageId].perfert
end

function ScenariocopyModel:getActivityId()
	return self._activityId
end

function ScenariocopyModel:setActivityId(actId)
	self._activityId = checknumber(actId)
end

function ScenariocopyModel:getHasGetInfo()
	return self._hasGetInfo
end

function ScenariocopyModel:setHasGetInfo(torf)
	self._hasGetInfo = torf
end

function ScenariocopyModel:getBuffLevel()
	return self._buffLevel
end

function ScenariocopyModel:setBuffLevel(level)
	self._buffLevel = checknumber(level)
end

function ScenariocopyModel:getHasGainBuffPrize()
	return self._hasGainBuffPrize
end

function ScenariocopyModel:setHasGainBuffPrize(torf)
	self._hasGainBuffPrize = checkbool(torf)
end

function ScenariocopyModel:getPlotId()
	return self._plotId
end

function ScenariocopyModel:getTrialId()
	return self._trialId
end

function ScenariocopyModel:getTypeId()
	return self._typeId
end

function ScenariocopyModel:setTypeId(storyId, isTrial)
	printInfo("test 当前 storyId", storyId)

	self._typeId = storyId
	self._curIsTrial = isTrial
end

function ScenariocopyModel:getIsTrial()
	if self._curIsTrial then
		return self._curIsTrial
	else
		return false
	end
end

function ScenariocopyModel:getChapterId()
	return self._chapterId
end

function ScenariocopyModel:setChapterId(chapterId)
	self._chapterId = chapterId
end

function ScenariocopyModel:getStageId()
	return self._stageId
end

function ScenariocopyModel:setStageId(StageId)
	self._stageId = StageId
end

function ScenariocopyModel:getStageId()
	return self._stageId
end

function ScenariocopyModel:setStageId(StageId)
	self._stageId = StageId
end

function ScenariocopyModel:getChapterCfg()
	return self._chapterCfg
end

function ScenariocopyModel:setChapterCfg(cfg)
	self._chapterCfg = cfg
end

function ScenariocopyModel:setStageCfg(cfg)
	self._stageCfg = cfg
end

function ScenariocopyModel:getStageCfg()
	return self._stageCfg
end

function ScenariocopyModel:getSupportCfgs()
	return self._supportCfgs
end

function ScenariocopyModel:setSupportCfgs(cfg)
	local list = {}

	for k, v in pairs(cfg) do
		table.insert(list, v)
	end

	self._supportCfgs = list
end

function ScenariocopyModel:getSelectTab()
	return self._selectTab
end

function ScenariocopyModel:setSelectTab(tab)
	self._selectTab = tab
end

function ScenariocopyModel:createPet(creepsId)
	if self._stageCfg and self._stageCfg.supportId > 0 then
		local creepCfg = ScenariocopyConfig.instance:getSupportCfg(self._stageCfg.supportId, creepsId)
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(creepCfg)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.petId = creepsId
		petMo.isSupportedPet = true

		return petMo
	end
end

function ScenariocopyModel:getSupportPet(creepsId)
	if self._supportPet[creepsId] == nil then
		self._supportPet[creepsId] = self:createPet(creepsId)
	end

	return self._supportPet[creepsId]
end

function ScenariocopyModel:setFormation()
	self:setTeamId(self._teamId or 1)

	local maxNum = 5
	local count = 0
	local form = {
		formId = 10,
		pos = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		extParams = {
			heroSkillId = 0
		}
	}

	if self._formation == nil then
		self._formation = ScenariocopyFormationMO.New()

		self._formation:Clone(FormationNewModel.instance:GetCurTeam():GetCurFormation())
	end

	local isHaveSupportPet = #self._supportCfgs > 0

	if isHaveSupportPet then
		for _, v in ipairs(self._supportCfgs) do
			if maxNum <= count then
				printError(string.format("配置表支援精灵数量已达%s只，不应该超过最大%s只限制", count, maxNum))
			end

			if v.isFixedPos == true and count < maxNum then
				form.pos[v.posId] = v.creepsId
				count = count + 1
			end
		end
	end

	local allPetMoList = self:getAllPets(true)
	local positions = self._formation:GetPositions()
	local spPetOfNoSeatList = {}

	for posId, petId in ipairs(positions) do
		local isFormHaveSeat = form.pos[posId] == 0
		local isFitCount = count < maxNum
		local isMoHavePet = false
		local isSupportPet = false
		local isSpPet = false

		for _, mo in ipairs(allPetMoList) do
			isMoHavePet = isMoHavePet or petId == mo.petId
		end

		for i, v in ipairs(self._supportCfgs) do
			isSupportPet = isSupportPet or petId == v.creepsId and i <= maxNum
		end

		if self._formation:_getPet(petId) then
			local sId = checknumber(self._formation:_getPet(petId).summonMasterId)

			isSpPet = sId > 0 and self._formation:HasPet(sId)
		end

		if isFormHaveSeat and isFitCount and (isMoHavePet or isSupportPet) then
			if not isSpPet then
				count = count + 1
			end

			form.pos[posId] = petId
		end

		if isSpPet and not isFormHaveSeat then
			table.insert(spPetOfNoSeatList, petId)
		end
	end

	for spPosId, spPetId in ipairs(spPetOfNoSeatList) do
		for posId, petId in ipairs(form.pos) do
			if petId == 0 then
				form.pos[posId] = spPetId

				break
			end
		end
	end

	self._formation:SetData(form)
end

function ScenariocopyModel:getCurFormationId()
	return self._formation:GetId()
end

function ScenariocopyModel:getFormation()
	return self._formation
end

function ScenariocopyModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function ScenariocopyModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function ScenariocopyModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function ScenariocopyModel:getAllPets(force)
	if not self:getIsTrial() then
		return BagPetsController.instance:getFightBagPet()
	else
		if force or self.allPetList == nil then
			local allPets = {}
			local pool = {}
			local pets = BagPetsController.instance:getFightBagPet()
			local curStageCfg = self:getStageCfg()
			local isUseSupport = curStageCfg.supportId > 0

			if isUseSupport then
				local supportCfgs = ScenariocopyConfig.instance:getSupportCfgs(curStageCfg.supportId)

				for k, v in pairs(supportCfgs) do
					local fmo = FightingPowerPetMo.New()

					fmo:fromChallengeCreepCo(v)

					local petMo = fmo:toBaseBagPetMo()

					petMo.isSupportedPet = true

					table.insert(allPets, petMo)
				end
			end

			local isUseMax = curStageCfg.extreme

			for k, v in pairs(pets) do
				if isUseMax then
					local mo = FightingPowerPetMo.getMaxPetMoByData(v)

					pool[mo.raceId] = mo

					table.insert(allPets, mo)
				else
					local mo = v

					pool[mo.raceId] = mo

					table.insert(allPets, mo)
				end
			end

			self.allPetList = allPets
		end

		return self.allPetList
	end
end

function ScenariocopyModel:getPet(petId)
	if not petId or petId == 0 then
		return
	end

	local mo = BagPetsController.instance:getPet(petId)

	if self:getIsTrial() then
		local list = self:getAllPets()

		for i, v in ipairs(list) do
			if v.petId == petId then
				if mo then
					v.summonMasterId = mo.summonMasterId
					v.summonedPetId = mo.summonedPetId
					v.carriedMasterId = mo.carriedMasterId
					v.carriedPetId = mo.carriedPetId
					v.oracleMasterId = mo.oracleMasterId
					v.oraclePetId = mo.oraclePetId
					v.oraclePetRaceId = mo.oraclePetRaceId
					v.bookSpiritPetId = mo.bookSpiritPetId
					v.bookSpiritRaceId = mo.bookSpiritRaceId
					v.curFaceId = mo.curFaceId
				end

				return v
			end
		end
	else
		return mo
	end
end

function ScenariocopyModel:setTeamId(id)
	self._teamId = id
end

function ScenariocopyModel:getTeamId()
	return self._teamId
end

function ScenariocopyModel:getCreepsIds()
	return self._creepsIds
end

function ScenariocopyModel:setCreepsIds(CreepsIds)
	self._creepsIds = CreepsIds
end

function ScenariocopyModel:diffRacePetCount()
	local allPets = self:getAllPets()
	local tem = ScenariocopyFastFormation.instance:_filterByRace(allPets)

	return #tem
end

function ScenariocopyModel:checkHasInTeamByRaceId(raceId)
	for k, cfg in pairs(self._supportCfgs) do
		if raceId == cfg.raceId and cfg.isFixedPos == true then
			return true
		end
	end

	local formation = self:getFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = BagPetsController.instance:getPet(petId)

			if pet and pet.raceId == raceId then
				return true
			end
		end
	end

	return false
end

ScenariocopyModel.instance = ScenariocopyModel.New()

return ScenariocopyModel
