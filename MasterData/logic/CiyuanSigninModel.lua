-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/model/CiyuanSigninModel.lua

module("logic.extensions.ciyuansignin.model.CiyuanSigninModel", package.seeall)

local CiyuanSigninModel = class("CiyuanSigninModel", BaseModel)

function CiyuanSigninModel:onInit()
	self:onReset()
end

function CiyuanSigninModel:onReset()
	self._activityInfo = {}
	self._changeSetIds = {}
end

function CiyuanSigninModel:handlePM_CiyuanSigninGetInfoRes(msg)
	self._activityInfo = self._activityInfo or {}

	local activityId = checknumber(msg.activityId)
	local info = {
		activityId = activityId,
		hasGainCiyuanHeart = msg.hasGainCiyuanHeart and true or false,
		todayHadSignIn = msg.todayHadSignIn and true or false,
		dayInfos = {},
		dayInfoMap = {}
	}

	for _, pbInfo in ipairs(msg.dayInfos or {}) do
		local dayInfo = {}

		GameUtil.pbToTable(pbInfo, dayInfo)

		dayInfo.day = checknumber(dayInfo.day)
		dayInfo.playerType = checknumber(dayInfo.playerType)
		dayInfo.hasGainPrize = not not dayInfo.hasGainPrize

		table.insert(info.dayInfos, dayInfo)

		info.dayInfoMap[dayInfo.day] = dayInfo
	end

	info.locks = {}

	for _, pbLock in ipairs(msg.locks or {}) do
		local lockInfo = {}

		GameUtil.pbToTable(pbLock, lockInfo)

		lockInfo.lockId = checknumber(lockInfo.lockId)
		lockInfo.activityId = checknumber(lockInfo.activityId)

		table.insert(info.locks, lockInfo)
	end

	table.sort(info.dayInfos, function(a, b)
		return a.day < b.day
	end)

	self._activityInfo[activityId] = info
end

function CiyuanSigninModel:handlePM_CiyuanSigninGainPrizeRes(msg)
	local info = self:getActivityInfo(msg.activityId)

	for _, day in ipairs(msg.gainPrizeDays or {}) do
		local dayInfo = info.dayInfoMap[day]

		if dayInfo then
			dayInfo.hasGainPrize = true
		end
	end

	self:setRecentChangeSetId(msg.activityId, msg.changeSetId)
end

function CiyuanSigninModel:handlePM_CiyuanSigninBuyMakeUpRes(msg)
	self:setRecentChangeSetId(msg.activityId, msg.changeSetId)
end

function CiyuanSigninModel:getActivityInfo(activityId)
	if not self._activityInfo then
		return self._activityInfo[checknumber(activityId)] or {}
	end
end

function CiyuanSigninModel:getDayInfos(activityId)
	return self:getActivityInfo(activityId).dayInfos or {}
end

function CiyuanSigninModel:getDayInfoMap(activityId)
	return self:getActivityInfo(activityId).dayInfoMap or {}
end

function CiyuanSigninModel:getDayInfo(activityId, day)
	return self:getDayInfoMap(activityId)[checknumber(day)]
end

function CiyuanSigninModel:getLocks(activityId)
	return self:getActivityInfo(activityId).locks or {}
end

function CiyuanSigninModel:getLockIdSet(activityId)
	local lockIds = {}

	for _, lock in ipairs(self:getLocks(activityId)) do
		lockIds[lock.lockId] = true
	end

	return lockIds
end

function CiyuanSigninModel:getSignedDayCount(activityId)
	return #self:getDayInfos(activityId)
end

function CiyuanSigninModel:hasGainCiyuanHeart(activityId)
	return not not self:getActivityInfo(activityId).hasGainCiyuanHeart
end

function CiyuanSigninModel:hadTodaySignIn(activityId)
	return not not self:getActivityInfo(activityId).todayHadSignIn
end

function CiyuanSigninModel:setRecentChangeSetId(activityId, changeSetId)
	self._changeSetIds = self._changeSetIds or {}
	activityId = checknumber(activityId)
	changeSetId = checknumber(changeSetId)
	self._changeSetIds[activityId] = changeSetId

	if changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end
end

function CiyuanSigninModel:getRecentChangeSetId(activityId)
	return checknumber(self._changeSetIds and self._changeSetIds[checknumber(activityId)])
end

CiyuanSigninModel.instance = CiyuanSigninModel.New()

return CiyuanSigninModel
