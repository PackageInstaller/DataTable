-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGiftImplContainer.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGiftImplContainer", package.seeall)

local V4a0_SixStarGiftImplContainer = class("V4a0_SixStarGiftImplContainer", BaseViewContainer)

function V4a0_SixStarGiftImplContainer:_actId()
	return ActivityType101Config.instance:getSixStarGiftActId()
end

function V4a0_SixStarGiftImplContainer:actId()
	return (self:_actId())
end

function V4a0_SixStarGiftImplContainer:getDayCO(day)
	return ActivityType101Config.instance:getDayCO(self:actId(), day)
end

function V4a0_SixStarGiftImplContainer:getSignMaxDay()
	return ActivityType101Config.instance:getSignMaxDay(self:actId())
end

function V4a0_SixStarGiftImplContainer:getDayBonusList(day)
	self.__cacheBonusList = self.__cacheBonusList or {}

	if self.__cacheBonusList[day] then
		return self.__cacheBonusList[day]
	end

	local list = ActivityType101Config.instance:getDayBonusList(self:actId(), day)

	self.__cacheBonusList[day] = list

	return list
end

function V4a0_SixStarGiftImplContainer:isType101RewardGet(day)
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), day)
end

function V4a0_SixStarGiftImplContainer:isType101RewardCouldGet(day)
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), day)
end

function V4a0_SixStarGiftImplContainer:getFirstAvailableIndex()
	return ActivityType101Model.instance:getFirstAvailableIndex(self:actId())
end

function V4a0_SixStarGiftImplContainer:isDayOpen(day)
	return ActivityType101Model.instance:isDayOpen(self:actId(), day)
end

function V4a0_SixStarGiftImplContainer:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function V4a0_SixStarGiftImplContainer:sendGet101BonusRequest(day, cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), day, cb, cbObj)
end

function V4a0_SixStarGiftImplContainer:isGoldenMilletPresentOpen(...)
	return GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(...)
end

function V4a0_SixStarGiftImplContainer:getRemainTimeStr()
	local remainTimeSec = self:getRemainTimeSec()

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function V4a0_SixStarGiftImplContainer:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function V4a0_SixStarGiftImplContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function V4a0_SixStarGiftImplContainer:getSixStarGiftStoreChargeId()
	return StoreConfig.instance:getSixStarGiftStoreChargeId()
end

function V4a0_SixStarGiftImplContainer:getPreviewItemIdList()
	local str = ActivityType101Config.instance:getConst(6, "")

	if string.nilorempty(str) then
		return {}
	end

	return GameUtil.splitString2(str, true)
end

function V4a0_SixStarGiftImplContainer:isSoldOut()
	local goodsMO = StoreModel.instance:getGoodsMO(self:getSixStarGiftStoreChargeId())

	if not goodsMO then
		return true
	end

	return goodsMO:isSoldOut()
end

return V4a0_SixStarGiftImplContainer
