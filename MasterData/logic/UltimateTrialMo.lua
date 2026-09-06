-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/data/UltimateTrialMo.lua

module("logic.extensions.ultimatetrial.data.UltimateTrialMo", package.seeall)

local UltimateTrialMo = class("UltimateTrialMo")

function UltimateTrialMo:ctor(activityId)
	self._activityId = activityId
	self._curTabIdx = 0
	self._signInDays = 0
	self._hasSignInToday = false
	self._clgInfos = {}
end

function UltimateTrialMo:dispose()
	table.clear(self._clgInfos)
end

function UltimateTrialMo:handlePM_UltimateTrialGetInfoRes(msg)
	self._signInDays = msg.signInDays
	self._hasSignInToday = msg.hasSignInToday

	table.clear(self._clgInfos)

	for _, v in ipairs(msg.clgInfos) do
		self._clgInfos[v.challengeActId] = v
	end
end

function UltimateTrialMo:handlePM_UltimateTrialSignInRes(msg)
	self._signInDays = msg.signInDays
	self._hasSignInToday = true
end

function UltimateTrialMo:handlePM_UltimateTrialGetTimeRankViewRes(msg)
	return
end

function UltimateTrialMo:handlePM_UltimateTrialGetScoreRankViewRes(msg)
	return
end

function UltimateTrialMo:getCurSignDay()
	local signDay = self:getSignInDays()
	local maxDay = self:getMaxSignDay()

	return Mathf.Min(signDay, maxDay)
end

function UltimateTrialMo:getSignInDays()
	return self._signInDays
end

function UltimateTrialMo:getMaxSignDay()
	return UltimateTrialConfig.instance:getMaxSignDay(self._activityId)
end

function UltimateTrialMo:isHasSignInToday()
	return self._hasSignInToday
end

function UltimateTrialMo:getPassClgScore(clgActId)
	local info = self:getClgInfo(clgActId)

	return (info or nil) and (info.passClgScore or 0)
end

function UltimateTrialMo:isFirstPassClg(clgActId)
	local info = self:getClgInfo(clgActId)

	return info ~= nil
end

function UltimateTrialMo:getClgInfo(clgActId)
	return self._clgInfos[clgActId]
end

function UltimateTrialMo:saveCurTabId(value)
	self._curTabIdx = value
end

function UltimateTrialMo:getCurTabId()
	return self._curTabIdx
end

return UltimateTrialMo
