-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/controller/DressSellController.lua

module("logic.extensions.dressactivityshop.controller.DressSellController", package.seeall)

local DressSellController = class("DressSellController", BaseController)

function DressSellController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.refreshRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.refreshRedpoint, self)
end

function DressSellController:onReset()
	local activityId = DressDiscountModel.instance:getActivityId()

	if self:checkIsAfterCfgTime(activityId, 1) then
		RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_DISCOUNTDRESS_MOOR)
	end
end

function DressSellController:checkIsAfterCfgTime(activityId, id)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MoorDiscountDressGift, activityId)

	if not isInTime then
		return false
	end

	local data = DressSellConfig.instance:getDiscountCfgById(activityId, id)

	return GameUtil.getTimePeriod(data.sellStartTime, nil) == GameUtil.inTimePeriod
end

function DressSellController:getInfo(actId)
	DressSellAgent.instance:sendPM_DressSellGetInfoReq(actId)
end

function DressSellController:handleGetInfo(msg)
	DressSellModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DiscountDressSellInfoUpdate)
end

function DressSellController:buyGoods(actId, goodId)
	DressSellAgent.instance:sendPM_DressSellBuyReq(actId, goodId)
end

function DressSellController:handleBuyGoods(msg)
	return
end

function DressSellController:handleBuySuc(msg)
	DressSellModel.instance:onBuyGoodSuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DiscountDressSellInfoUpdate)
end

function DressSellController:refreshRedpoint()
	local cfg = DressSellModel.instance:getCurActTimeCfg()

	if cfg then
		local actId = cfg.activityId
		local userData = checkint(GameUtil.getUserData("Discount_Dress_Shop_" .. actId))

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DISCOUNTDRESSGIFT, userData <= 0)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DISCOUNTDRESSGIFT, false)
	end
end

function DressSellController:closeRedPointById(actId)
	GameUtil.saveUserData("Discount_Dress_Shop_" .. actId, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DISCOUNTDRESSGIFT, false)
end

function DressSellController:refreshCollectRedPoint()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MoorDiscountDressGift)

	if activityId > 0 then
		DressSellController.instance:sendGetDressDiscountInfo(activityId)

		local isLight = false
		local cfgs = DressSellConfig.instance:getDiscountCollectCfgs(activityId)

		for id = 1, #cfgs do
			local cfg = DressSellConfig.instance:getDiscountCollectCfg(activityId, id)
			local hasCount = MaterialModel.instance:getMaterialsNumber(cfg.type, cfg.param)
			local isGainPrize = DressDiscountModel.instance:isGainCollectPrize(id)

			if hasCount > 0 and not isGainPrize then
				isLight = true

				break
			end
		end

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DISCOUNTDRESS_COLLECTPRIZE, isLight)
	end
end

function DressSellController:sendGetDressDiscountInfo(activityId)
	DressDiscountAgent.instance:sendPM_DressDiscountGetInfoReq(activityId)
end

function DressSellController:onGetDressDiscountInfo(msg)
	DressDiscountModel.instance:onSetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DiscountDressMoorInfoUpdate)
end

function DressSellController:buyMoorGoods(activityId, id, gapId)
	DressDiscountAgent.instance:sendPM_DressDiscountBuyReq(activityId, id, gapId)
end

function DressSellController:buyMoorGoods(activityId, id, gapId)
	self.currTempActivityId = activityId

	DressDiscountAgent.instance:sendPM_DressDiscountBuyReq(activityId, id, gapId)
end

function DressSellController:handleBuyMoorSuc(msg)
	if msg.successed then
		DressDiscountModel.instance:onBuyGoodSuc(self.currTempActivityId, msg.dressInfo)
		GlobalDispatcher:dispatch(GlobalNotify.DiscountDressMoorInfoUpdate)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DiscountDressMoorBuyError)
	end
end

function DressSellController:handleRmbBuyMoorSuc(msg)
	DressDiscountModel.instance:onBuyGoodSuc(self.currTempActivityId, msg.info)
	GlobalDispatcher:dispatch(GlobalNotify.DiscountDressMoorInfoUpdate)
end

function DressSellController:sendPM_DressDisscountGainCollectPrizeReq(activityId, id)
	DressDiscountAgent.instance:sendPM_DressDisscountGainCollectPrizeReq(activityId, id)
end

function DressSellController:handlePM_DressDisscountGainCollectPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DressDisscountGainCollectPrizeRes)
end

DressSellController.instance = DressSellController.New()

return DressSellController
