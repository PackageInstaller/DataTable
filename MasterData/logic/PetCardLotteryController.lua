-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/controller/PetCardLotteryController.lua

module("logic.extensions.petcardlottery.controller.PetCardLotteryController", package.seeall)

local PetCardLotteryController = class("PetCardLotteryController", BaseController)
local WeekDays = {
	"周日",
	"周一",
	"周二",
	"周三",
	"周四",
	"周五",
	"周六"
}

function PetCardLotteryController:ctor()
	return
end

function PetCardLotteryController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
end

function PetCardLotteryController:onReset()
	return
end

function PetCardLotteryController:sendPM_PetCardLotteryGetInfoReq(activityId)
	PetCardLotteryAgent.instance:sendPM_PetCardLotteryGetInfoReq(activityId)
end

function PetCardLotteryController:handlePM_PetCardLotteryGetInfoRes(status, msg)
	PetCardLotteryModel.instance:setPetCardInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetCardLotteryGetInfoRes, msg)
end

function PetCardLotteryController:sendPM_PetCardLotterySelectCardReq(activityId, selectedPetIds)
	PetCardLotteryAgent.instance:sendPM_PetCardLotterySelectCardReq(activityId, selectedPetIds)
end

function PetCardLotteryController:handlePM_PetCardLotterySelectCardRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetCardLotterySelectCardRes, msg)
end

function PetCardLotteryController:sendPM_PetCardLotteryGainPrizeReq(activityId, dateInt)
	PetCardLotteryAgent.instance:sendPM_PetCardLotteryGainPrizeReq(activityId, dateInt)
end

function PetCardLotteryController:handlePM_PetCardLotteryGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetCardLotteryGainPrizeRes, msg)
end

function PetCardLotteryController:getTodayDateInt()
	local timeDate = ServerTime.nowDate()
	local year, month, day = timeDate.year, timeDate.month, timeDate.day
	local isInTime = GameUtil.checkIsInTimePeriod("05:00:00", "23:59:59", true)

	if not isInTime then
		day = day - 1
	end

	return year * 10000 + month * 100 + day
end

function PetCardLotteryController:timeDateToWday(dateInt)
	local timeStr = tostring(dateInt)
	local month = checknumber(string.sub(timeStr, 5, 6))
	local day = checknumber(string.sub(timeStr, 7, 8))
	local timeDate = GameUtil.time2date(GameUtil.date2time(math.floor(dateInt / 10000), month, day, 5, 0, 0))
	local wday = timeDate.wday

	return month, day, WeekDays[wday]
end

function PetCardLotteryController:isLottery(dateInt)
	local selectPetIds = PetCardLotteryModel.instance:getDaySelectedPetIds(dateInt)
	local prizePetIds = PetCardLotteryModel.instance:getDayPrizePetIds(dateInt)

	if #selectPetIds <= 0 or #prizePetIds <= 0 then
		return false, selectPetIds, prizePetIds
	end

	local isLottery = self:prizeMathCount(selectPetIds, prizePetIds)

	return (self:lottryPrizeType(selectPetIds, prizePetIds) or nil) and true, selectPetIds, prizePetIds
end

function PetCardLotteryController:prizeMathCount(petIds, prizeIds)
	local matchCount = 0

	for _, v in ipairs(prizeIds) do
		if TableUtil.isHad(petIds, v) then
			matchCount = matchCount + 1
		end
	end

	return matchCount
end

function PetCardLotteryController:lottryPrizeType(petIds, prizeIds)
	local matchCount = self:prizeMathCount(petIds, prizeIds)
	local activityId = PetCardLotteryModel.instance:getActivityId()
	local prizeCfg = PetCardLotteryConfig.instance:getPrizeCfg(activityId)
	local cfg = {}

	for _, v in ipairs(prizeCfg) do
		if matchCount >= v.matchCount then
			cfg = v
		end
	end

	return cfg
end

function PetCardLotteryController:_TickDailyRefreshData()
	local activityId = PetCardLotteryModel.instance:getActivityId()

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LotusBattle, activityId) == true then
		self:sendPM_PetCardLotteryGetInfoReq(activityId)
	end
end

function PetCardLotteryController:setRdInfo()
	local isSelectRd = #PetCardLotteryModel.instance:getTodaySelectPetIds() > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETCARDLOTTERY_SELECT, isSelectRd)

	local isPrizeRd = self:isHasPrizeCanReceive()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETCARDLOTTERY_PRIZE, isPrizeRd)
	self:setDailyRd()
end

function PetCardLotteryController:isHasPrizeCanReceive()
	local isCanReceive = false
	local recordList = PetCardLotteryModel.instance:getRecordList()

	for _, v in pairs(recordList) do
		if self:isLottery(v.dateInt) and not PetCardLotteryModel.instance:isGainPrize(v.dateInt) then
			return true
		end
	end

	return isCanReceive
end

function PetCardLotteryController:setDailyRd()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_PETCARDLOTTERY_DAILY)

	local nowTimeDate = ServerTime.nowDate()
	local timeWeekDay = nowTimeDate.wday - 1

	if nowTimeDate.hour < 5 then
		timeWeekDay = timeWeekDay - 1
	end

	if timeWeekDay <= 0 then
		timeWeekDay = 7
	end

	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PetCardLottery)
	local isHasCfg = checkbool(PetCardLotteryConfig.instance:getLotteryPeriodCfg(activityId, timeWeekDay))

	if not isHasCfg then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETCARDLOTTERY_DAILY, false)
	end
end

PetCardLotteryController.instance = PetCardLotteryController.New()

return PetCardLotteryController
