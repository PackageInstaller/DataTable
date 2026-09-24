-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGiftImplContainer.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGiftImplContainer", package.seeall)

local V4a0_CasualSkinGiftImplContainer = class("V4a0_CasualSkinGiftImplContainer", BaseViewContainer)

function V4a0_CasualSkinGiftImplContainer:actId()
	return ActivityType101Config.instance:getCasualSkinGiftActId()
end

function V4a0_CasualSkinGiftImplContainer:getDayCO(day)
	return ActivityType101Config.instance:getDayCO(self:actId(), day)
end

function V4a0_CasualSkinGiftImplContainer:getSignMaxDay()
	return ActivityType101Config.instance:getSignMaxDay(self:actId())
end

function V4a0_CasualSkinGiftImplContainer:getDayBonusList(day)
	self.__cacheBonusList = self.__cacheBonusList or {}

	if self.__cacheBonusList[day] then
		return self.__cacheBonusList[day]
	end

	local list = ActivityType101Config.instance:getDayBonusList(self:actId(), day)

	self.__cacheBonusList[day] = list

	return list
end

function V4a0_CasualSkinGiftImplContainer:isType101RewardGet(day)
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), day)
end

function V4a0_CasualSkinGiftImplContainer:isType101RewardCouldGet(day)
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), day)
end

function V4a0_CasualSkinGiftImplContainer:getFirstAvailableIndex()
	return ActivityType101Model.instance:getFirstAvailableIndex(self:actId())
end

function V4a0_CasualSkinGiftImplContainer:isDayOpen(day)
	return ActivityType101Model.instance:isDayOpen(self:actId(), day)
end

function V4a0_CasualSkinGiftImplContainer:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function V4a0_CasualSkinGiftImplContainer:sendGet101BonusRequest(day, cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), day, cb, cbObj)
end

function V4a0_CasualSkinGiftImplContainer:isGoldenMilletPresentOpen(...)
	return GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(...)
end

function V4a0_CasualSkinGiftImplContainer:getRemainTimeStr()
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

function V4a0_CasualSkinGiftImplContainer:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function V4a0_CasualSkinGiftImplContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function V4a0_CasualSkinGiftImplContainer:getSkinCo(skinId)
	return SkinConfig.instance:getSkinCo(skinId)
end

function V4a0_CasualSkinGiftImplContainer:getSkinCo_characterId()
	local CO = self:getSkinCo()

	if not CO then
		return 0
	end

	return CO.characterId
end

function V4a0_CasualSkinGiftImplContainer:getHeroCO(heroId)
	return HeroConfig.instance:getHeroCO(heroId)
end

function V4a0_CasualSkinGiftImplContainer:getPreviewSkinInfoList()
	local str = ActivityType101Config.instance:getConst(7, "")

	if string.nilorempty(str) then
		return {}
	end

	return GameUtil.splitString2(str, true)
end

function V4a0_CasualSkinGiftImplContainer:getJumpId()
	return ActivityType101Config.instance:getConstAsNum(8, 0)
end

return V4a0_CasualSkinGiftImplContainer
