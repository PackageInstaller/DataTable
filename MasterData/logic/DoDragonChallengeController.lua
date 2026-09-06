-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/controller/DoDragonChallengeController.lua

module("logic.extensions.dodragonchallenge.controller.DoDragonChallengeController", package.seeall)

local DoDragonChallengeController = class("DoDragonChallengeController", BaseController)

function DoDragonChallengeController:ctor()
	return
end

function DoDragonChallengeController:onInit()
	self:onReset()
end

function DoDragonChallengeController:onReset()
	return
end

function DoDragonChallengeController:sendPM_DisorderDragonChallengeGetInfoReq(activityId)
	DisorderDragonChallengeAgent.instance:sendPM_DisorderDragonChallengeGetInfoReq(activityId)
end

function DoDragonChallengeController:handlePM_DisorderDragonChallengeGetInfoRes(msg)
	DoDragonChallengeModel.instance:handlePM_DisorderDragonChallengeGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DisorderDragonChallengeGetInfoRes)
end

function DoDragonChallengeController:sendPM_DisorderDragonChallengeAllReq(activityId, challengeId, form)
	DisorderDragonChallengeAgent.instance:sendPM_DisorderDragonChallengeAllReq(activityId, challengeId, form)
end

function DoDragonChallengeController:handlePM_DisorderDragonChallengeAllRes(status, msg)
	if status == 0 then
		DoDragonChallengeModel.instance:handlePM_DisorderDragonChallengeAllRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DisorderDragonChallengeAllRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DoDragonChallengeController:sendPM_DisorderDragonChallengeExtremeReq(activityId, isTry, form)
	DisorderDragonChallengeAgent.instance:sendPM_DisorderDragonChallengeExtremeReq(activityId, isTry, form)
end

function DoDragonChallengeController:handlePM_DisorderDragonChallengeExtremeRes(status, msg)
	if status == 0 then
		DoDragonChallengeModel.instance:handlePM_DisorderDragonChallengeExtremeRes(msg)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DoDragonBossChallenge)
		GlobalDispatcher:dispatch(GlobalNotify.DisorderDragonChallengeExtremeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DoDragonChallengeController:handlePM_DisorderDragonChallengeAllResultRes(msg)
	DoDragonChallengeModel.instance:handlePM_DisorderDragonChallengeAllResultRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.DisorderDragonChallengeAllResultRes)
end

function DoDragonChallengeController:handlePM_DisorderDragonChallengeExtremeResultRes(msg)
	DoDragonChallengeModel.instance:handlePM_DisorderDragonChallengeExtremeResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DisorderDragonChallengeExtremeResultRes)
end

function DoDragonChallengeController:getActivityId()
	return 252001
end

function DoDragonChallengeController:getActivityType()
	return GameEnum.ActivityType.DoDragonChallenge
end

function DoDragonChallengeController:isInActivityTimeAsDoDragon(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DoDragonChallengeController:enterBattleAsUnit(activityId, challengeId)
	local customFmtMo = DoDragonChallengeModel.instance:getCustomFmtMoAsUnit()

	customFmtMo:updateCfg(activityId, challengeId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DoDragonChallengeController:enterBattleAsBoss(activityId, isTry)
	local customFmtMo = DoDragonChallengeModel.instance:getCustomFmtMoAsBoss()

	customFmtMo:updateCfg(activityId, isTry)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DoDragonChallengeController:getTryEnteryUnitViewResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTimeAsUnit(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif self:isCollectEnoughAsUnit(activityId) then
		result = GameEnum.ResultCode.IsCollectEnough
		tips = "您已通关"
	end

	return result, tips
end

function DoDragonChallengeController:getTryUnitBtlResultAndTips(activityId, challengeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTimeAsUnit(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif self:isCollectEnoughAsUnit(activityId) then
		result = GameEnum.ResultCode.IsCollectEnough
		tips = "您已通关"
	elseif self:isPassPartAsUnit(activityId, challengeId) then
		result = GameEnum.ResultCode.IsPass
		tips = "无序火种已熄灭不可再挑战"
	end

	return result, tips
end

function DoDragonChallengeController:isInActivityTimeAsUnit(activityId)
	return self:isInActivityTimeAsDoDragon(activityId)
end

function DoDragonChallengeController:isCollectEnoughAsUnit(activityId)
	local isCollectEnough = false

	if activityId > 0 then
		local fireNum = DoDragonChallengeModel.instance:getFireNumAsUnit(activityId)
		local totalFireNum = DoDragonChallengeConfig.instance:getTotalFireNum(activityId)

		isCollectEnough = totalFireNum <= fireNum
	end

	return isCollectEnough
end

function DoDragonChallengeController:isAllPassAsUnit(activityId)
	local isAllPass = true

	if activityId > 0 then
		local challengeIdList = DoDragonChallengeModel.instance:getChallengeIdListAsUnit(activityId)

		for _, challengeId in ipairs(challengeIdList) do
			local result = DoDragonChallengeModel.instance:getChallengeIdResultAsUnit(activityId, challengeId)

			if result == 0 then
				isAllPass = false

				break
			end
		end
	end

	return isAllPass
end

function DoDragonChallengeController:isAllSuccessAsUnit(activityId)
	local isAllSuccess = true

	if activityId > 0 then
		local challengeIdList = DoDragonChallengeModel.instance:getChallengeIdListAsUnit(activityId)

		for _, challengeId in ipairs(challengeIdList) do
			local result = DoDragonChallengeModel.instance:getChallengeIdResultAsUnit(activityId, challengeId)

			if result ~= 1 then
				isAllSuccess = false

				break
			end
		end
	end

	return isAllSuccess
end

function DoDragonChallengeController:isPassPartAsUnit(activityId, challengeId)
	local isPass = true

	if activityId > 0 then
		local result = DoDragonChallengeModel.instance:getChallengeIdResultAsUnit(activityId, challengeId)

		isPass = result ~= 0
	end

	return isPass
end

function DoDragonChallengeController:getTryEnteryBossViewResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTimeAsBoss(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif self:isPassAsBoss(activityId) then
		result = GameEnum.ResultCode.IsCollectEnough
		tips = "您已通关"
	end

	return result, tips
end

function DoDragonChallengeController:getTryBossBtlResultAndTips(activityId, isTry)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not isTry then
		if not self:isInActivityTimeAsBoss(activityId) then
			result = GameEnum.ResultCode.NotInTime
			tips = "不在活动时间范围内"
		elseif self:isPassAsBoss(activityId) then
			result = GameEnum.ResultCode.IsCollectEnough
			tips = "您已通关"
		elseif not self:isEnoughTimesAsBoss(activityId) then
			result = GameEnum.ResultCode.NotEnoughTimes
			tips = "挑战次数不足"
		end
	end

	return result, tips
end

function DoDragonChallengeController:isInActivityTimeAsBoss(activityId)
	return self:isInActivityTimeAsDoDragon(activityId)
end

function DoDragonChallengeController:isEnoughTimesAsBoss(activityId)
	local isEnoughTimes = false

	if activityId > 0 then
		local challengeTimes = DoDragonChallengeModel.instance:getChallengeTimesAsBoss(activityId)
		local totalChallengeTimes = DoDragonChallengeConfig.instance:getTotalChallengeTimes(activityId)

		isEnoughTimes = totalChallengeTimes - challengeTimes > 0
	end

	return isEnoughTimes
end

function DoDragonChallengeController:isPassAsBoss(activityId)
	return DoDragonChallengeModel.instance:isPassExtreme(activityId)
end

function DoDragonChallengeController:getTotalHp(activityId)
	return DoDragonChallengeModel.instance:getExtremeMaxHp(activityId)
end

DoDragonChallengeController.instance = DoDragonChallengeController.New()

return DoDragonChallengeController
