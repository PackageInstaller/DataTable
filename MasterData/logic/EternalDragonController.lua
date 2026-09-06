-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/controller/EternalDragonController.lua

module("logic.extensions.eternaldragon.controller.EternalDragonController", package.seeall)

local EternalDragonController = class("EternalDragonController", BaseController)

function EternalDragonController:ctor()
	return
end

function EternalDragonController:onInit()
	self:onReset()
end

function EternalDragonController:onReset()
	GlobalDispatcher:addListener("openrecastgloryshieldviewbyed", self._openrecastgloryshieldviewByEd, self)
	GlobalDispatcher:addListener("openflipgamebyed", self._openFlipGameByEd, self)
end

function EternalDragonController:sendPM_EternalDragonInfoReq(activityId)
	EternalDragonAgent.instance:sendPM_EternalDragonInfoReq(activityId)
end

function EternalDragonController:handlePM_EternalDragonInfoRes(msg)
	EternalDragonModel.instance:handlePM_EternalDragonInfoRes(msg)
	self:_updateRedOfWater(msg.activityId)
	self:_updateRedOfDisple(msg.activityId)
	self:_updateRedOfCut(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonInfoRes)
end

function EternalDragonController:sendPM_EternalDragonWaterReq(activityId)
	EternalDragonAgent.instance:sendPM_EternalDragonWaterReq(activityId)
end

function EternalDragonController:handlePM_EternalDragonWaterRes(msg)
	EternalDragonModel.instance:handlePM_EternalDragonWaterRes(msg)
	self:_updateRedOfWater(msg.activityId)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonWaterRes)
end

function EternalDragonController:sendPM_EternalDragonStartGameReq(activityId)
	local clientKey = math.random(1, 100000)

	EternalDragonModel.instance:saveClientKeyOfGame(clientKey)
	EternalDragonAgent.instance:sendPM_EternalDragonStartGameReq(activityId, clientKey)
end

function EternalDragonController:handlePM_EternalDragonStartGameRes(msg)
	EternalDragonModel.instance:handlePM_EternalDragonStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonStartGameRes, self._index)
end

function EternalDragonController:sendPM_EternalDragonEndGameReq(activityId, isPass)
	local clientKey = EternalDragonModel.instance:getClientKeyOfGame()
	local serverKey = EternalDragonModel.instance:getServerKeyOfGame()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		isPass and 1 or 0
	})

	EternalDragonAgent.instance:sendPM_EternalDragonEndGameReq(activityId, isPass, encryptedKey)
end

function EternalDragonController:handlePM_EternalDragonEndGameRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		EternalDragonModel.instance:handlePM_EternalDragonEndGameRes(msg)
		self:_updateRedOfDisple(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonEndGameRes, status)
end

function EternalDragonController:sendPM_EternalDragonCuttingReq(activityId)
	EternalDragonAgent.instance:sendPM_EternalDragonCuttingReq(activityId)
end

function EternalDragonController:handlePM_EternalDragonCuttingRes(msg)
	EternalDragonModel.instance:handlePM_EternalDragonCuttingRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self:_updateRedOfCut(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonCuttingRes)
end

function EternalDragonController:sendPM_EternalDragonGainPrizeReq(activityId, prizeId)
	EternalDragonAgent.instance:sendPM_EternalDragonGainPrizeReq(activityId, prizeId)
end

function EternalDragonController:handlePM_EternalDragonGainPrizeRes(msg)
	EternalDragonModel.instance:handlePM_EternalDragonGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalDragonGainPrizeRes)
end

function EternalDragonController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function EternalDragonController:getActivityType()
	return GameEnum.ActivityType.EternalDragon
end

function EternalDragonController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function EternalDragonController:isHasAllGrowEnd(activityId)
	local curGrowScore = self:getCurGrowScore()
	local maxGrowScoreBase = self:getMaxGrowScoreBase(activityId)

	return maxGrowScoreBase <= curGrowScore
end

function EternalDragonController:isHasReachGrow(activityId, growId)
	local curGrowScore = self:getCurGrowScore()
	local growScoreBase = self:getCurGrowScoreBase(activityId, growId)

	return growScoreBase <= curGrowScore
end

function EternalDragonController:getCurGrowProgressToNexGrow(activityId, score)
	return 1 - self:getLeftGrowProgressToNexGrow(activityId, score)
end

function EternalDragonController:getLeftGrowProgressToNexGrow(activityId, score)
	local growId = self:getGrowIdByScore(activityId, score)
	local progressLength = self:getProgressLengthToNextGrow(activityId, growId)
	local leftGrowScore = self:getLeftScoreToNextGrow(activityId, score)

	if progressLength ~= 0 then
		return string.format("%.3f", leftGrowScore / progressLength)
	else
		return 0
	end
end

function EternalDragonController:getLeftScoreToNextGrow(activityId, score)
	local growId = self:getGrowIdByScore(activityId, score)
	local nextGrowScoreBase = self:getNextGrowScoreBase(activityId, growId)

	return Mathf.Max(nextGrowScoreBase - score, 0)
end

function EternalDragonController:getProgressLengthToNextGrow(activityId, growId)
	local curGrowScoreBase = self:getCurGrowScoreBase(activityId, growId)
	local nextGrowScoreBase = self:getNextGrowScoreBase(activityId, growId)

	return Mathf.Max(nextGrowScoreBase - curGrowScoreBase, 0)
end

function EternalDragonController:getGrowDesc(activityId, growId)
	local data = EternalDragonConfig.instance:getEdScoreData(activityId, growId)

	return (data or nil) and (data.desc or "")
end

function EternalDragonController:getCurGrowId(activityId)
	local curGrowScore = self:getCurGrowScore()

	return self:getGrowIdByScore(activityId, curGrowScore)
end

function EternalDragonController:getGrowIdByScore(activityId, score)
	local curGrowId = 0
	local dataList = EternalDragonConfig.instance:getEdScoreDataList(activityId)

	for _, data in ipairs(dataList) do
		if score >= data.score then
			curGrowId = data.id
		else
			break
		end
	end

	return curGrowId
end

function EternalDragonController:getLastGrowId(activityId, growId)
	return Mathf.Max(growId - 1, 1)
end

function EternalDragonController:getNextGrowId(activityId, growId)
	local maxGrowId = self:getMaxGrowId(activityId)

	return (Mathf.Min(growId + 1, maxGrowId))
end

function EternalDragonController:getMaxGrowId(activityId)
	local dataList = EternalDragonConfig.instance:getEdScoreDataList(activityId)
	local data = dataList[#dataList]

	return (data or nil) and data.id
end

function EternalDragonController:getCurGrowScore()
	return EternalDragonModel.instance:getScore()
end

function EternalDragonController:getLastGrowScoreBase(activityId, growId)
	local lastGrowId = self:getLastGrowId(activityId, growId)

	return self:getCurGrowScoreBase(activityId, lastGrowId)
end

function EternalDragonController:getNextGrowScoreBase(activityId, growId)
	local nextGrowId = self:getNextGrowId(activityId, growId)

	return self:getCurGrowScoreBase(activityId, nextGrowId)
end

function EternalDragonController:getMaxGrowScoreBase(activityId)
	local maxGrowId = self:getMaxGrowId(activityId)

	return self:getCurGrowScoreBase(activityId, maxGrowId)
end

function EternalDragonController:getCurGrowScoreBase(activityId, growId)
	local data = EternalDragonConfig.instance:getEdScoreData(activityId, growId)

	return (data or nil) and data.score
end

function EternalDragonController:getOldGrowScore(activityId)
	local key = self:getUserDataKeyOfOldGrowScore(activityId)

	return checknumber(GameUtil.getUserData(key))
end

function EternalDragonController:svaeOldGrowScore(activityId, score)
	local key = self:getUserDataKeyOfOldGrowScore(activityId)

	GameUtil.saveUserData(key, score)
end

function EternalDragonController:getUserDataKeyOfOldGrowScore(activityId)
	return string.format("OldGrowScore" .. activityId)
end

function EternalDragonController:_updateRedOfWater(activityId)
	local redId = RedPointModel.ID_ETERNAL_DRAGON_WATER
	local result = self:getTryWaterResultAndTips(activityId)

	RedPointController.instance:setRedPointInfo(redId, result == GameEnum.ResultCode.Success)
end

function EternalDragonController:_updateRedOfDisple(activityId)
	local redId = RedPointModel.ID_ETERNAL_DRAGON_DISPEL
	local result = self:getTryDispleResultAndTips(activityId)

	RedPointController.instance:setRedPointInfo(redId, result == GameEnum.ResultCode.Success)
end

function EternalDragonController:_updateRedOfCut(activityId)
	local redId = RedPointModel.ID_ETERNAL_DRAGON_CUT
	local isActivated = false

	if self:isInActivityTime(activityId) and not self:isHasAllGrowEnd(activityId) then
		local result = self:getTryCutResultAndTips(activityId)

		isActivated = result == GameEnum.ResultCode.Success

		if not isActivated then
			local value = GameUtil.getUserDayData("day_red_key_Of_Cut")

			isActivated = value == 0
		end
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

function EternalDragonController:saveDailyRedOfCut(activityId)
	GameUtil.saveUserDayData("day_red_key_Of_Cut", 1)
	self:_updateRedOfCut(activityId)
end

function EternalDragonController:getTryWaterResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isHasAllGrowEnd(activityId) then
		result = GameEnum.ResultCode.Error
		tips = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfHasAllGrowEndInWater")
	elseif not self:isEnoughWaterTimes() then
		result = GameEnum.ResultCode.NotEnoughTimes
	end

	return result, tips
end

function EternalDragonController:isEnoughWaterTimes()
	return self:getLeftWaterTimes() > 0
end

function EternalDragonController:getLeftWaterTimes()
	return EternalDragonModel.instance:getLeftWaterTimes()
end

function EternalDragonController:getTryDispleResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isHasAllGrowEnd(activityId) then
		result = GameEnum.ResultCode.Error
		tips = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfHasAllGrowEndInDisple")
	elseif not self:isUnlockOfDisple(activityId) then
		result = GameEnum.ResultCode.Error

		local edActData = EternalDragonConfig.instance:getEdActData(activityId)
		local growId = EternalDragonController.instance:getGrowIdByScore(activityId, edActData.openGameLimit)
		local desc = self:getGrowDesc(activityId, growId)
		local tipsOfUnlockOfDisple = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfUnlockOfDisple")

		tips = string.format(tipsOfUnlockOfDisple, desc)
	elseif not self:isEnoughTimesOfDisple(activityId) then
		result = GameEnum.ResultCode.Error
		tips = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfEnoughTimesInDisple")
	end

	return result, tips
end

function EternalDragonController:isUnlockOfDisple(activityId)
	local edActData = EternalDragonConfig.instance:getEdActData(activityId)
	local limit = edActData.openGameLimit
	local curGrowScore = EternalDragonController:getCurGrowScore()

	return limit <= curGrowScore
end

function EternalDragonController:isEnoughTimesOfDisple(activityId)
	return self:getLeftGameTimes(activityId) > 0
end

function EternalDragonController:getLeftGameTimes(activityId)
	local maxTimes = self:getMaxGameTimes(activityId)
	local curTimes = self:getCurGameTimes()

	return Mathf.Max(maxTimes - curTimes, 0)
end

function EternalDragonController:getMaxGameTimes(activityId)
	local data = EternalDragonConfig.instance:getEdActData(activityId)

	return data and data.gameDailyTimes
end

function EternalDragonController:getCurGameTimes()
	return EternalDragonModel.instance:getGameTimes()
end

function EternalDragonController:getTryCutResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isHasAllGrowEnd(activityId) then
		result = GameEnum.ResultCode.Error
		tips = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfHasAllGrowEndInCut")
	elseif not self:isUnlockOfCut(activityId) then
		result = GameEnum.ResultCode.Error

		local edActData = EternalDragonConfig.instance:getEdActData(activityId)
		local growId = EternalDragonController.instance:getGrowIdByScore(activityId, edActData.openCuttingLimit)
		local desc = self:getGrowDesc(activityId, growId)
		local tipsOfUnlockOfCut = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfUnlockOfCut")

		tips = string.format(tipsOfUnlockOfCut, desc)
	elseif not self:isEnoughTimesOfCut(activityId) then
		result = GameEnum.ResultCode.Error
		tips = EternalDragonConfig.instance:getEdCommonValue(activityId, "tipsOfEnoughTimesInCut")
	end

	return result, tips
end

function EternalDragonController:_openrecastgloryshieldviewByEd(params)
	self._paramsOfopenrecastgloryshield = params

	local activityId = EternalDragonController.instance:getActivityId()

	if not EternalDragonController.instance:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(string.format("不在活动时间范围内(%s)", activityId))

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.EternalDragonInfoRes, self._handleOpenrecastgloryshieldviewByEdRes, self)
	EternalDragonController.instance:sendPM_EternalDragonInfoReq(activityId)
end

function EternalDragonController:_handleOpenrecastgloryshieldviewByEdRes()
	GlobalDispatcher:removeListener(GlobalNotify.EternalDragonInfoRes, self._handleOpenrecastgloryshieldviewByEdRes, self)

	local params = self._paramsOfopenrecastgloryshield

	self._paramsOfopenrecastgloryshield = nil

	if params == nil or #params <= 0 then
		return
	end

	local activityId = EternalDragonController.instance:getActivityId()
	local growId = self:getCurGrowId(activityId)
	local gameId = 0

	for _, v in ipairs(params) do
		local arr = string.split(v, ":")
		local aId = checknumber(arr[1])
		local bId = checknumber(arr[2])

		if aId == growId then
			gameId = bId

			break
		end
	end

	if gameId <= 0 then
		return
	end

	local gameData = RecastGloryConfig.instance:getGloryGameShieldCfg(gameId)

	if gameData == nil then
		FloatWordMgr.instance:show(string.format("当前成长进度为第%s阶段,但是缺失对应阶段的游戏配置,请检查配置表( yc运营-重铸荣光.xlsx | export_重铸盾牌游戏 )", gameId))

		return
	end

	local function successCallBack()
		if EternalDragonController.instance:isInActivityTime(activityId) then
			EternalDragonController.instance:sendPM_EternalDragonCuttingReq(activityId)
		end
	end

	RestoreGloryController.instance:openrecastgloryshieldview(gameId, successCallBack)
end

function EternalDragonController:_openFlipGameByEd(params)
	local activityId = checknumber(params[1])
	local edActivityId = self:getActivityId()

	if not self:isInActivityTime(edActivityId) then
		FloatWordMgr.instance:show(string.format("不在活动时间范围内(%s)", edActivityId))

		return
	end

	FlipGameController.instance:gotoFlipGameStartViewByEternalDragon(activityId, edActivityId)
end

function EternalDragonController:isUnlockOfCut(activityId)
	local edActData = EternalDragonConfig.instance:getEdActData(activityId)
	local limit = edActData.openCuttingLimit
	local curGrowScore = self:getCurGrowScore()

	return limit <= curGrowScore
end

function EternalDragonController:isEnoughTimesOfCut(activityId)
	return self:getCurCutTimes(activityId) > 0
end

function EternalDragonController:getMaxCutTimes(activityId)
	local energyId = self:getEnergyId(activityId)
	local maxEnergyNum = self:getMaxEnergyNum(activityId)

	return (self:changeEnergyNumToTimes(activityId, maxEnergyNum))
end

function EternalDragonController:getCurCutTimes(activityId)
	local curEnergyNum = self:getCurEnergyNum(activityId)

	return self:changeEnergyNumToTimes(activityId, curEnergyNum)
end

function EternalDragonController:isFullEnergy(activityId)
	local energyId = self:getEnergyId(activityId)

	return EnergyController.instance:isFullEnergy(energyId)
end

function EternalDragonController:getCurEnergyNum(activityId)
	local energyId = self:getEnergyId(activityId)

	return EnergyController.instance:getEnergyNum(energyId)
end

function EternalDragonController:getMaxEnergyNum(activityId)
	local energyId = self:getEnergyId(activityId)

	return EnergyController.instance:getMaxEnergyNum(energyId)
end

function EternalDragonController:changeEnergyNumToTimes(activityId, energyNum)
	local perCost = self:getEnergyCost(activityId)

	if perCost == 0 then
		return 0
	else
		return checkint(energyNum / perCost)
	end
end

function EternalDragonController:getEnergyId(activityId)
	local energyId = 0
	local data = EternalDragonConfig.instance:getEdActData(activityId)

	if not string.nilorempty(data.cuttingPhysicalCost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.cuttingPhysicalCost)

		energyId = matId
	end

	return energyId
end

function EternalDragonController:getEnergyCost(activityId)
	local perCost = 0
	local edActData = EternalDragonConfig.instance:getEdActData(activityId)

	if edActData then
		local matType, matId, matNum = MaterialMgr.getMatParams(edActData.cuttingPhysicalCost)

		perCost = matNum
	end

	return perCost
end

function EternalDragonController:getTryGainPrizeResultAndTips(activityId, growId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isHasGainPrize(growId) then
		result = GameEnum.ResultCode.Error
		tips = "已领取"
	elseif not self:isEnoughProgressOfPrize(activityId, growId) then
		result = GameEnum.ResultCode.Error
		tips = "未满足要求"
	end

	return result, tips
end

function EternalDragonController:getPrizeState(activityId, growId)
	local isHasGain = self:isHasGainPrize(growId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = self:isEnoughProgressOfPrize(activityId, growId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function EternalDragonController:isCanGainPrize(activityId, growId)
	return self:getTryGainPrizeResultAndTips(activityId, growId) == GameEnum.ResultCode.Success
end

function EternalDragonController:isHasGainPrize(growId)
	return EternalDragonModel.instance:isHasGainPrizeIds(growId)
end

function EternalDragonController:isEnoughProgressOfPrize(activityId, growId)
	local curGrowId = self:getCurGrowId(activityId)

	return growId <= curGrowId
end

EternalDragonController.instance = EternalDragonController.New()

return EternalDragonController
