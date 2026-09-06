-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightMgr.lua

module("logic.extensions.holylight.view.HolyLightMgr", package.seeall)

local HolyLightMgr = class("HolyLightMgr")

HolyLightMgr.WorldState = {
	Light = 1,
	Dark = 2
}
HolyLightMgr.TriggerMode = {
	StayMode = 1,
	CloseMode = 0,
	MeetMode = 2
}
HolyLightMgr.GoItem = {
	UniversalDice = 1,
	FuncCard = 2,
	NormalDice = 0
}
HolyLightMgr.GridEvent = {
	Resources = 1,
	Double = 4,
	Buffs = 2,
	Finish = 5,
	Challenge = 3,
	None = 0
}

function HolyLightMgr:ctor(activityId)
	self._fightingPowerPetMo = FightingPowerPetMo.New()

	self:onReset(activityId)
end

function HolyLightMgr:onReset(activityId)
	self._activityId = activityId
	self._curGridId = 1
	self._curCircleId = 0
	self._curWorldState = HolyLightMgr.WorldState.Light
	self._normalDieceId = self._normalDieceId or 1

	local list = {}
	local cfg = HolyLightConfig.instance:getHlGridCfg(self._activityId)

	for _, data in ipairs(cfg) do
		table.insert(list, data.gridId)
	end

	self._gridIdList = list

	self:_onResetMasterPetMos()
end

function HolyLightMgr:updateGridInfo()
	return
end

function HolyLightMgr:getGridList()
	return self._gridIdList or {}
end

function HolyLightMgr:getGridCount()
	return #self:getGridList()
end

function HolyLightMgr:getCurGridId()
	return self._curGridId
end

function HolyLightMgr:setCurGridId(gridId)
	self._curGridId = gridId
end

function HolyLightMgr:addGridStep(gridStep)
	local count = self:getGridCount()
	local curGridId = self:getCurGridId()

	if count <= curGridId + gridStep then
		self:setCurCircleId(self:getCurCircleId() + 1)
	end

	local toGridId = (curGridId + gridStep - 1) % count + 1

	self:setCurGridId(toGridId)
end

function HolyLightMgr:getGridIdListOfForwardStep(formGridId, totalStep)
	local count = self:getGridCount()
	local list = {}
	local temp = formGridId

	for idx = 1, totalStep do
		temp = (temp + 1 - 1) % count + 1

		table.insert(list, temp)
	end

	return list
end

function HolyLightMgr:getCurFinishId()
	return HolyLightConfig.instance:getHlFinishIdWithTimes(self._activityId, self:getCurCircleId())
end

function HolyLightMgr:getCurCircleId()
	return self._curCircleId or 0
end

function HolyLightMgr:setCurCircleId(circleId)
	self._curCircleId = circleId
end

function HolyLightMgr:getCurWorldState()
	return self._curWorldState
end

function HolyLightMgr:setCurWorldState(state)
	self._curWorldState = state
end

function HolyLightMgr:getDoubleTime()
	return self._doubleTime or 0
end

function HolyLightMgr:setDoubleTime(val)
	self._doubleTime = val
end

function HolyLightMgr:getDoubleTimeOfTemp()
	return self._doubleTimeOfTemp or 0
end

function HolyLightMgr:setDoubleTimeOfTemp(val)
	self._doubleTimeOfTemp = val
end

function HolyLightMgr:getNormalDieceId()
	return self._normalDieceId
end

function HolyLightMgr:setNormalDieceId(dieceId)
	self._normalDieceId = dieceId
end

function HolyLightMgr:getTryUseNormalDicelResultAndTips(activityId, diceId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not self:isEnoughNumOfNormalDice() then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "当前骰子数量不足"
	elseif not self:isUnlockOfNormalDice(diceId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未解锁该骰子"
	end

	return result, tips
end

function HolyLightMgr:isEnoughNumOfNormalDice()
	return self:getNormalDiceNum() > 0
end

function HolyLightMgr:getNormalDiceNum()
	local matStr = HolyLightConfig.instance:getHlCommonValue("DICE")
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function HolyLightMgr:isUnlockOfNormalDice(diceId)
	local progress = self:getCreepsProgress()
	local data = HolyLightConfig.instance:getHlDiceData(self._activityId, diceId)
	local needProgress = data and data.unlock

	return needProgress <= progress
end

function HolyLightMgr:getTryUseUniversalDicelResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not self:isEnoughNumOfUniversalDice() then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "当前骰子数量不足"
	end

	return result, tips
end

function HolyLightMgr:isEnoughNumOfUniversalDice()
	return self:getUniversalDiceNum() > 0
end

function HolyLightMgr:getUniversalDiceNum()
	local matStr = HolyLightConfig.instance:getHlCommonValue("UNIVERSAL_DICE")
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function HolyLightMgr:getTryUseFuncCardResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not self:isEnoughNumOfFuncCard() then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "当前数量不足，请前往完成任务即可获得"
	end

	return result, tips
end

function HolyLightMgr:isEnoughNumOfFuncCard()
	return self:getFuncCardNum() > 0
end

function HolyLightMgr:getFuncCardNum()
	local matStr = HolyLightConfig.instance:getHlCommonValue("FUNCTION_CARD")
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function HolyLightMgr:getTryFightMasterResultAndTips(activityId, masterId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif self:isAllPassToFightMaster() then
		result = GameEnum.ResultCode.AllPass
		tips = "所有怪物已被击败"
	elseif self:isPassToFightMaster(masterId) then
		result = GameEnum.ResultCode.IsPass
		tips = "怪物已被击败"
	elseif not self:isEnoughTimesToFightMaster() then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = "索敌次数不足"
	end

	return result, tips
end

function HolyLightMgr:isAllPassToFightMaster()
	local maxMasterId = HolyLightConfig.instance:getHlMasterMaxId(self._activityId)

	return self:isPassToFightMaster(maxMasterId)
end

function HolyLightMgr:isPassToFightMaster(masterId)
	return masterId < self:getCurMasterId()
end

function HolyLightMgr:isEnoughTimesToFightMaster()
	return self:getCreepsTimes() > 0
end

function HolyLightMgr:getCreepsTimes()
	return self._creepsTimes or 0
end

function HolyLightMgr:setCreepsTimes(times)
	self._creepsTimes = times
end

function HolyLightMgr:getNextMasterId()
	local curMasterId = self:getCurMasterId()
	local maxMasterId = HolyLightConfig.instance:getHlMasterMaxId(self._activityId)

	return Mathf.Min(curMasterId, maxMasterId)
end

function HolyLightMgr:getCurMasterId()
	local masterId = 0
	local progress = self:getCreepsProgress()
	local cfg = HolyLightConfig.instance:getHlMasterCfg(self._activityId)

	for _, data in ipairs(cfg) do
		if progress >= data.times then
			masterId = data.masterId
		end
	end

	return masterId
end

function HolyLightMgr:getCreepsProgress()
	return self._creepsProgress or 0
end

function HolyLightMgr:setCreepsProgress(Progress)
	self._creepsProgress = Progress
end

function HolyLightMgr:getMasterPetMoList(masterId)
	return self._masterPetMoLists[masterId] or {}
end

function HolyLightMgr:_onResetMasterPetMos()
	local masterCfg = HolyLightConfig.instance:getHlMasterCfg(self._activityId)
	local fmo = self._fightingPowerPetMo
	local petMoLists = {}

	for _, masterData in ipairs(masterCfg) do
		local masterId = masterData.masterId
		local petMoList = {}
		local creepsCfg = HolyLightConfig.instance:getHlCreepsCfg(masterData.creepsMasterId)

		for _, creepsData in ipairs(creepsCfg) do
			fmo:fromChallengeCreepCo(creepsData)

			local petMo = fmo:toBaseBagPetMo()

			table.insert(petMoList, petMo)
		end

		petMoLists[masterId] = petMoList
	end

	self._masterPetMoLists = petMoLists
end

function HolyLightMgr:getMyPetIdList()
	return self._petIdList or {}
end

function HolyLightMgr:getMyPetInfo(petId)
	return self._petInfoPool[petId] or {}
end

function HolyLightMgr:getMyPetMo(petId)
	local info = self:getMyPetInfo(petId)

	return info._petMo
end

function HolyLightMgr:getMyPetRealLevel(petId)
	local info = self:getMyPetInfo(petId)

	return checknumber(info._realLevel)
end

function HolyLightMgr:isHasPetOfMy(petId)
	return self:getMyPetInfo(petId) ~= nil
end

function HolyLightMgr:setMyPetInfoPool(pets)
	local petInfoPool = {}
	local petIdList = {}
	local fmo = self._fightingPowerPetMo

	for _, v in ipairs(pets) do
		local petId = v.key
		local virtualLevel = v.value
		local realLevel = v.value
		local maxLevel = HolyLightConfig.instance:getHlPetMaxLevel(self._activityId, petId)

		realLevel = Mathf.Min(realLevel, maxLevel)

		local data = HolyLightConfig.instance:getHlPetData(self._activityId, petId, realLevel)

		if data == nil then
			printError(string.format("没有找到精灵配置: petId=%s, level=%s, ( ys运营-圣光普照.xlsx | export_系统精灵 )", petId, realLevel))
		else
			local info = {}

			info._petId = petId
			info._virtualLevel = virtualLevel
			info._realLevel = realLevel

			fmo:fromChallengeCreepCo(data)

			info._petMo = fmo:toBaseBagPetMo()
			petInfoPool[petId] = info

			table.insert(petIdList, info._petId)
		end
	end

	self._petInfoPool = petInfoPool
	self._petIdList = petIdList
end

function HolyLightMgr:getTryBuyShopPetResultAndTips(activityId, petId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif self:isPurchasedOfShopPet(petId) then
		result = GameEnum.ResultCode.IsPurchased
		tips = "已购买"
	elseif not self:isEnoughNumBuyPetOfShop(petId) then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "货币不足"
	end

	return result, tips
end

function HolyLightMgr:isEnoughNumBuyPetOfShop(petId)
	local needCost = self:getShopPetPrice(petId)
	local myGold = self:getMyGoldThePetOfShop(petId)

	return needCost <= myGold
end

function HolyLightMgr:getMyGoldThePetOfShop(petId)
	local goldNum = 0
	local level = self:getShopPetLevel(petId)
	local data = HolyLightConfig.instance:getHlPetData(self._activityId, petId, level)

	if data and not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		goldNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end

	return goldNum
end

function HolyLightMgr:getShopPetPrice(petId)
	local costPrice = 0
	local level = self:getShopPetLevel(petId)
	local data = HolyLightConfig.instance:getHlPetData(self._activityId, petId, level)

	if not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		costPrice = matNum
	end

	return costPrice
end

function HolyLightMgr:getShopPetIdList()
	return self._shopPetIdList or {}
end

function HolyLightMgr:getShopPetInfo(petId)
	return self._shopPetInfoPool[petId] or {}
end

function HolyLightMgr:getShopPetMo(petId)
	local info = self:getShopPetInfo(petId)

	return info._petMo
end

function HolyLightMgr:getShopPetLevel(petId)
	local info = self:getShopPetInfo(petId)

	return checknumber(info._level)
end

function HolyLightMgr:isPurchasedOfShopPet(petId)
	local info = self:getShopPetInfo(petId)

	return checkbool(info._isPurchased)
end

function HolyLightMgr:setShopPetInfoPool(randCreepsIds, usedRandCreepsIds)
	local petInfoPool = {}
	local petIdList = {}
	local fmo = self._fightingPowerPetMo
	local purchasedPetIdList = usedRandCreepsIds or {}

	for _, creepsId in ipairs(randCreepsIds) do
		local info = {}

		info._petId = creepsId
		info._level = 1
		info._isPurchased = table.indexof(purchasedPetIdList, creepsId)

		local data = HolyLightConfig.instance:getHlPetData(self._activityId, creepsId, info._level)

		fmo:fromChallengeCreepCo(data)

		info._petMo = fmo:toBaseBagPetMo()
		petInfoPool[creepsId] = info

		table.insert(petIdList, info._petId)
	end

	self._shopPetInfoPool = petInfoPool
	self._shopPetIdList = petIdList
end

function HolyLightMgr:getTryRefreshShopResultAndTips(activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not HolyLightController.instance:isInActivityTimeAsHolyLight(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not self:isEnoughNumOfRefreshShop(times) then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "货币不足"
	end

	return result, tips
end

function HolyLightMgr:isEnoughNumOfRefreshShop(times)
	local needCost = self:getRefreshCostOfShop(times)
	local myGold = self:getMyRefreshGoldOfShop(times)

	return needCost <= myGold
end

function HolyLightMgr:getRefreshCostOfShop(times)
	local costNum = 0
	local data = HolyLightConfig.instance:getHlRefreshDataByTimes(self._activityId, times)

	if data and not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		costNum = checknumber(matNum)
	end

	return costNum
end

function HolyLightMgr:getMyRefreshGoldOfShop(times)
	local goldNum = 0
	local data = HolyLightConfig.instance:getHlRefreshDataByTimes(self._activityId, times)

	if data and not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		goldNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end

	return goldNum
end

function HolyLightMgr:getRefreshTimesOfShop()
	return checknumber(self._refreshTimesOfShop)
end

function HolyLightMgr:setRefreshTimesOfShop(refreshTimes)
	self._refreshTimesOfShop = refreshTimes

	self:updateRedIdOfRefreshTimes()
end

function HolyLightMgr:getMyBuffIdList()
	return self._buffIdList or {}
end

function HolyLightMgr:getMyBuffInfo(buffId)
	return self._buffInfoPool[buffId] or {}
end

function HolyLightMgr:getVirtualLevelOfBuff(buffId)
	local info = self:getMyBuffInfo(buffId)

	return checknumber(info._virtualLevel)
end

function HolyLightMgr:getRealLevelOfBuff(buffId)
	local info = self:getMyBuffInfo(buffId)

	return checknumber(info._realLevel)
end

function HolyLightMgr:getMaxLevelOfBuff(buffId)
	local info = self:getMyBuffInfo(buffId)

	return checknumber(info._maxLevel)
end

function HolyLightMgr:setMyBuffInfoPool(buffs)
	local pool = {}

	for _, v in ipairs(buffs) do
		local buffId = v.key

		pool[buffId] = v.value
	end

	local buffInfoPool = {}
	local buffIdList = {}
	local cfgs = HolyLightConfig.instance:getHlBuffCfgs()

	for buffId = 1, #cfgs do
		if not pool[buffId] then
			if not pool[buffId] then
				local realLevel = 0
				local maxLevel = HolyLightConfig.instance:getHlBuffMaxLevel(buffId)

				realLevel = Mathf.Min(realLevel, maxLevel)

				local info = {}

				info._buffId = buffId
				info._virtualLevel = pool[buffId]
				info._realLevel = realLevel
				info._maxLevel = maxLevel
				buffInfoPool[buffId] = info

				table.insert(buffIdList, info._buffId)
			end
		end
	end

	self._buffInfoPool = buffInfoPool
	self._buffIdList = buffIdList
end

function HolyLightMgr:getDiceAnimToggle()
	local key = self:getKeyOfDiceAnimToggle()
	local value = GameUtil.getUserData(key) or 0

	return value == 1
end

function HolyLightMgr:setDiceAnimToggle(isOn)
	local key = self:getKeyOfDiceAnimToggle()
	local value = isOn and 1 or 0

	GameUtil.saveUserData(key, value)
end

function HolyLightMgr:getKeyOfDiceAnimToggle()
	return "KeyOfDiceAnimToggle"
end

function HolyLightMgr:updateRedIdOfRefreshTimes()
	local times = self:getRefreshTimesOfShop()
	local isCanRefresh = false
	local result, tips = self:getTryRefreshShopResultAndTips(self._activityId, times)
	local cost = self:getRefreshCostOfShop(times)

	isCanRefresh = result == GameEnum.ResultCode.Success and cost == 0

	local redPointId = RedPointModel.ID_HOLYLIGHT_PET_SHOP_REFRESH_TIMES
	local funcId = HolyLightConfig.instance:getHlCommonValue("FUNC_ID", true)

	if funcId == 0 then
		RedPointController.instance:setRedPointInfo(redPointId, isCanRefresh, true)
	else
		RedPointController.instance:setRedPointInfo(redPointId, isCanRefresh, true, nil, nil, {
			funcId
		})
	end
end

function HolyLightMgr:isNeedRedOfFuncCard()
	local result, tips = self:getTryUseFuncCardResultAndTips(self._activityId)

	return result == GameEnum.ResultCode.Success
end

function HolyLightMgr:isNeedRedOfUniversalDice()
	local result, tips = self:getTryUseUniversalDicelResultAndTips(self._activityId)

	return result == GameEnum.ResultCode.Success
end

function HolyLightMgr:isNeedRedOfNormalDice()
	local isNeedRed = false
	local cfg = HolyLightConfig.instance:getHlDiceCfg(self._activityId)

	for _, data in ipairs(cfg) do
		local result, tips = self:getTryUseNormalDicelResultAndTips(self._activityId, data.diceId)

		if result == GameEnum.ResultCode.Success then
			isNeedRed = true

			break
		end
	end

	return isNeedRed
end

return HolyLightMgr
