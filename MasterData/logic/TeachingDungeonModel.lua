-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/model/TeachingDungeonModel.lua

module("logic.extensions.teachingdungeon.model.TeachingDungeonModel", package.seeall)

local TeachingDungeonModel = class("TeachingDungeonModel", BaseModel)

TeachingDungeonModel.RefreshBitInfo = "TeachingDungeonModel.RefreshBitInfo"
TeachingDungeonModel.OnBeginDrag = "TeachingDungeonModel.OnBeginDrag"
TeachingDungeonModel.OnEndDrag = "TeachingDungeonModel.OnEndDrag"

function TeachingDungeonModel:ctor()
	return
end

function TeachingDungeonModel:onInit()
	self:onReset()
	self:_calResetTime()
end

function TeachingDungeonModel:onReset()
	self._formation = nil
	self._teamId = 1
	self._perfectInfos = {}
	self._svrFormation = nil
	self._currStageId = 1
	self.stagePass = 0
	self.is_require = false
	self._resetDailyRedDotTime = 0
end

function TeachingDungeonModel:getPet(petId)
	return self:createPet(petId)
end

function TeachingDungeonModel:getAllPets(isEnemy)
	local allPets = {}
	local supportedPetIds = isEnemy and self:getEnemyConfigPetIds() or self:getConfigPetIds()

	if supportedPetIds then
		for i = 1, #supportedPetIds do
			local petId = supportedPetIds[i]

			allPets[#allPets + 1] = self:createPet(petId, isEnemy)
		end
	end

	return allPets
end

function TeachingDungeonModel:getConfigPetIds()
	return TeachingDungeonConfig.instance:getConfigPetIds()
end

function TeachingDungeonModel:getEnemyConfigPetIds()
	return TeachingDungeonConfig.instance:getEnemyConfigPetIds()
end

function TeachingDungeonModel:createPet(petId, isEnemy)
	if isEnemy then
		local var_8_0 = TeachingDungeonConfig.instance:getEnemyPetCfg(petId)

		if not var_8_0 then
			var_8_0 = TeachingDungeonConfig.instance:getPetCfg(petId)

			local spPetCo = var_8_0

			if not spPetCo then
				return
			end

			local fPowerPet = FightingPowerPetMo.New()

			fPowerPet:fromChallengeCreepCo(spPetCo)

			local bagPet = fPowerPet:toBaseBagPetMo()

			bagPet.petId = petId
			bagPet.rare = CharacterConfig.instance:getRareByAwakenLv(bagPet.awakeLevel, bagPet.raceId)

			return bagPet
		end
	end
end

function TeachingDungeonModel:setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = self._formation or TeachingFormationMO.New()

	self._formation:SetData(form)
	self:_saveAsSvrFometion(form)
end

function TeachingDungeonModel:getFormation()
	return self._formation
end

function TeachingDungeonModel:changePosition(pos, value)
	self._formation:SetPosition(pos, value)
end

function TeachingDungeonModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function TeachingDungeonModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function TeachingDungeonModel:getCurFormationId()
	return self._formation:GetId()
end

function TeachingDungeonModel:getFormPetsHeroSkills()
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

function TeachingDungeonModel:getTeamId()
	return self._teamId
end

function TeachingDungeonModel:_saveAsSvrFometion(form)
	return
end

function TeachingDungeonModel:saveCurrFormation()
	return
end

function TeachingDungeonModel:getPetIdInTeamByRaceId(raceId)
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))

			if pet.raceId == raceId then
				return pet.petId
			end
		end
	end

	return 0
end

function TeachingDungeonModel:onViewClose()
	self:saveCurrFormation()
end

function TeachingDungeonModel:setCurrStageId(stageId)
	self._currStageId = stageId

	local list = {}
	local pos = {}

	for i = 1, 9 do
		pos[i] = list[i] or 0
	end

	local form = {
		formId = 10,
		pos = pos,
		extParams = {
			heroSkillId = 0
		}
	}

	self:setFormation(form)
end

function TeachingDungeonModel:setStagePassBit(id)
	self.stagePass = id
end

function TeachingDungeonModel:setPerfectInfos(infos)
	self._perfectInfos = infos
end

function TeachingDungeonModel:getCurrStagePass()
	return self.stagePass
end

function TeachingDungeonModel:isStageCanChallenge(stageId)
	return self:getCurrStagePass() + 1 == stageId
end

function TeachingDungeonModel:setChallengeResault(isWin, changesetid)
	if isWin then
		TeachingDungeonController.instance:sendBC_ProcessInfoReq()
	end
end

function TeachingDungeonModel:getCurrStageId()
	return self._currStageId or 1
end

function TeachingDungeonModel:getMainTabDatas()
	return TeachingDungeonConfig.instance:getMainTabDatas()
end

function TeachingDungeonModel:isStageOpen(stageId)
	local unlockId = TeachingDungeonConfig.instance:getStageUnLokId(stageId)
	local fopen = FuncOpenModel.instance:getFuncIsOpen(unlockId)
	local preopen = self:isStagePass(stageId - 1)

	return fopen and preopen
end

function TeachingDungeonModel:isStagePass(stageId)
	if stageId <= 0 then
		return true
	end

	local passStage = self:getCurrStagePass()

	return stageId <= passStage
end

function TeachingDungeonModel:isStagePerfectPass(stageId)
	if stageId <= 0 then
		return false
	end

	if self._perfectInfos then
		for key, v in ipairs(self._perfectInfos) do
			if key - 1 == stageId and v then
				return true
			end
		end
	end

	return false
end

function TeachingDungeonModel:getOpenStageId()
	local list = self:getMainTabDatas()
	local stageId = 1

	for i, v in ipairs(list) do
		if not self:isStageOpen(v.stageId) and self:isStageOpen(v.stageId - 1) then
			break
		end

		stageId = v.stageId
	end

	return stageId
end

function TeachingDungeonModel:getStageOpenDesc(stageId)
	local prePass = self:isStagePass(stageId - 1)

	if not prePass then
		return "请先通关上一关卡"
	end

	local funId = TeachingDungeonConfig.instance:getStageUnLokId(stageId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funId)

	if cfg then
		if not cfg.description then
			return ""
		end
	end
end

function TeachingDungeonModel:isCurFormationEmpty()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function TeachingDungeonModel:bagCount()
	local list = TeachingDungeonConfig.instance:getConfigPetIds()

	return #list
end

function TeachingDungeonModel:isLevelPass(level)
	local isPass = true
	local cfgs = TeachingDungeonConfig.instance:getStageCfgByLevel(level)

	for i, v in ipairs(cfgs) do
		isPass = self:isStagePass(v.stageId)

		if not isPass then
			break
		end
	end

	return self:hasLevelCfg(level) and isPass
end

function TeachingDungeonModel:isLevelPerfect(level)
	local isPerfect = true
	local cfgs = TeachingDungeonConfig.instance:getStageCfgByLevel(level)

	for i, v in ipairs(cfgs) do
		isPerfect = self:isStagePerfectPass(v.stageId)

		if not isPerfect then
			break
		end
	end

	return self:hasLevelCfg(level) and isPerfect
end

function TeachingDungeonModel:hasLevelCfg(level)
	local cfgs = TeachingDungeonConfig.instance:getStageCfgByLevel(level)

	return #cfgs > 0
end

function TeachingDungeonModel:checkDailyRedDot()
	return FuncOpenModel.instance:getFuncIsOpen(68) and RedPointModel.instance:isActive(RedPointModel.ID_TEACHING) and self:_hasDailyRedDot()
end

function TeachingDungeonModel:_hasDailyRedDot()
	local key = self:_getRedDotKey()
	local cacheStr = Framework.LocalStorage.Instance:GetString(key)

	if cacheStr == "" then
		return true
	else
		local nowTime = ServerTime.nowServerLook()
		local resetTime = Framework.LocalStorage.Instance:GetString(key .. "_time")
		local lastClickTIme = checknumber(cacheStr)

		resetTime = checknumber(resetTime)

		if lastClickTIme < resetTime and resetTime < nowTime then
			return true
		end
	end

	return false
end

function TeachingDungeonModel:clearDailyRed()
	local key = self:_getRedDotKey()
	local nowTime = ServerTime.nowServerLook()

	Framework.LocalStorage.Instance:SetString(key, tostring(nowTime))
end

function TeachingDungeonModel:_getRedDotKey()
	return string.format("TeachingDungeonModel_%s_%s", tostring(LoginModel.instance.platformId), tostring(LoginModel.instance.userId))
end

function TeachingDungeonModel:refreshDailyDot()
	self:_calResetTime()
end

function TeachingDungeonModel:_calResetTime()
	local nowTime = ServerTime.nowServerLook()
	local date = GameUtil.time2date(nowTime)
	local resetTime = os.time({
		hour = 5,
		min = 0,
		sce = 0,
		year = date.year,
		month = date.month,
		day = date.day
	})
	local key = self:_getRedDotKey()

	Framework.LocalStorage.Instance:SetString(key .. "_time", tostring(resetTime))
end

TeachingDungeonModel.instance = TeachingDungeonModel.New()

return TeachingDungeonModel
