-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/model/OriginDuoLaGameGridData.lua

module("logic.extensions.originduolagame.model.OriginDuoLaGameGridData", package.seeall)

local OriginDuoLaGameGridData = class("OriginDuoLaGameGridData")

OriginDuoLaGameGridData.GRID_INIT_TYPE = {
	Show_Error = 2,
	Hide_Error = 1,
	None = 0
}
OriginDuoLaGameGridData.TRIGGER_MODE = {
	MatchRight = 0,
	MatchError = 1
}

function OriginDuoLaGameGridData:ctor()
	self:reset()
end

function OriginDuoLaGameGridData:reset()
	self._gridType = nil
	self._gridId = nil
	self._row = 0
	self._col = 0

	self:resetState()
end

function OriginDuoLaGameGridData:initData(GRID_TYPE, row, col, gridId)
	self:reset()

	self._gridType = GRID_TYPE
	self._row = row
	self._col = col
	self._gridId = gridId

	self:resetState()
end

function OriginDuoLaGameGridData:resetState()
	self._isTriggered = false
	self._isError = false
	self._isTriggeredError = false

	if self._gridType == OriginDuoLaGameGridData.GRID_INIT_TYPE.Hide_Error then
		self._isError = true
	elseif self._gridType == OriginDuoLaGameGridData.GRID_INIT_TYPE.Show_Error then
		self._isError = true
		self._isTriggered = true
	end
end

function OriginDuoLaGameGridData:trigger(triggerMode)
	local _triggerMode = triggerMode or OriginDuoLaGameGridData.TRIGGER_MODE.MatchRight

	if self._isTriggered then
		return false
	end

	self._isTriggered = true
	self._isTriggeredError = self._isError and _triggerMode ~= OriginDuoLaGameGridData.TRIGGER_MODE.MatchError or _triggerMode == OriginDuoLaGameGridData.TRIGGER_MODE.MatchError

	return true
end

function OriginDuoLaGameGridData:isError()
	return self._isError
end

function OriginDuoLaGameGridData:isTriggered()
	return self._isTriggered
end

function OriginDuoLaGameGridData:isTriggeredError()
	return self._isTriggeredError
end

function OriginDuoLaGameGridData:getRowCol()
	return self._row, self._col
end

function OriginDuoLaGameGridData:triggerSafe()
	if self._isTriggered then
		return false
	end

	self._isTriggered = true

	return true
end

return OriginDuoLaGameGridData
