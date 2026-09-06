-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/data/HolyDragonTempleSubMo.lua

module("logic.extensions.holydragontemple.data.HolyDragonTempleSubMo", package.seeall)

local HolyDragonTempleSubMo = class("HolyDragonTempleSubMo")

function HolyDragonTempleSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function HolyDragonTempleSubMo:_resetData()
	self._floorIds = {}
	self._passStageIds = {}
	self._passStageIdsInFloor = {}
	self._signInDaysInFloor = {}
	self._isTodaySignUpInFloor = {}
	self._challengeResultMsg = nil
end

function HolyDragonTempleSubMo:dispose()
	self:_resetData()
end

function HolyDragonTempleSubMo:handlePM_HolyDragonTempleInfoRes(msg)
	self._floorIds = {}
	self._passStageIds = {}
	self._passStageIdsInFloor = {}
	self._signInDaysInFloor = {}
	self._isTodaySignUpInFloor = {}

	for _, floorInfo in ipairs(msg.floorInfo) do
		self:_updateFloorInfo(floorInfo)
	end
end

function HolyDragonTempleSubMo:handlePM_HolyDragonTempleNotifyChallengeRes(msg)
	self._challengeResultMsg = msg

	if self:_isChallengePassed(msg) then
		self:_setStagePassed(msg.floorId, msg.stageId)
	end
end

function HolyDragonTempleSubMo:handlePM_HolyDragonTempleSignInRes(msg)
	self:_updateFloorSignIn(msg.floorId, msg.signInDays, true)
end

function HolyDragonTempleSubMo:_updateFloorInfo(floorInfo)
	local floorId = floorInfo.floorId

	table.insert(self._floorIds, floorId)

	self._passStageIds[floorId] = {}
	self._passStageIdsInFloor[floorId] = {}

	for _, stageId in ipairs(floorInfo.passStageId) do
		table.insert(self._passStageIds[floorId], stageId)

		self._passStageIdsInFloor[floorId][stageId] = true
	end

	self._signInDaysInFloor[floorId] = checknumber(floorInfo.signInDays)
	self._isTodaySignUpInFloor[floorId] = checkbool(floorInfo.isTodaySignUp)
end

function HolyDragonTempleSubMo:_updateFloorSignIn(floorId, signInDays, isTodaySignUp)
	self._signInDaysInFloor[floorId] = checknumber(signInDays)
	self._isTodaySignUpInFloor[floorId] = checkbool(isTodaySignUp)
end

function HolyDragonTempleSubMo:_setStagePassed(floorId, stageId)
	self._passStageIds[floorId] = self._passStageIds[floorId] or {}
	self._passStageIdsInFloor[floorId] = self._passStageIdsInFloor[floorId] or {}

	if not self._passStageIdsInFloor[floorId][stageId] then
		table.insert(self._passStageIds[floorId], stageId)
	end

	self._passStageIdsInFloor[floorId][stageId] = true
end

function HolyDragonTempleSubMo:_isChallengePassed(msg)
	return msg ~= nil and checkbool(msg.isWin) and checkbool(msg.isPassed)
end

function HolyDragonTempleSubMo:getActivityId()
	return self._activityId
end

function HolyDragonTempleSubMo:getFloorIds()
	return self._floorIds
end

function HolyDragonTempleSubMo:getPassStageIds(floorId)
	return self._passStageIds[floorId] or {}
end

function HolyDragonTempleSubMo:getSignInDays(floorId)
	return self._signInDaysInFloor[floorId] or 0
end

function HolyDragonTempleSubMo:isTodaySignUp(floorId)
	return self._isTodaySignUpInFloor[floorId] or false
end

function HolyDragonTempleSubMo:isStagePassed(floorId, stageId)
	return (self._passStageIdsInFloor[floorId] or nil) and (self._passStageIdsInFloor[floorId][stageId] or false)
end

function HolyDragonTempleSubMo:getChallengeResultMsg()
	return self._challengeResultMsg
end

return HolyDragonTempleSubMo
