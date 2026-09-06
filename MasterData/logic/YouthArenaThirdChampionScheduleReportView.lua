-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScheduleReportView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScheduleReportView", package.seeall)

local YouthArenaThirdChampionScheduleReportView = class("YouthArenaThirdChampionScheduleReportView", YouthArenaThirdReportBaseView)

function YouthArenaThirdChampionScheduleReportView:ctor()
	YouthArenaThirdChampionScheduleReportView.super.ctor(self)
end

function YouthArenaThirdChampionScheduleReportView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._viewGroupId = checknumber(params[2])
	self._roundId = checknumber(params[3])
	self._initialMode = checknumber(params[4])
	self._matchIndex = checknumber(params[5])
	self._matchRoundId = checknumber(params[6])
	self._reportContextKind = "championSchedule"
	self._isRequestingSchedule = false
	self._isScheduleRequestFailed = false

	if self._viewGroupId <= 0 then
		self._viewGroupId = 1
	end

	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleScheduleRes, self)
	YouthArenaThirdChampionScheduleReportView.super.onEnter(self)
end

function YouthArenaThirdChampionScheduleReportView:onExit()
	YouthArenaThirdChampionScheduleReportView.super.onExit(self)

	self._isRequestingSchedule = false
end

function YouthArenaThirdChampionScheduleReportView:getInitialMode()
	return self._initialMode
end

function YouthArenaThirdChampionScheduleReportView:_formatTime(stamp)
	if checknumber(stamp) > 0 then
		return YouthArenaThirdChampionScheduleReportView.super._formatTime(self, stamp)
	end

	if self._matchRoundId > 0 then
		if not self._matchRoundId then
			local roundId = self._roundId
			local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, roundId)
			local roundName = roundData and roundData.roundName

			if not string.nilorempty(roundName) then
				return roundName
			end

			return YouthArenaThirdChampionScheduleReportView.super._formatTime(self, stamp)
		end
	end
end

function YouthArenaThirdChampionScheduleReportView:requestReportData(mode)
	local subMo = self:_getSubMo()

	if subMo and subMo:getKnockoutScheduleInfo(self._viewGroupId, self._roundId) then
		self._isRequestingSchedule = false
		self._isScheduleRequestFailed = false

		return
	end

	if self._activityId <= 0 or self._roundId <= 0 or self._isRequestingSchedule then
		return
	end

	self._isScheduleRequestFailed = false
	self._isRequestingSchedule = true

	self:_sendScheduleReq()
end

function YouthArenaThirdChampionScheduleReportView:isReportDataReady(mode)
	if self._activityId <= 0 or self._roundId <= 0 then
		return true
	end

	local subMo = self:_getSubMo()

	return subMo ~= nil and subMo:getKnockoutScheduleInfo(self._viewGroupId, self._roundId) ~= nil
end

function YouthArenaThirdChampionScheduleReportView:hasReportRequestFailed(mode)
	return self._isScheduleRequestFailed == true
end

function YouthArenaThirdChampionScheduleReportView:buildReportRows(mode)
	local subMo = self:_getSubMo()
	local scheduleInfo = subMo and subMo:getKnockoutScheduleInfo(self._viewGroupId, self._roundId)
	local rows = self:_buildChampionRowsByScheduleInfo(scheduleInfo, mode)

	if self._matchIndex <= 0 then
		return rows
	end

	local filtered = {}

	for _, row in ipairs(rows or {}) do
		local isMatchIndex = checknumber(row.matchIndex) == self._matchIndex
		local isMatchRound = self._matchRoundId <= 0 or checknumber(row.matchRoundId) == self._matchRoundId

		if isMatchIndex and isMatchRound then
			table.insert(filtered, row)
		end
	end

	return filtered
end

function YouthArenaThirdChampionScheduleReportView:_sendScheduleReq()
	if self._activityId <= 0 or self._roundId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, self._viewGroupId, self._roundId)
end

function YouthArenaThirdChampionScheduleReportView:_handleScheduleRes(status, msg)
	local isSuccess = checknumber(status) == 0

	if isSuccess then
		local isMine = checknumber(msg and msg.activityId) == self._activityId and checknumber(msg and msg.viewGroupId) == self._viewGroupId and checknumber(msg and msg.roundId) == self._roundId

		if not isMine then
			return
		end
	end

	self._isRequestingSchedule = false
	self._isScheduleRequestFailed = not isSuccess

	self:_refreshRows()
end

function YouthArenaThirdChampionScheduleReportView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

return YouthArenaThirdChampionScheduleReportView
