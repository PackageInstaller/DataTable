-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentImplContainer.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentImplContainer", package.seeall)

local V3a7_GoldenMilletPresentImplContainer = class("V3a7_GoldenMilletPresentImplContainer", BaseViewContainer)

function V3a7_GoldenMilletPresentImplContainer:actId()
	return GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
end

function V3a7_GoldenMilletPresentImplContainer:getDayCO(day)
	return ActivityType101Config.instance:getDayCO(self:actId(), day)
end

function V3a7_GoldenMilletPresentImplContainer:getSignMaxDay()
	return ActivityType101Config.instance:getSignMaxDay(self:actId())
end

function V3a7_GoldenMilletPresentImplContainer:getDayBonusList(day)
	self.__cacheBonusList = self.__cacheBonusList or {}

	if self.__cacheBonusList[day] then
		return self.__cacheBonusList[day]
	end

	local list = ActivityType101Config.instance:getDayBonusList(self:actId(), day)

	self.__cacheBonusList[day] = list

	return list
end

function V3a7_GoldenMilletPresentImplContainer:isType101RewardGet(day)
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), day)
end

function V3a7_GoldenMilletPresentImplContainer:isType101RewardCouldGet(day)
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), day)
end

function V3a7_GoldenMilletPresentImplContainer:getFirstAvailableIndex()
	return ActivityType101Model.instance:getFirstAvailableIndex(self:actId())
end

function V3a7_GoldenMilletPresentImplContainer:isDayOpen(day)
	return ActivityType101Model.instance:isDayOpen(self:actId(), day)
end

function V3a7_GoldenMilletPresentImplContainer:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function V3a7_GoldenMilletPresentImplContainer:sendGet101BonusRequest(day, cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), day, cb, cbObj)
end

function V3a7_GoldenMilletPresentImplContainer:isGoldenMilletPresentOpen(...)
	return GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(...)
end

function V3a7_GoldenMilletPresentImplContainer:getRemainTimeStr()
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

function V3a7_GoldenMilletPresentImplContainer:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function V3a7_GoldenMilletPresentImplContainer:getSkinCo(skinId)
	return SkinConfig.instance:getSkinCo(skinId)
end

function V3a7_GoldenMilletPresentImplContainer:getSkinCo_characterId()
	local CO = self:getSkinCo()

	if not CO then
		return 0
	end

	return CO.characterId
end

function V3a7_GoldenMilletPresentImplContainer:getHeroCO(heroId)
	return HeroConfig.instance:getHeroCO(heroId)
end

function V3a7_GoldenMilletPresentImplContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function V3a7_GoldenMilletPresentImplContainer:getJumpId()
	return ActivityType101Config.instance:getConstAsNum(3, 0)
end

function V3a7_GoldenMilletPresentImplContainer:getSkinGoodsIdList()
	local str = ActivityType101Config.instance:getConst(4, "")

	if string.nilorempty(str) then
		return {}
	end

	return GameUtil.splitString2(str, true)
end

return V3a7_GoldenMilletPresentImplContainer
