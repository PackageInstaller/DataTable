-- chunkname: @modules/logic/versionactivity2_4/act181/model/Activity181Model.lua

module("modules.logic.versionactivity2_4.act181.model.Activity181Model", package.seeall)

local Activity181Model = class("Activity181Model", BaseModel)

function Activity181Model:onInit()
	self._activityInfoDic = {}
end

function Activity181Model:reInit()
	self._activityInfoDic = {}
end

function Activity181Model:setActInfo(activityId, info)
	if not info or not activityId then
		return
	end

	local mo = self._activityInfoDic[activityId]

	if not mo then
		mo = Activity181MO.New()
		self._activityInfoDic[activityId] = mo
	end

	mo:setInfo(info)
end

function Activity181Model:getActivityInfo(activityId)
	return self._activityInfoDic[activityId]
end

function Activity181Model:setBonusInfo(activityId, info)
	if not info or not activityId then
		return
	end

	local mo = self:getActivityInfo(activityId)

	if not mo then
		return
	end

	mo:setBonusInfo(info.pos, info.id)
end

function Activity181Model:setSPBonusInfo(activityId)
	if not activityId then
		return
	end

	local mo = self:getActivityInfo(activityId)

	if not mo then
		return
	end

	mo:setSPBonusInfo()
end

function Activity181Model:addBonusTimes(activityId)
	if not activityId then
		return
	end

	local mo = self:getActivityInfo(activityId)

	if not mo then
		return
	end

	local times = mo:getBonusTimes()

	mo:setBonusTimes(times + 1)
	Activity181Controller.instance:dispatchEvent(Activity181Event.BonusTimesChange, activityId)
end

function Activity181Model:isActivityInTime(activityId)
	local activityInfo = ActivityModel.instance:getActMO(activityId)

	if not activityInfo then
		return false
	end

	if not activityInfo:isOpen() or activityInfo:isExpired() then
		return false
	end

	return true
end

function Activity181Model:getHaveFirstDayLogin(activityId)
	local key = self:getDaliyLoginKey(activityId)

	return TimeUtil.getDayFirstLoginRed(key)
end

function Activity181Model:setHaveFirstDayLogin(activityId)
	local key = self:getDaliyLoginKey(activityId)

	TimeUtil.setDayFirstLoginRed(key)
end

function Activity181Model:getDaliyLoginKey(activityId)
	return PlayerPrefsKey.Version2_4_Act181FirstOpen .. tostring(activityId)
end

function Activity181Model:setPopUpPauseState(state)
	self._popUpState = state

	PopupController.instance:setPause("Activity181MainView_bonus", state)
end

function Activity181Model:getPopUpPauseState()
	return self._popUpState
end

Activity181Model.instance = Activity181Model.New()

return Activity181Model
