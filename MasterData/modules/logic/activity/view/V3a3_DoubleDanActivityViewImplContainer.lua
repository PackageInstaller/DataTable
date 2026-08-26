-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivityViewImplContainer.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivityViewImplContainer", package.seeall)

local V3a3_DoubleDanActivityViewImplContainer = class("V3a3_DoubleDanActivityViewImplContainer", BaseViewContainer)

function V3a3_DoubleDanActivityViewImplContainer:actId()
	return assert(self.viewParam.actId, "please pass viewParam.actId!!")
end

function V3a3_DoubleDanActivityViewImplContainer:getDayCO(day)
	return ActivityType101Config.instance:getDayCO(self:actId(), day)
end

function V3a3_DoubleDanActivityViewImplContainer:getSignMaxDay()
	return ActivityType101Config.instance:getSignMaxDay(self:actId())
end

function V3a3_DoubleDanActivityViewImplContainer:getDayBonusList(day)
	self.__cacheBonusList = self.__cacheBonusList or {}

	if self.__cacheBonusList[day] then
		return self.__cacheBonusList[day]
	end

	local list = ActivityType101Config.instance:getDayBonusList(self:actId(), day)

	self.__cacheBonusList[day] = list

	return list
end

function V3a3_DoubleDanActivityViewImplContainer:isType101RewardGet(day)
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), day)
end

function V3a3_DoubleDanActivityViewImplContainer:isType101RewardCouldGet(day)
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), day)
end

function V3a3_DoubleDanActivityViewImplContainer:getFirstAvailableIndex()
	return ActivityType101Model.instance:getFirstAvailableIndex(self:actId())
end

function V3a3_DoubleDanActivityViewImplContainer:isDayOpen(day)
	return ActivityType101Model.instance:isDayOpen(self:actId(), day)
end

function V3a3_DoubleDanActivityViewImplContainer:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function V3a3_DoubleDanActivityViewImplContainer:sendGet101BonusRequest(day, cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), day, cb, cbObj)
end

function V3a3_DoubleDanActivityViewImplContainer:getRemainTimeStr()
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

function V3a3_DoubleDanActivityViewImplContainer:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function V3a3_DoubleDanActivityViewImplContainer:getSkinCo()
	local skinId = ActivityType101Config.instance:getDoubleDanSkinId()

	return SkinConfig.instance:getSkinCo(skinId)
end

function V3a3_DoubleDanActivityViewImplContainer:getSkinCo_characterId()
	local CO = self:getSkinCo()

	if not CO then
		return 0
	end

	return CO.characterId
end

function V3a3_DoubleDanActivityViewImplContainer:getHeroCO()
	return HeroConfig.instance:getHeroCO(self:getSkinCo_characterId())
end

function V3a3_DoubleDanActivityViewImplContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

return V3a3_DoubleDanActivityViewImplContainer
