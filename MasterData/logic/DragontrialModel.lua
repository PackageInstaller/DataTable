-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/model/DragontrialModel.lua

module("logic.extensions.dragontrial.view.DragontrialModel", package.seeall)

local DragontrialModel = class("DragontrialModel", BaseModel)

DragontrialModel.DragontrialModel_DailyDot = "DragontrialModel.DragontrialModel_DailyDot"
DragontrialModel.DragontrialModel_ShopDot_Pre = "DragontrialModel.DragontrialModel_ShopDot_Pre"

function DragontrialModel:ctor()
	return
end

function DragontrialModel:onInit()
	self:onReset()

	self._activityType = GameEnum.ActivityType.DragonTrial
end

function DragontrialModel:onReset()
	self._firstTrialPassState = {}
	self._secDreamFightTime = 0
	self._secDreamBuyTime = 0
	self._secDragonFightTime = 0
	self._secDragonBuyTime = 0
	self._formations = {}
	self._mySysPetMos = {}
	self._petPlanId = nil
	self._firstTrialStageId = 0
	self._isDragonTrial = false
	self._damageInfos = {}
	self._dailyTaskInfos = {}
	self._dreamTaskInfos = {}
	self._bagPetMaxPowerList = {}
	self._isDataInit = {}
	self._rankMos = {}
	self._fristTrialForm = nil
	self._dreamTrialForm = nil
	self._secondTrialStage = 1
	self._currActEndTime = nil
end

function DragontrialModel:setInfos(msg)
	self._firstTrialPassState = GameUtil.pbToTable(msg.firstTrialPassState)
	self._secDreamFightTime = msg.secDreamFightTime
	self._secDreamBuyTime = msg.secDreamBuyTime
	self._secDragonFightTime = msg.secDragonFightTime
	self._secDragonBuyTime = msg.secDragonBuyTime
	self._damageInfos = msg.damageInfos
	self._dailyTaskInfos = msg.dailyTaskInfos
	self._dreamTaskInfos = msg.strengthenTaskInfos
	self._dreamTrialForm = msg.dreamTrialForm
	self._fristTrialForm = msg.fristTrialForm
	self._secondTrialStage = msg.secondTrialStage

	self:_initForm()
end

function DragontrialModel:_initForm()
	local activityId = self:getCurrActivityId()

	self:setFirstTrialForm(activityId, self._fristTrialForm)
	self:setDreamTrialForm(activityId, self._dreamTrialForm)
end

function DragontrialModel:isFirstTrialAllPass()
	if table.nums(self._firstTrialPassState) <= 0 then
		return false
	end

	local activityId = self:getCurrActivityId()
	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local cfgs = DragontrialConfig.instance:getStageCfgs(acfg.firstTrialId)

	if table.nums(self._firstTrialPassState) < #cfgs then
		return false
	end

	for i, v in pairs(self._firstTrialPassState) do
		if not v then
			return false
		end
	end

	return true
end

function DragontrialModel:getCurrActivityId()
	if self._currActEndTime and ServerTime.nowServerLook() < self._currActEndTime then
		return self._activityId
	end

	local acfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	if acfg then
		local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, acfg.activityId)

		self._currActEndTime = etime
		self._activityId = acfg.activityId
	else
		self._currActEndTime = nil

		return 0
	end

	return self._activityId
end

function DragontrialModel:getActEndTime()
	local activityId = self:getCurrActivityId()

	if activityId > 0 then
		local _, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, activityId)

		return etime
	else
		return ServerTime.nowServerLook()
	end
end

function DragontrialModel:isFirstTrialPass(id)
	return self._firstTrialPassState[id]
end

function DragontrialModel:getDreamFightTime()
	return self._secDreamFightTime
end

function DragontrialModel:getDreamBuyTime()
	return self._secDreamBuyTime
end

function DragontrialModel:getDragonFightTime()
	return self._secDragonFightTime
end

function DragontrialModel:getDragonBuyTime()
	return self._secDragonBuyTime
end

function DragontrialModel:getDragonFightLeftTime()
	local activityId = DragontrialModel.instance:getCurrActivityId()
	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local fightTime = DragontrialModel.instance:getDragonFightTime()
	local buyTime = DragontrialModel.instance:getDragonBuyTime()
	local totalTime = acfg.dragonTrialFreeTimes

	return totalTime + buyTime - fightTime
end

function DragontrialModel:getDreamFightLeftTime()
	local activityId = DragontrialModel.instance:getCurrActivityId()
	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local fightTime = DragontrialModel.instance:getDreamFightTime()
	local buyTime = DragontrialModel.instance:getDreamBuyTime()
	local totalTime = acfg.dreamTrialFreeTimes

	return totalTime + buyTime - fightTime
end

function DragontrialModel:isDreamFightOpen(stageId)
	return self._secondTrialStage == stageId
end

function DragontrialModel:getCurrSecondOpenStageId()
	return self._secondTrialStage
end

function DragontrialModel:getDreamMaxDamage(stageId)
	return (self._damageInfos[stageId] or nil) and (self._damageInfos[stageId].secDreamDamage or 0)
end

function DragontrialModel:getDragonMaxDamage(stageId)
	return (self._damageInfos[stageId] or nil) and (self._damageInfos[stageId].secDragonDamage or 0)
end

function DragontrialModel:setSecondMaxDamage(isDragonTrial, damage)
	if self._damageInfos[self._secondTrialStage] then
		if isDragonTrial then
			local old = self._damageInfos[self._secondTrialStage].secDragonDamage

			self._damageInfos[self._secondTrialStage].secDragonDamage = math.max(old, damage)
		else
			local old = self._damageInfos[self._secondTrialStage].secDreamDamage

			self._damageInfos[self._secondTrialStage].secDreamDamage = math.max(old, damage)
		end
	end
end

function DragontrialModel:getDailyTaskInfos()
	return self._dailyTaskInfos
end

function DragontrialModel:isGainDailyTaskPrize(taskId)
	for i, v in ipairs(self._dailyTaskInfos) do
		if v.taskId == taskId then
			return v.hasGainPrize
		end
	end

	return false
end

function DragontrialModel:getDreamTaskInfos()
	return self._dreamTaskInfos
end

function DragontrialModel:isGainDreamTaskPrize(raceId, taskId)
	for i, v in ipairs(self._dreamTaskInfos) do
		if v.raceId == raceId and v.taskId == taskId then
			return v.hasGain
		end
	end

	return false
end

function DragontrialModel:buyTimeRes(isDragonTrialBuy)
	if isDragonTrialBuy then
		self._secDragonBuyTime = self._secDragonBuyTime + 1
	else
		self._secDreamBuyTime = self._secDreamBuyTime + 1
	end
end

function DragontrialModel:dragonFightTimeAdd()
	self._secDragonFightTime = self._secDragonFightTime + 1
end

function DragontrialModel:dreamFightTimeAdd()
	self._secDreamFightTime = self._secDreamFightTime + 1
end

function DragontrialModel:setTrialFirstFightPass()
	if self._firstTrialStageId and self._firstTrialStageId > 0 then
		self._firstTrialPassState[self._firstTrialStageId] = true
	end
end

function DragontrialModel:viewRankRes(root, leaf, msg)
	self._isDataInit[root] = self._isDataInit[root] or {}
	self._isDataInit[root][leaf] = ServerTime.nowServerLook()
	self._rankMos[root] = self._rankMos[root] or {}
	self._rankMos[root][leaf] = msg
end

function DragontrialModel:getIsDataInit(root, leaf)
	if self._isDataInit[root] and self._isDataInit[root][leaf] then
		return ServerTime.nowServerLook() - checknumber(self._isDataInit[root][leaf]) < 5
	else
		return false
	end
end

function DragontrialModel:getRankMo(root, leaf)
	if self._rankMos[root] then
		return self._rankMos[root][leaf]
	else
		return nil
	end
end

function DragontrialModel:setFirstTrialForm(activityId, form)
	self._fristTrialForm = form

	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local formFristTrial = self._formations[acfg.firstTrialPetPlan]

	if not formFristTrial then
		formFristTrial = FormationMO.New(function(petId)
			return self:getPetWithPlanId(acfg.firstTrialPetPlan, petId)
		end)
		self._formations[acfg.firstTrialPetPlan] = formFristTrial
	end

	formFristTrial:SetData(self._fristTrialForm)
end

function DragontrialModel:setDreamTrialForm(activityId, form)
	self._dreamTrialForm = form

	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local formDream = self._formations[acfg.dreamTrialPetPlan]

	if not formDream then
		formDream = FormationMO.New(function(petId)
			return self:getPetWithPlanId(acfg.dreamTrialPetPlan, petId)
		end)
		self._formations[acfg.dreamTrialPetPlan] = formDream
	end

	formDream:SetData(self._dreamTrialForm)
end

function DragontrialModel:getDailyTaskProgress(taskId)
	for i, v in ipairs(self._dailyTaskInfos) do
		if v.taskId == taskId then
			return v.curProgress
		end
	end

	return 0
end

function DragontrialModel:gainDailyTaskPrizeRes(taskId)
	for i, v in ipairs(self._dailyTaskInfos) do
		if v.taskId == taskId then
			v.hasGainPrize = true
		end
	end
end

function DragontrialModel:gainCultivateTaskPrizeRes(raceId, taskId)
	for i, v in ipairs(self._dreamTaskInfos) do
		if v.taskId == taskId and v.raceId == raceId then
			v.hasGain = true
		end
	end
end

function DragontrialModel:validatePetStrengthenRes(petId, taskIds)
	local petMo = BagPetsController.instance:getPet(petId)

	if not petMo then
		return
	end

	local taskIds_idkey = {}

	for i, v in ipairs(taskIds) do
		taskIds_idkey[v] = true
	end

	for i, v in ipairs(self._dreamTaskInfos) do
		if v.raceId == petMo.raceId then
			v.hasFinish = not not taskIds_idkey[v.taskId]
		end
	end
end

function DragontrialModel:getDevelopTaskCfgsByRaceId(activityId, raceId)
	local list = DragontrialConfig.instance:getDevelopTaskCfgsByRaceId(activityId, raceId)
	local typeKeyList = {}

	for k, v in pairs(list) do
		typeKeyList[v.foldId] = typeKeyList[v.foldId] or {}

		table.insert(typeKeyList[v.foldId], v)
	end

	local finalListTemp = {}

	for foldId, typeList in pairs(typeKeyList) do
		table.sort(typeList, function(a, b)
			return a.taskId < b.taskId
		end)

		local bestCfg

		for i, v in ipairs(typeList) do
			local isGain = self:isGainDreamTaskPrize(raceId, v.taskId)

			if not isGain then
				bestCfg = bestCfg or v

				local isCanGain = self:checkCanGainDevelopPrizeByTaskId(raceId, v.taskId)

				if isCanGain then
					bestCfg = v

					break
				end
			end
		end

		finalListTemp[foldId] = bestCfg and bestCfg or typeList[#typeList]
	end

	local finalList = {}

	for k, v in pairs(finalListTemp) do
		table.insert(finalList, v)
	end

	table.sort(finalList, function(a, b)
		return a.taskId < b.taskId
	end)

	return finalList
end

function DragontrialModel:getDailyTaskCfgsFromModel(activityId)
	local list = DragontrialConfig.instance:getDailyTaskCfgs(activityId)
	local typeKeyList = {}

	for k, v in pairs(list) do
		typeKeyList[v.foldId] = typeKeyList[v.foldId] or {}

		table.insert(typeKeyList[v.foldId], v)
	end

	local finalListTemp = {}

	for foldId, typeList in pairs(typeKeyList) do
		table.sort(typeList, function(a, b)
			return a.taskId < b.taskId
		end)

		local bestCfg

		for i, v in ipairs(typeList) do
			local isGain = self:isGainDailyTaskPrize(v.taskId)

			if not isGain then
				bestCfg = bestCfg or v

				local isCanGain = self:checkCanGainDailyPrizeByTaskId(v.taskId)

				if isCanGain then
					bestCfg = v

					break
				end
			end
		end

		finalListTemp[foldId] = bestCfg and bestCfg or typeList[#typeList]
	end

	local finalList = {}

	for k, v in pairs(finalListTemp) do
		table.insert(finalList, v)
	end

	table.sort(finalList, function(a, b)
		return a.taskId < b.taskId
	end)

	return finalList
end

function DragontrialModel:getAllShowPetList(petPlanId, force)
	local pets = {}

	if petPlanId and petPlanId > 0 then
		for i, v in ipairs(DragontrialConfig.instance:getSysPetsByPlanId(petPlanId)) do
			local petMo = self:getPetWithPlanId(petPlanId, v.creepsId)

			table.insert(pets, petMo)
		end
	else
		pets = self:_getAllBagPetList(force)
	end

	return pets
end

function DragontrialModel:_getAllBagPetList(force)
	if force or self._allBagPetMaxPowerList == nil then
		local list = {}
		local pets = BagPetsController.instance:getFightBagPet()

		for k, v in pairs(pets) do
			local mo = self:getBagPet(v.petId)

			if mo then
				table.insert(list, mo)
			end
		end

		self._allBagPetMaxPowerList = list
	else
		local pool = {}

		for i, v in ipairs(self._allBagPetMaxPowerList) do
			pool[v.petId] = v
		end

		local pets = BagPetsController.instance:getFightBagPet()

		for k, v in pairs(pets) do
			if pool[v.petId] == nil then
				local mo = self:getBagPet(v.petId)

				if mo then
					table.insert(self._allBagPetMaxPowerList, mo)
				end
			end
		end
	end

	return self._allBagPetMaxPowerList
end

function DragontrialModel:getCurFormation(petPlanId)
	if petPlanId then
		self._formations[petPlanId] = self._formations[petPlanId] or FormationMO.New()

		return self._formations[petPlanId]
	else
		return FormationNewModel.instance:GetCurTeam():GetCurFormation()
	end
end

function DragontrialModel:getPetWithPlanId(petPlanId, petId)
	self._mySysPetMos[petPlanId] = self._mySysPetMos[petPlanId] or {}
	self._mySysPetMos[petPlanId][petId] = self._mySysPetMos[petPlanId][petId] or self:_createMyPet(petPlanId, petId)

	return self._mySysPetMos[petPlanId][petId]
end

function DragontrialModel:getBagPet(petId)
	if petId <= 0 then
		return nil
	end

	if not self._bagPetMaxPowerList[petId] then
		local petMo = BagModel.instance:getBagPetById(petId)

		if petMo then
			self._bagPetMaxPowerList[petId] = FightingPowerPetMo.getMaxPetMoByData(petMo)
		end
	end

	local mo = self._bagPetMaxPowerList[petId]

	if mo then
		local petMo = BagModel.instance:getBagPetById(petId)

		mo.summonMasterId = petMo.summonMasterId
		mo.summonedPetId = petMo.summonedPetId
		mo.carriedMasterId = petMo.carriedMasterId
		mo.carriedPetId = petMo.carriedPetId
		mo.oracleMasterId = petMo.oracleMasterId
		mo.oraclePetId = petMo.oraclePetId
		mo.oraclePetRaceId = petMo.oraclePetRaceId
		mo.curFaceId = petMo.curFaceId
		mo.bookSpiritPetId = petMo.bookSpiritPetId
		mo.bookSpiritRaceId = petMo.bookSpiritRaceId
	end

	return self._bagPetMaxPowerList[petId]
end

function DragontrialModel:_createMyPet(petPlanId, petId)
	local spPetCo = DragontrialConfig.instance:getSysPetCfg(petPlanId, petId)

	if not spPetCo then
		return
	end

	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(spPetCo)

	local bagPet = fPowerPet:toBaseBagPetMo()

	bagPet.petId = petId
	bagPet.rare = CharacterConfig.instance:getRareByAwakenLv(bagPet.awakeLevel, bagPet.raceId)
	bagPet.isMyPackPet = true

	return bagPet
end

function DragontrialModel:setCurrPetPlanId(petPlanId)
	self._petPlanId = petPlanId
end

function DragontrialModel:getCurrPetPlanId()
	return self._petPlanId
end

function DragontrialModel:diffRacePetCount(petPlanId)
	local pets = self:getAllShowPetList(petPlanId)

	ArraySort.sortOn(pets, "raceId")

	local lastId = -1
	local num = 0

	for i, v in ipairs(pets) do
		if lastId ~= v.raceId then
			lastId = v.raceId
			num = num + 1
		end
	end

	return num
end

function DragontrialModel:isFirstTrial()
	return self._firstTrialStageId and self._firstTrialStageId > 0
end

function DragontrialModel:setFirstTrialStageId(stageId)
	self._firstTrialStageId = stageId
end

function DragontrialModel:checkDailyRedDot()
	local activityId = self:getCurrActivityId()

	if activityId > 0 then
		return GameUtil.getUserDayData(DragontrialModel.DragontrialModel_DailyDot) ~= false
	else
		return false
	end
end

function DragontrialModel:clearDailyDot()
	GameUtil.saveUserDayData(DragontrialModel.DragontrialModel_DailyDot, false)
end

function DragontrialModel:checkDevelopTaskRedPoint()
	local cfgs = DragontrialConfig.instance:getDevelopTaskTabCfgs()

	for k, v in pairs(cfgs) do
		if self:checkDevelopTaskRedPointByRaceId(v.raceId) then
			return true
		end
	end

	return false
end

function DragontrialModel:checkDailyTaskRedPoint()
	local activityId = self:getCurrActivityId()

	if activityId > 0 then
		local cfgs = DragontrialConfig.instance:getDailyTaskCfgs(activityId)

		for k, v in pairs(cfgs) do
			if self:checkCanGainDailyPrizeByTaskId(v.taskId) then
				return true
			end
		end
	end

	return false
end

function DragontrialModel:checkDevelopTaskRedPointByRaceId(raceId)
	local activityId = self:getCurrActivityId()

	if activityId > 0 then
		local cfgs = DragontrialConfig.instance:getDevelopTaskCfgsByRaceId(activityId, raceId)

		for k, v in pairs(cfgs) do
			if self:checkCanGainDevelopPrizeByTaskId(v.raceId, v.taskId) then
				return true
			end
		end
	end

	return false
end

function DragontrialModel:checkCanGainDailyPrizeByTaskId(taskId)
	local isGain = self:isGainDailyTaskPrize(taskId)

	if not isGain then
		local currProgress = self:getDailyTaskProgress(taskId)
		local activityId = self:getCurrActivityId()

		if activityId > 0 then
			local tcfg = DragontrialConfig.instance:getDailyTaskCfg(activityId, taskId)

			return currProgress >= tcfg.maxProgress
		end
	end

	return false
end

function DragontrialModel:checkCanGainDevelopPrizeByTaskId(raceId, taskId)
	for i, v in ipairs(self._dreamTaskInfos) do
		if v.raceId == raceId and v.taskId == taskId then
			return v.hasFinish and not v.hasGain
		end
	end

	return false
end

function DragontrialModel:checkExchangeShopRedPoint()
	local activityId = self:getCurrActivityId()

	if activityId > 0 then
		return GameUtil.getUserData(DragontrialModel.DragontrialModel_ShopDot_Pre .. "@" .. activityId) ~= false
	else
		return false
	end
end

function DragontrialModel:clearExchangeShopRedPoint()
	local activityId = self:getCurrActivityId()

	GameUtil.saveUserData(DragontrialModel.DragontrialModel_ShopDot_Pre .. "@" .. activityId, false)
end

DragontrialModel.instance = DragontrialModel.New()

return DragontrialModel
