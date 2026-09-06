-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdQualifierReportView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdQualifierReportView", package.seeall)

local YouthArenaThirdQualifierReportView = class("YouthArenaThirdQualifierReportView", YouthArenaThirdReportBaseView)

function YouthArenaThirdQualifierReportView:ctor()
	YouthArenaThirdQualifierReportView.super.ctor(self)
end

function YouthArenaThirdQualifierReportView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._isFun = checkbool(params[2])
	self._initialMode = checknumber(params[3])
	self._stepId = checknumber(params[4])
	self._reportContextKind = "qualifier"
	self._requestingModeMap = {}
	self._requestingModeQueue = {}
	self._failedModeMap = {}

	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3QualifierRecordsRes, self._handleRecordsRes, self)
	YouthArenaThirdQualifierReportView.super.onEnter(self)
end

function YouthArenaThirdQualifierReportView:onExit()
	YouthArenaThirdQualifierReportView.super.onExit(self)

	self._requestingModeMap = nil
	self._requestingModeQueue = nil
	self._failedModeMap = nil
end

function YouthArenaThirdQualifierReportView:getInitialMode()
	return self._initialMode
end

function YouthArenaThirdQualifierReportView:requestReportData(mode)
	local subMo = self:_getSubMo()

	if subMo and subMo:getQualifierRecords(self._isFun, mode) then
		self._requestingModeMap[mode] = nil
		self._failedModeMap[mode] = nil

		return
	end

	if self._activityId <= 0 or self._stepId <= 0 or self._requestingModeMap[mode] then
		return
	end

	self._failedModeMap[mode] = nil
	self._requestingModeMap[mode] = true

	table.insert(self._requestingModeQueue, mode)
	self:_sendRecordsReq(mode)
end

function YouthArenaThirdQualifierReportView:isReportDataReady(mode)
	if self._activityId <= 0 or self._stepId <= 0 then
		return true
	end

	local subMo = self:_getSubMo()

	return subMo ~= nil and subMo:getQualifierRecords(self._isFun, mode) ~= nil
end

function YouthArenaThirdQualifierReportView:hasReportRequestFailed(mode)
	return self._failedModeMap and self._failedModeMap[mode] == true
end

function YouthArenaThirdQualifierReportView:buildReportRows(mode)
	local subMo = self:_getSubMo()
	local info = subMo and subMo:getQualifierRecords(self._isFun, mode)

	return self:_buildQualifierRows(info, mode, self._stepId)
end

function YouthArenaThirdQualifierReportView:_sendRecordsReq(mode)
	if self._activityId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierRecordsReq(self._activityId, self._isFun, mode)
end

function YouthArenaThirdQualifierReportView:_handleRecordsRes(status, msg)
	local mode = checknumber(msg and msg.mode)
	local activityId = checknumber(msg and msg.activityId)
	local isSuccess = checknumber(status) == 0
	local isMine = activityId == self._activityId and checkbool(msg and msg.isFun) == self._isFun

	if isSuccess and isMine and self:_isValidMode(mode) then
		self:_removeRequestingMode(mode)

		self._requestingModeMap[mode] = nil
		self._failedModeMap[mode] = nil
	elseif not isSuccess then
		if not self:_isValidMode(mode) or not self._requestingModeMap[mode] then
			mode = table.remove(self._requestingModeQueue, 1)
		else
			self:_removeRequestingMode(mode)
		end

		if self:_isValidMode(mode) then
			self._requestingModeMap[mode] = nil
			self._failedModeMap[mode] = true
		end
	else
		return
	end

	self:_refreshRows()
end

function YouthArenaThirdQualifierReportView:_removeRequestingMode(mode)
	for index, requestingMode in ipairs(self._requestingModeQueue or {}) do
		if requestingMode == mode then
			table.remove(self._requestingModeQueue, index)

			return
		end
	end
end

function YouthArenaThirdQualifierReportView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

return YouthArenaThirdQualifierReportView
