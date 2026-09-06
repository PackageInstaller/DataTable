-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/controller/SevenDaysController.lua

module("logic.extensions.sevendays.controller.SevenDaysController", package.seeall)

local SevenDaysController = class("SevenDaysController", BaseController)

function SevenDaysController:ctor()
	return
end

function SevenDaysController:onInit()
	SevenDaysController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
	SevenDayTaskAgent.instance:addHandler(SevenDayTaskAgent.PM_SevenDayTaskGetInfoRes, self.SCPushSevenDaysTaskData, self)
	SevenDayTaskAgent.instance:addHandler(SevenDayTaskAgent.PM_GainSevenDayTaskPrizeRes, self.SCPushReceiveTaskMsg, self)
	SevenDayTaskAgent.instance:addHandler(SevenDayTaskAgent.PM_GainSevenDayTaskScorePrizeRes, self.SCPushReceiveScoreMsg, self)
	SignInAgent.instance:addHandler(SignInAgent.SignInInfoRes, self.SCPushSignInfo, self)
	TrainerCourseAgent.instance:addHandler(TrainerCourseAgent.PM_TrainerCourseGetInfoRes, self.SCPushClassInfo, self)
	TrainerCourseAgent.instance:addHandler(TrainerCourseAgent.PM_GainTrainerCoursePrizeRes, self.SCPushClassReceiveAndScore, self)
	TrainerCourseAgent.instance:addHandler(TrainerCourseAgent.PM_GainTrainerCourseScorePrizeRes, self.SCPushClassReceiveAndScore, self)
	TrainerCourseNewAgent.instance:addHandler(TrainerCourseNewAgent.PM_TrainerCourseGetInfoRes, self.SCPushClassInfo, self)
	TrainerCourseNewAgent.instance:addHandler(TrainerCourseNewAgent.PM_GainTrainerCoursePrizeRes, self.SCPushClassReceiveAndScore, self)
	TrainerCourseNewAgent.instance:addHandler(TrainerCourseNewAgent.PM_GainTrainerCourseScorePrizeRes, self.SCPushClassReceiveAndScore, self)
	WishingWellAgent.instance:addHandler(WishingWellAgent.WishingWellInfoRes, self.SCPushWishingWellInfo, self)
	WishingWellAgent.instance:addHandler(WishingWellAgent.WishingWellDrawRes, self.SCPushWishingWellDraw, self)
	WishingWellAgent.instance:addHandler(WishingWellAgent.WishingWellShopBuyRes, self.SCPushWishingWellShopBuy, self)
	WishingWellAgent.instance:addHandler(WishingWellAgent.WishingWellBroadcastRes, self.SCPushWishingWellBroadcast, self)
	WishingWellAgent.instance:addHandler(WishingWellAgent.NotifyWishingWellShopBuySucRes, self.SCPushNotifyWishingWellShopBuySuc, self)
end

function SevenDaysController:onReset()
	self.boxBuyId = 0
	self.wishCount = 1
	self.curTrainerCourseId = 0
end

function SevenDaysController:TickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.SevenSign) then
		self:CSRequestSignInfo()
	else
		SevenDaysModel.instance:ResetSevenSignInfo()
	end

	if ViewMgr.instance:isOpen(ViewName.TreasureBox) then
		self:CSRequestWishingWellInfo()

		local activityId = SevenDaysModel.instance:CalculationWishingWellOpen()

		if activityId <= 0 then
			activityId = 7001
		end

		ActivityshopController.instance:getAllShopItemInfo(SevenDaysModel.instance.trboxActivityType, activityId)
	end
end

function SevenDaysController:CSRequestSevenDaysTaskData()
	SevenDayTaskAgent.instance:sendPM_SevenDayTaskGetInfoReq()
end

function SevenDaysController:SCPushSevenDaysTaskData(msg)
	SevenDaysModel.instance:SCPushSevenDaysTaskData(msg)
	GlobalDispatcher:dispatch("UpdataSevenDaysTask")
end

function SevenDaysController:CSRequestReceiveTask(baseId)
	if baseId == nil or baseId <= 0 then
		return
	end

	SevenDayTaskAgent.instance:sendPM_GainSevenDayTaskPrizeReq(baseId)
end

function SevenDaysController:SCPushReceiveTaskMsg(msg)
	self:CSRequestSevenDaysTaskData()
end

function SevenDaysController:CSRequestReceiveScore(index)
	if index == nil or index < 0 then
		return
	end

	SevenDayTaskAgent.instance:sendPM_GainSevenDayTaskScorePrizeReq(index)
end

function SevenDaysController:SCPushReceiveScoreMsg(msg)
	self:CSRequestSevenDaysTaskData()
end

function SevenDaysController:GetRegisteredTimeDay(isForce)
	return SevenDaysModel.instance:GetRegisteredTimeDay(isForce)
end

function SevenDaysController:GetTaskDataByDays(dayId)
	dayId = dayId or SevenDaysModel.instance:GetRegisteredTimeDay()

	if dayId <= 0 or dayId > SevenDaysModel.instance.sevenDays then
		return
	end

	if dayId > 7 then
		dayId = 7
	end

	return SevenDaysModel.instance:GetTaskDataByDays(dayId)
end

function SevenDaysController:GetAccumulateScoreData()
	return SevenDaysModel.instance:GetAccumulateScoreData()
end

function SevenDaysController:GetLastScoreGoods()
	local tempList = self:GetAccumulateScoreData()

	if tempList == nil or tempList.scoreList == nil or #tempList.scoreList == 0 then
		return string.split("100:10329:1:1", ":")
	end

	local list = tempList.scoreList
	local str = list[#list].goods

	if not string.nilorempty(str) then
		return string.split(str, ":")
	end
end

function SevenDaysController:GetRegistTaskRedPoint()
	return SevenDaysModel.instance:GetRegistTaskRedPoint()
end

function SevenDaysController:GetDyasTaskRedPoint(dayId)
	dayId = dayId or SevenDaysModel.instance:GetRegisteredTimeDay()

	if dayId <= 0 or dayId > SevenDaysModel.instance.sevenDays then
		return false
	end

	if dayId > 7 then
		dayId = 7
	end

	return SevenDaysModel.instance:GetDyasTaskRedPoint(dayId)
end

function SevenDaysController:GetTitleTaskRedPoint(dayId, num)
	dayId = dayId or SevenDaysModel.instance:GetRegisteredTimeDay()

	if dayId <= 0 or dayId > SevenDaysModel.instance.sevenDays then
		return false
	end

	if dayId > 7 then
		dayId = 7
	end

	return SevenDaysModel.instance:GetTitleTaskRedPoint(dayId, num or 1)
end

function SevenDaysController:GetRegistScoreRedPoint()
	return SevenDaysModel.instance:GetRegistScoreRedPoint()
end

function SevenDaysController:CSRequestSignInfo()
	SignInAgent.instance:sendSignInInfoReq()
end

function SevenDaysController:SCPushSignInfo(msg)
	if msg == nil then
		return
	end

	SevenDaysModel.instance:SCPushSignInfo(msg)
end

function SevenDaysController:CSRequestSignInGainPrize(dayId)
	local prizeReq = PrizePublicDef_pb.PM_GainPrizeReq()

	prizeReq.petId = 0
	prizeReq.replacement = false

	SignInAgent.instance:sendSignInGainPrizeReq(prizeReq, dayId, function(msg)
		if msg == nil or msg.prizedDays == nil then
			return
		end

		SevenDaysModel.instance:SignInGainPrize(msg.prizedDays, dayId)
	end)
end

function SevenDaysController:CSRequestClassInfo(activityId)
	if activityId == 0 then
		TrainerCourseAgent.instance:sendPM_TrainerCourseGetInfoReq()
	else
		TrainerCourseNewAgent.instance:sendPM_TrainerCourseNewGetInfoReq(activityId)
	end
end

function SevenDaysController:SCPushClassInfo(msg)
	if msg == nil then
		return
	end

	SevenDaysModel.instance:SCPushExcellentClassInfo(msg)
end

function SevenDaysController:CSRequestClassReceive(activityId, taskId)
	if activityId == 0 then
		TrainerCourseAgent.instance:sendPM_GainTrainerCoursePrizeReq(taskId)
	else
		TrainerCourseNewAgent.instance:sendPM_GainTrainerCourseNewPrizeReq(activityId, taskId)
	end
end

function SevenDaysController:CSRequestClassScore(activityId, index)
	if activityId == 0 then
		TrainerCourseAgent.instance:sendPM_GainTrainerCourseScorePrizeReq(index)
	else
		TrainerCourseNewAgent.instance:sendPM_GainTrainerCourseScoreNewPrizeReq(activityId, index)
	end
end

function SevenDaysController:SCPushClassReceiveAndScore(msg)
	self:CSRequestClassInfo(checknumber(msg.activityId))
end

function SevenDaysController:CSRequestWishingWellInfo()
	WishingWellAgent.instance:sendWishingWellInfoReq()
end

function SevenDaysController:SCPushWishingWellInfo(msg)
	if msg == nil then
		return
	end

	SevenDaysModel.instance:PushWishingWellInfo(msg)
end

function SevenDaysController:CSRequestWishingWellDraw(count)
	self.wishCount = count

	WishingWellAgent.instance:sendWishingWellDrawReq(count)
end

function SevenDaysController:SCPushWishingWellDraw(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	SevenDaysModel.instance:PushWishingWellDraw(true, self.wishCount, msg.changeSetId)

	self.wishCount = 1
end

function SevenDaysController:CSRequestWishingWellShopBuy(itemId)
	self.boxBuyId = itemId

	WishingWellAgent.instance:sendWishingWellShopBuyReq(itemId)
end

function SevenDaysController:SCPushWishingWellShopBuy()
	SevenDaysModel.instance:SetShopGoodsBuyCount(self.boxBuyId)

	self.boxBuyId = 0
end

function SevenDaysController:CSRequestWishingWellBroadcast()
	WishingWellAgent.instance:sendWishingWellBroadcastReq()
end

function SevenDaysController:SCPushWishingWellBroadcast(msg)
	SevenDaysModel.instance:PushWishingWellBroadcast(msg)
end

function SevenDaysController:SCPushNotifyWishingWellShopBuySuc(msg)
	if msg == nil or msg.buyTimes == nil then
		return
	end

	SevenDaysModel.instance:PushWishingWellInfo(msg, true)
end

function SevenDaysController:CSRequestOneclickCollection()
	local list = SevenDaysModel.instance:GetAllGiftGoodsList()

	if list == nil or #list == 0 then
		return
	end

	local items = {}

	for i = 1, #list do
		if list[i] and list[i].goodsCount > 0 then
			table.insert(items, {
				id = checknumber(list[i].goodsId),
				num = checknumber(list[i].goodsCount)
			})
		end
	end

	if #items == 0 then
		return
	end

	MaterialFacade.instance:batchUseItem(MatType.Item, items, GameUtil.jsonToString({
		pi = 1
	}), function()
		SevenDaysModel.instance:PushWishingWellDraw()
	end)
end

SevenDaysController.instance = SevenDaysController.New()

return SevenDaysController
