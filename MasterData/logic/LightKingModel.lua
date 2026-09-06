-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/LightKingModel.lua

module("logic.extensions.timelimitedchallenge.model.LightKingModel", package.seeall)

local LightKingModel = class("LightKingModel", BaseModel)

function LightKingModel:ctor()
	return
end

function LightKingModel:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
end

function LightKingModel:onReset()
	self._info = nil
	self._btlResult = nil
	self._rank = nil
	self._lastOpenTime = nil
end

function LightKingModel:getCurScore()
	local matType, matId = self:getItemTypeAndId()

	return MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function LightKingModel:getCurBuffLevel()
	if self._info then
		return checknumber(self._info.buffLevel)
	end

	return 0
end

function LightKingModel:getTodayHasUpgrade()
	if self._info then
		return self._info.todayHasUpgrade
	end

	return false
end

function LightKingModel:setTodayHasUpgrade(value)
	if self._info then
		self._info.todayHasUpgrade = value
	end
end

function LightKingModel:addBuffLevel()
	if self._info then
		self._info.buffLevel = checknumber(self._info.buffLevel) + 1
	end
end

function LightKingModel:isGainedById(id)
	if self._info then
		if self._info.hasGainProgressIds then
			for _, v in ipairs(self._info.hasGainProgressIds) do
				if v == id then
					return true
				end
			end
		end

		return false
	else
		return true
	end
end

function LightKingModel:addGainedId(id)
	if self._info then
		local ids = self._info.hasGainProgressIds

		if ids then
			table.insert(ids, id)
		end
	end
end

function LightKingModel:setInfo(info)
	self._info = info
end

function LightKingModel:getChallengeInfo(challengeType)
	if self._info then
		if not self._info.challengeInfo then
			for _, v in ipairs(self._info.challengeInfo) do
				if v.challengeType == challengeType then
					return v
				end
			end
		end
	end
end

function LightKingModel:getPetRankSize()
	if self._info then
		return checknumber(self._info.petRankSize)
	end

	return 0
end

function LightKingModel:getCurUsedTimes(challengeType)
	local challengeInfo = self:getChallengeInfo(challengeType)

	if challengeInfo then
		return challengeInfo.dailyUsedTimes
	end

	return 0
end

function LightKingModel:getCurBuyTimes(challengeType)
	local challengeInfo = self:getChallengeInfo(challengeType)

	if challengeInfo then
		return challengeInfo.dailyBuyTimes
	end

	return 0
end

function LightKingModel:addCurBuyTimes(challengeType)
	local challengeInfo = self:getChallengeInfo(challengeType)

	if challengeInfo then
		challengeInfo.dailyBuyTimes = challengeInfo.dailyBuyTimes + 1
	end
end

function LightKingModel:getCurStage(challengeType)
	local challengeInfo = self:getChallengeInfo(challengeType)

	if challengeInfo then
		return challengeInfo.stage
	end

	return 0
end

function LightKingModel:getItemTypeAndId()
	local itemId = LightKingConfig.instance:getConstantValue("ITEM_ID")

	return unpack(string.splitToNumber(itemId, ":"))
end

function LightKingModel:getChallengeId()
	return LightKingConfig.instance:getConstantValue("CHALLENGE_ID", true)
end

function LightKingModel:setCurChallengeType(value)
	self._curChallengeType = value
end

function LightKingModel:getCurChallengeType()
	return checknumber(self._curChallengeType)
end

function LightKingModel:getPetMo(petId)
	if checknumber(petId) <= 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	local stageCfg = self:getCurStageCfg()

	if not stageCfg then
		return
	end

	local supportCfg = LightKingConfig.instance:getSupportCfg(stageCfg.supportPlanId) or {}
	local creepCfg

	for _, v in pairs(supportCfg) do
		if v.creepsId == petId then
			creepCfg = v

			break
		end
	end

	return self:_createPet(creepCfg)
end

function LightKingModel:_createPet(creepCfg)
	if not creepCfg then
		return
	end

	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.isSupportedPet = true

	return petMo
end

function LightKingModel:getDiffRacePetNum()
	local pets = BagModel.instance:getBagPets()
	local helpPets = self:getAllHelpPets()

	for _, v in ipairs(helpPets) do
		if checknumber(v.summonMasterId) == 0 then
			table.insert(pets, v)
		end
	end

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

function LightKingModel:getAllHelpPets()
	local helpPets = {}
	local stageCfg = self:getCurStageCfg()

	if stageCfg then
		local supportCfg = LightKingConfig.instance:getSupportCfg(stageCfg.supportPlanId) or {}

		for _, v in pairs(supportCfg) do
			local pet = self:_createPet(v)

			table.insert(helpPets, pet)
		end
	end

	return helpPets
end

function LightKingModel:getCurStageCfg()
	local challengeType = self:getCurChallengeType()
	local curStage = self:getCurStage(challengeType)

	return (LightKingConfig.instance:getStageCfg(challengeType, curStage + 1))
end

function LightKingModel:setBtlResult(value)
	self._btlResult = value

	if self._btlResult.isWin then
		self:addStage(self._btlResult.challengeType)
	end
end

function LightKingModel:addStage(challengeType)
	local challengeInfo = self:getChallengeInfo(challengeType)

	if challengeInfo then
		challengeInfo.dailyUsedTimes = checknumber(challengeInfo.dailyUsedTimes) + 1
		challengeInfo.stage = checknumber(challengeInfo.stage) + 1
	end
end

function LightKingModel:getBtlResult()
	return self._btlResult
end

function LightKingModel:setRank(value)
	self._rank = value
end

function LightKingModel:getRank()
	return checknumber(self._rank)
end

function LightKingModel:getChallengeFinished(challengeType)
	local curStage = self:getCurStage(challengeType)
	local stageCfgs = LightKingConfig.instance:getStageCfgsByType(challengeType)
	local finalCfg = stageCfgs[#stageCfgs]

	if finalCfg then
		return curStage >= finalCfg.stage
	else
		return false
	end
end

function LightKingModel:getCurStageWinId()
	local stageCfg = self:getCurStageCfg()

	if self._curChallengeType == 2 and stageCfg then
		return {
			stageCfg.winId
		}
	else
		return {}
	end
end

local REDKEY = "LIGHTKING_DAILY_RED"

function LightKingModel:isDailyRedActive()
	local redKey = self:getRedKey()

	if not redKey then
		return
	end

	if self._lastOpenTime == nil then
		self._lastOpenTime = checknumber(GameUtil.getUserDayData(redKey))
	end

	local nowDate = ServerTime.nowDateServerLook()
	local lastDate = GameUtil.time2date(self._lastOpenTime)

	if nowDate.hour >= 5 then
		if not nowDate.day then
			local nowDay = nowDate.day - 1

			if lastDate.hour >= 5 then
				if not lastDate.day then
					local lastDay = lastDate.day - 1

					return nowDay ~= lastDay
				end
			end
		end
	end
end

function LightKingModel:_reloadData()
	self:clearDailyRed()
end

function LightKingModel:clearDailyRed()
	local redKey = self:getRedKey()

	if not redKey then
		return
	end

	GameUtil.saveUserDayData(redKey, 0)

	self._lastOpenTime = 0

	RedPointModel.instance:updateAllRedPoint()
end

function LightKingModel:saveDailyOpenTime()
	if not RedPointModel.instance:isActive(119) then
		return
	end

	local redKey = self:getRedKey()

	if not redKey then
		return
	end

	local now = ServerTime.now()

	self._lastOpenTime = now

	GameUtil.saveUserDayData(redKey, tostring(now))
	RedPointModel.instance:updateAllRedPoint()
end

function LightKingModel:getRedKey()
	local userId = RoleModel.instance:getUserId()

	if checknumber(userId) <= 0 then
		return nil
	else
		return REDKEY .. "_" .. userId
	end
end

LightKingModel.instance = LightKingModel.New()

return LightKingModel
