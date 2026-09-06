-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/controller/SeekFoodController.lua

module("logic.extensions.seekfood.controller.SeekFoodController", package.seeall)

local SeekFoodController = class("SeekFoodController", BaseController)

function SeekFoodController:ctor()
	return
end

function SeekFoodController:onInit()
	return
end

function SeekFoodController:onReset()
	return
end

function SeekFoodController:sendPM_SeekFoodInfoReq(activityId)
	SeekFoodAgent.instance:sendPM_SeekFoodInfoReq(activityId)
end

function SeekFoodController:handlePM_SeekFoodInfoRes(msg)
	SeekFoodModel.instance:handlePM_SeekFoodInfoRes(msg)
	self:_updateRedIdAsAllFood(msg.activityId)
	self:_updateRedIdOfCanPrize(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.SeekFoodInfoRes)
end

function SeekFoodController:sendPM_SeekFoodDispatchReq(activityId, foodId, materialId, petIds)
	SeekFoodAgent.instance:sendPM_SeekFoodDispatchReq(activityId, foodId, materialId, petIds)
end

function SeekFoodController:handlePM_SeekFoodDispatchRes(msg)
	SeekFoodModel.instance:handlePM_SeekFoodDispatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SeekFoodDispatchRes)
end

function SeekFoodController:sendPM_SeekFoodGainDispatchReq(activityId, foodId, materialId)
	SeekFoodAgent.instance:sendPM_SeekFoodGainDispatchReq(activityId, foodId, materialId)
end

function SeekFoodController:handlePM_SeekFoodGainDispatchRes(status, msg)
	if status == 0 then
		SeekFoodModel.instance:handlePM_SeekFoodGainDispatchRes(status, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeekFoodGainDispatchRes, status, msg)
end

function SeekFoodController:sendPM_SeekFoodFightBossReq(activityId, foodId, form)
	SeekFoodAgent.instance:sendPM_SeekFoodFightBossReq(activityId, foodId, form)
end

function SeekFoodController:handlePM_SeekFoodFightBossRes(status, msg)
	if status == 0 then
		SeekFoodModel.instance:handlePM_SeekFoodFightBossRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeekFoodFightBossRes)
end

function SeekFoodController:sendPM_SeekFoodGainPrizeReq(activityId, prizeId)
	SeekFoodAgent.instance:sendPM_SeekFoodGainPrizeReq(activityId, prizeId)
end

function SeekFoodController:handlePM_SeekFoodGainPrizeRes(msg)
	SeekFoodModel.instance:handlePM_SeekFoodGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SeekFoodGainPrizeRes)
end

function SeekFoodController:handlePM_NotifySeekFoodFightBossEndRes(msg)
	SeekFoodModel.instance:handlePM_NotifySeekFoodFightBossEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifySeekFoodFightBossEndRes)
end

function SeekFoodController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function SeekFoodController:getActivityType()
	return GameEnum.ActivityType.SeekFood
end

function SeekFoodController:isInActivityTimeAsSeekFood(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function SeekFoodController:getToDayByActOpen(activityId)
	local actOriginTime, actFinalTime = ActivityDefineController.instance:getStartTimeAndEndTime(self:getActivityType(), activityId)
	local curTime = ServerTime.now()

	return GameUtil.getDaysByTimestamp(actOriginTime, curTime)
end

function SeekFoodController:enterBattleAsSf(activityId, foodId)
	local customFmtMo = SeekFoodModel.instance:getCustomFmtMoAsSf()

	customFmtMo:updateCfg(activityId, foodId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function SeekFoodController:_updateRedIdAsAllFood(activityId)
	local redId = SeekFoodConfig.instance:getRedIdOfFood(activityId)

	if string.nilorempty(redId) then
		return
	end

	local foodRedIdList = {}
	local cfg = SeekFoodConfig.instance:getSfFoodCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			self:_updateRedIdAsFood(activityId, data.foodId)
			table.insert(foodRedIdList, data.redId)
		end
	end

	RedPointController.instance:regMasterServantRed(redId, false, unpack(foodRedIdList))
end

function SeekFoodController:_updateRedIdAsFood(activityId, foodId)
	local redId = self:getRedIdAsFood(activityId, foodId)
	local isActivated = false
	local result = self:getTryGotoCollectResultAndTips(activityId, foodId)

	if result == GameEnum.ResultCode.Success then
		local isFitSeekTimes = self:isFitSeekTimes(activityId)
		local foodState = self:getFoodState(activityId, foodId)

		if isFitSeekTimes and foodState == SeekFoodModel.FoodState.HaveCanCollect or foodState == SeekFoodModel.FoodState.CanFightBoss or foodState == SeekFoodModel.FoodState.HaveCanGainCollect then
			isActivated = true
		end
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

function SeekFoodController:getRedIdAsFood(activityId, foodId)
	local data = SeekFoodConfig.instance:getSfFoodData(activityId, foodId)

	return data.redId
end

function SeekFoodController:_updateRedIdOfCanPrize(activityId)
	local redId = SeekFoodConfig.instance:getRedIdOfCanPrize(activityId)

	if string.nilorempty(redId) then
		return
	end

	local isActivated = false
	local cfg = SeekFoodConfig.instance:getSfPrizeCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if SeekFoodController.instance:isCanGetPrizeInProgress(activityId, data.prizeId) then
				isActivated = true
			end
		end
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

function SeekFoodController:getTryGotoCollectResultAndTips(activityId, foodId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInTimeOfFood(activityId, foodId) then
		result = GameEnum.ResultCode.NotInTime

		local startDate = SeekFoodConfig.instance:getOpenDateTimeOfFood(activityId, foodId)

		tips = string.format("%s后可收集", GameUtil.getFormatTimeByStamp(GameUtil.string2time(startDate), nil))
	elseif self:getFoodState(activityId, foodId) == SeekFoodModel.FoodState.HasFightBoss then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	return result, tips
end

function SeekFoodController:getTryCollectMaterialResultAndTips(activityId, foodId, materialId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local matState = SeekFoodModel.instance:getMaterialState(foodId, materialId)

	if not self:isFitSeekTimes(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "今日派遣次数已达上限"
	elseif matState == SeekFoodModel.MatState.HasFinishCollected then
		result = GameEnum.ResultCode.Error
		tips = "材料已采集"
	elseif matState == SeekFoodModel.MatState.CanFinishCollect then
		result = GameEnum.ResultCode.Error
		tips = "材料已采集"
	elseif matState == SeekFoodModel.MatState.Collecting then
		result = GameEnum.ResultCode.Error
		tips = "已在派遣中"
	else
		result, tips = self:getTryGotoCollectResultAndTips(activityId, foodId)
	end

	return result, tips
end

function SeekFoodController:getFoodState(activityId, foodId)
	if SeekFoodModel.instance:isFightedBoss(foodId) then
		return SeekFoodModel.FoodState.HasFightBoss
	end

	local state
	local isAllFinish = true
	local isHaveCanCollect = false
	local isHaveCanFinishCollect = false

	for _, materialId in ipairs(self:getMatIdListOfFood(activityId, foodId)) do
		state = SeekFoodModel.instance:getMaterialState(foodId, materialId)

		if state ~= SeekFoodModel.MatState.HasFinishCollected then
			isAllFinish = false
		end

		if state == SeekFoodModel.MatState.Normal then
			isHaveCanCollect = true
		elseif state == SeekFoodModel.MatState.CanFinishCollect then
			isHaveCanFinishCollect = true
		end
	end

	if isAllFinish then
		return SeekFoodModel.FoodState.CanFightBoss
	end

	if isHaveCanFinishCollect then
		return SeekFoodModel.FoodState.HaveCanGainCollect
	elseif isHaveCanCollect then
		return SeekFoodModel.FoodState.HaveCanCollect
	end

	return SeekFoodModel.FoodState.NoCanCollect
end

function SeekFoodController:getMatIdListOfFood(activityId, foodId)
	local matIdList = {}
	local cfg = SeekFoodConfig.instance:getSfMatCfg(activityId, foodId)

	for _, data in ipairs(cfg) do
		table.insert(matIdList, data.materialId)
	end

	return matIdList
end

function SeekFoodController:isInTimeOfFood(activityId, foodId)
	return self:getTimePeriodOfFood(activityId, foodId) == GameUtil.inTimePeriod
end

function SeekFoodController:getTimePeriodOfFood(activityId, foodId)
	local openDateTime = SeekFoodConfig.instance:getOpenDateTimeOfFood(activityId, foodId)

	return GameUtil.getTimePeriod(openDateTime, nil)
end

function SeekFoodController:getPetIdListOfFitToDis(activityId, foodId, materialId)
	local petIdList = {}
	local matData = SeekFoodConfig.instance:getSfMatData(activityId, foodId, materialId)
	local bagPetMoList = BagModel.instance:getBagPets()
	local petId = 0

	for idx = 1, matData.petNum do
		if not string.nilorempty(matData.validator[idx]) then
			for _, petMo in ipairs(bagPetMoList) do
				petId = petMo:getPetId()

				if petMo ~= nil and table.indexof(petIdList, petId) == false and self:isFitCond(petMo, matData.validator[idx]) then
					table.insert(petIdList, petId)

					break
				end
			end
		end
	end

	return petIdList
end

function SeekFoodController:isFitCond(petMo, val)
	return GameUtil.expScript(val, function(str)
		return FightingPowerFormula.instance:OnFilter(petMo, str)
	end)
end

function SeekFoodController:isFitSeekTimes(activityId)
	local curSeekTimes = SeekFoodModel.instance:getSeekTimes()
	local data = SeekFoodConfig.instance:getSfBaseData(activityId)
	local maxSeekTimes = data.seekTimes

	return curSeekTimes < maxSeekTimes
end

function SeekFoodController:getTryGainPrizeOfProResultAndTips(activityId, prizeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasGainPrize(prizeId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "您已领奖"
	elseif not self:isEnoughPrizeInProgress(activityId, prizeId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足领奖要求"
	end

	return result, tips
end

function SeekFoodController:isCanGetPrizeInProgress(activityId, prizeId)
	local result, tips = self:getTryGainPrizeOfProResultAndTips(activityId, prizeId)

	return result == GameEnum.ResultCode.Success
end

function SeekFoodController:isHasGainPrize(prizeId)
	return SeekFoodModel.instance:isHasGainPrize(prizeId)
end

function SeekFoodController:isEnoughPrizeInProgress(activityId, prizeId)
	local curProgress = self:getCurProgressOfFood(activityId)
	local data = SeekFoodConfig.instance:getSfPrizeData(activityId, prizeId)
	local needProgress = data.seekNum

	return needProgress <= curProgress
end

function SeekFoodController:getCurProgressOfFood(activityId)
	local progress = 0
	local foodCfg = SeekFoodConfig.instance:getSfFoodCfg(activityId)

	for _, data in ipairs(foodCfg) do
		local state = SeekFoodController.instance:getFoodState(activityId, data.foodId)

		if state == SeekFoodModel.FoodState.HasFightBoss then
			progress = progress + 1
		end
	end

	return progress
end

function SeekFoodController:getMaxProgressOfFood(activityId)
	local foodCfg = SeekFoodConfig.instance:getSfFoodCfg(activityId)

	return #foodCfg
end

SeekFoodController.instance = SeekFoodController.New()

return SeekFoodController
