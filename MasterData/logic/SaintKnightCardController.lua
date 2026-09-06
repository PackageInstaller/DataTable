-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/controller/SaintKnightCardController.lua

module("logic.extensions.saintknightcard.controller.SaintKnightCardController", package.seeall)

local SaintKnightCardController = class("SaintKnightCardController", BaseController)

function SaintKnightCardController:ctor()
	return
end

function SaintKnightCardController:onInit()
	self:onReset()
end

function SaintKnightCardController:onReset()
	return
end

function SaintKnightCardController:sendSaintKnightCardGetInfoReq(actId)
	SaintKnightCardAgent.instance:sendPM_SaintKnightCardGetInfoReq(actId)
end

function SaintKnightCardController:handleSaintKnightCardGetInfoRes(msg)
	SaintKnightCardModel.instance:handleSaintKnightCardGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardGetInfoRes)
end

function SaintKnightCardController:sendSaintKnightCardGetRankInfoReq(actId, drawPlanId, groupId)
	SaintKnightCardAgent.instance:sendPM_SaintKnightCardGetRankInfoReq(actId, drawPlanId, groupId)
end

function SaintKnightCardController:handleSaintKnightCardGetRankInfoRes(msg)
	SaintKnightCardModel.instance:handleSaintKnightCardGetRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardGetRankInfoRes, msg)
end

function SaintKnightCardController:sendSaintKnightCardDrawReq(actId, drawPlanId, groupId)
	SaintKnightCardAgent.instance:sendPM_SaintKnightCardDrawReq(actId, drawPlanId, groupId)
end

function SaintKnightCardController:handleSaintKnightCardDrawRes(status, msg)
	if status == 0 then
		SaintKnightCardModel.instance:handleSaintKnightCardDrawRes(msg)

		local items = MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		for k, mo in pairs(items) do
			if mo.type ~= MatType.GodGem then
				ViewAutoShowController.instance:trySetAutoEvaluation(1, ViewAutoShowController.TAPTAP_FUNC_5)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardDrawRes, status, msg)
end

function SaintKnightCardController:sendSaintKnightCardGetRecordReq(actId)
	SaintKnightCardAgent.instance:sendPM_SaintKnightCardGetRecordReq(actId)
end

function SaintKnightCardController:handleSaintKnightCardGetRecordRes(msg)
	SaintKnightCardModel.instance:handleSaintKnightCardGetRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardGetRecordRes)
end

function SaintKnightCardController:sendSaintKnightCardGainExPrizeReq(actId, drawPlanId)
	SaintKnightCardAgent.instance:sendPM_SaintKnightCardGainExPrizeReq(actId, drawPlanId)
end

function SaintKnightCardController:handleSaintKnightCardGainExPrizeRes(msg)
	SaintKnightCardModel.instance:handleSaintKnightCardGainExPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardGainExPrizeRes)
end

function SaintKnightCardController:handleSaintKnightCardNotifyRes(msg)
	SaintKnightCardModel.instance:handleSaintKnightCardNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardNotifyRes)
end

function SaintKnightCardController:handleSaintKnightCardGainBuyRes(msg)
	return
end

function SaintKnightCardController:dailyRefresh()
	return
end

function SaintKnightCardController:isCanGetPrizeInPlan(drawPlanId)
	if not SaintKnightCardModel.instance:isDrawActivated(drawPlanId) then
		return false
	end

	local isCanGet = false
	local cfg = SaintKnightCardConfig.instance:getSkcPrizeCfgById(drawPlanId)

	for _, data in ipairs(cfg) do
		if self:isCanGetPrizeGroup(drawPlanId, data.groupId) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function SaintKnightCardController:isCanGetPrizeGroup(drawPlanId, groupId)
	return self:isPrizeGroupUnlock(drawPlanId, groupId) and not self:isHasGainPrizeGroup(drawPlanId, groupId)
end

function SaintKnightCardController:isHasGainPrizeGroup(drawPlanId, groupId)
	return SaintKnightCardModel.instance:isGainPrizeInDrawGroup(drawPlanId, groupId)
end

function SaintKnightCardController:isEnoughGetPrizeGroup(drawPlanId, groupId)
	local isActivated = SaintKnightCardModel.instance:isDrawActivated(drawPlanId)
	local isUnlock = self:isPrizeGroupUnlock(drawPlanId, groupId)

	return isActivated and isUnlock
end

function SaintKnightCardController:isPrizeGroupUnlock(drawPlanId, groupId)
	local data = SaintKnightCardConfig.instance:getSkcPrizeDataById(drawPlanId, groupId)
	local openTime = GameUtil.string2time(data.openTime)
	local nowTime = ServerTime.now()

	return openTime <= nowTime
end

function SaintKnightCardController:isCanGetExPrizeInDrawPlan(drawPlanId)
	return self:isEnoughGetExPrizeInDrawPlan(drawPlanId) and not self:isHasGainExPrizeInDrawPlan(drawPlanId)
end

function SaintKnightCardController:isHasGainExPrizeInDrawPlan(drawPlanId)
	return SaintKnightCardModel.instance:isGainExTraPrizeInDraw(drawPlanId)
end

function SaintKnightCardController:isEnoughGetExPrizeInDrawPlan(drawPlanId)
	return self:isInTimeActivatedInDrawPlan(drawPlanId) and self:isExPrizeUnlockInDrawPlan(drawPlanId)
end

function SaintKnightCardController:isExPrizeUnlockInDrawPlan(drawPlanId)
	local data = SaintKnightCardConfig.instance:getSkcDrawData(drawPlanId)
	local exTimeArray = string.split(data.extraPrizeOpenTime, "#")

	return GameUtil.getTimePeriodType(exTimeArray[1], exTimeArray[2]) > GameUtil.beforeTimePeriod
end

function SaintKnightCardController:isInTimeActivatedInDrawPlan(drawPlanId)
	return self:getTimePeriodOfPlanPayWithEx(drawPlanId) == GameUtil.inTimePeriod
end

function SaintKnightCardController:getTimePeriodOfPlanPayWithEx(drawPlanId)
	if not SaintKnightCardModel.instance:isDrawActivated(drawPlanId) then
		return GameUtil.errorTimePeriod
	end

	local data = SaintKnightCardConfig.instance:getSkcDrawData(drawPlanId)
	local exTimeArray = string.split(data.extraPrizeOpenTime, "#")
	local startTime, endTime = GameUtil.string2time(exTimeArray[1]), GameUtil.string2time(exTimeArray[2])
	local payTime = SaintKnightCardModel.instance:getPlanPayTime(drawPlanId)

	return GameUtil.getTimePeriodBySecWithOther(payTime, startTime, endTime)
end

SaintKnightCardController.instance = SaintKnightCardController.New()

return SaintKnightCardController
