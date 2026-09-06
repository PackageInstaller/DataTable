-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionMyReportView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionMyReportView", package.seeall)

local YouthArenaThirdChampionMyReportView = class("YouthArenaThirdChampionMyReportView", YouthArenaThirdReportBaseView)

function YouthArenaThirdChampionMyReportView:ctor()
	YouthArenaThirdChampionMyReportView.super.ctor(self)
end

function YouthArenaThirdChampionMyReportView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._initialMode = checknumber(params[2])
	self._reportContextKind = "championMy"

	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()

	self._roundId = checknumber(myInfo and myInfo.roundId)
	self._viewGroupId = self:_getMyScheduleViewGroupId(myInfo)
	self._isRequestingMyInfo = false
	self._isMyInfoRequestFailed = false
	self._isRequestingSchedule = false
	self._isScheduleRequestFailed = false
	self._scheduleReqViewGroupId = nil
	self._scheduleReqRoundId = nil

	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, self._handleMyInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleScheduleRes, self)
	YouthArenaThirdChampionMyReportView.super.onEnter(self)
end

function YouthArenaThirdChampionMyReportView:onExit()
	YouthArenaThirdChampionMyReportView.super.onExit(self)

	self._isRequestingMyInfo = false
	self._isRequestingSchedule = false
end

function YouthArenaThirdChampionMyReportView:getInitialMode()
	return self._initialMode
end

function YouthArenaThirdChampionMyReportView:requestReportData(mode)
	local subMo = self:_getSubMo()

	if subMo and subMo:hasMyKnockoutInfoLoaded() then
		self._isRequestingMyInfo = false
		self._isMyInfoRequestFailed = false
	elseif self._activityId > 0 and not self._isRequestingMyInfo then
		self._isMyInfoRequestFailed = false
		self._isRequestingMyInfo = true

		self:_sendMyInfoReq()
	end

	self:_sendScheduleReq()
end

function YouthArenaThirdChampionMyReportView:isReportDataReady(mode)
	if self._activityId <= 0 then
		return true
	end

	local subMo = self:_getSubMo()

	if not subMo or not subMo:hasMyKnockoutInfoLoaded() then
		return false
	end

	local myInfo = subMo:getMyKnockoutInfo()

	if not myInfo or not myInfo.result then
		return true
	end

	return self:_getScheduleInfo() ~= nil
end

function YouthArenaThirdChampionMyReportView:hasReportRequestFailed(mode)
	return self._isMyInfoRequestFailed == true or self._isScheduleRequestFailed == true
end

function YouthArenaThirdChampionMyReportView:buildReportRows(mode)
	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()
	local scheduleInfo = self:_getScheduleInfo()

	return self:_buildChampionRowsByMyInfo(myInfo, scheduleInfo, mode)
end

function YouthArenaThirdChampionMyReportView:_sendMyInfoReq()
	if self._activityId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(self._activityId)
end

function YouthArenaThirdChampionMyReportView:_sendScheduleReq()
	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()
	local viewGroupId = self:_getMyScheduleViewGroupId(myInfo)
	local roundId = checknumber(myInfo and myInfo.roundId)

	if not myInfo or not myInfo.result or self._activityId <= 0 or viewGroupId <= 0 or roundId <= 0 then
		return
	end

	if subMo:getKnockoutScheduleInfo(viewGroupId, roundId) then
		self._isRequestingSchedule = false
		self._isScheduleRequestFailed = false

		return
	end

	if self._isRequestingSchedule and self._scheduleReqViewGroupId == viewGroupId and self._scheduleReqRoundId == roundId then
		return
	end

	self._isScheduleRequestFailed = false
	self._isRequestingSchedule = true
	self._scheduleReqViewGroupId = viewGroupId
	self._scheduleReqRoundId = roundId

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, viewGroupId, roundId)
end

function YouthArenaThirdChampionMyReportView:_handleMyInfoRes(status, msg)
	local activityId = checknumber(msg and msg.activityId)
	local isSuccess = checknumber(status) == 0

	if isSuccess and activityId ~= self._activityId then
		return
	end

	self._isRequestingMyInfo = false
	self._isMyInfoRequestFailed = not isSuccess

	if isSuccess then
		local subMo = self:_getSubMo()
		local myInfo = subMo and subMo:getMyKnockoutInfo()

		self._roundId = checknumber(myInfo and myInfo.roundId)
		self._viewGroupId = self:_getMyScheduleViewGroupId(myInfo)

		self:_rebindReportContext()
		self:_sendScheduleReq()
	end

	self:_refreshRows()
end

function YouthArenaThirdChampionMyReportView:_handleScheduleRes(status, msg)
	local isSuccess = checknumber(status) == 0

	if isSuccess then
		local isMine = checknumber(msg and msg.activityId) == self._activityId and checknumber(msg and msg.viewGroupId) == checknumber(self._scheduleReqViewGroupId) and checknumber(msg and msg.roundId) == checknumber(self._scheduleReqRoundId)

		if not isMine then
			return
		end
	elseif not self._isRequestingSchedule then
		return
	end

	self._isRequestingSchedule = false
	self._isScheduleRequestFailed = not isSuccess

	self:_refreshRows()
end

function YouthArenaThirdChampionMyReportView:_getScheduleInfo()
	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()

	return subMo and subMo:getKnockoutScheduleInfo(self:_getMyScheduleViewGroupId(myInfo), checknumber(myInfo and myInfo.roundId))
end

function YouthArenaThirdChampionMyReportView:_getMyScheduleViewGroupId(myInfo)
	return YouthArenaThirdController.instance:getChampionScheduleViewGroupId(self._activityId, checknumber(myInfo and myInfo.roundId), checknumber(myInfo and myInfo.groupId))
end

function YouthArenaThirdChampionMyReportView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

return YouthArenaThirdChampionMyReportView
