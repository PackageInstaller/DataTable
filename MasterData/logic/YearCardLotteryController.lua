-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/controller/YearCardLotteryController.lua

module("logic.extensions.yearcardlottery.controller.YearCardLotteryController", package.seeall)

local YearCardLotteryController = class("YearCardLotteryController", BaseController)

function YearCardLotteryController:onInit()
	self:onReset()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)

	self._actId = 8002
end

function YearCardLotteryController:onReset()
	return
end

function YearCardLotteryController:onRedPointChange()
	local redKey = RedPointModel.ID_YEARCARD_LOTTERY .. self._actId
	local curCfg = YearCardLotteryConfig.instance:getCommonCfg(self._actId)

	if ServerTime.now() > GameUtil.string2time(curCfg.startTime) then
		return
	end

	local isFirst = checknumber(GameUtil.getUserData(redKey)) <= 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YEARCARD_LOTTERY, isFirst)
end

function YearCardLotteryController:setRedPointInfo()
	local redKey = RedPointModel.ID_YEARCARD_LOTTERY .. self._actId

	GameUtil.saveUserData(redKey, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YEARCARD_LOTTERY, false)
end

function YearCardLotteryController:getCurRedKey()
	return RedPointModel.ID_YEARCARD_LOTTERY
end

function YearCardLotteryController:sendGetInfoReq(activityId)
	self._infoActivityId = activityId

	AnnualFeeSkinAgent.instance:sendPM_GetAnnualFeeSkinInfoReq(activityId)
end

function YearCardLotteryController:handleGetInfo(msg)
	YearCardLotteryModel.instance:onGetInfo(msg, self._infoActivityId)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardLotteryInfoUpdate)
end

function YearCardLotteryController:sendLotteryReq(activityId)
	self._lotteryActId = activityId

	AnnualFeeSkinAgent.instance:sendPM_AnnualFeeLotteryReq(activityId)
end

function YearCardLotteryController:handleLottery(msg)
	YearCardLotteryModel.instance:onLottery(msg, self._lotteryActId)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardFinishLottery)
end

function YearCardLotteryController:sendBuyReq(activityId, count)
	self._buyActId = activityId

	AnnualFeeSkinAgent.instance:sendPM_AnnualFeeBuyReq(activityId, count)
end

function YearCardLotteryController:handleBuy(msg)
	YearCardLotteryModel.instance:onBuy(msg, self._buyActId)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardLotteryInfoUpdate)
end

function YearCardLotteryController:openBuyCostMatView()
	UIStateManager.instance:push(ViewName.YearCardLotteryBuyView)
end

YearCardLotteryController.instance = YearCardLotteryController.New()

return YearCardLotteryController
