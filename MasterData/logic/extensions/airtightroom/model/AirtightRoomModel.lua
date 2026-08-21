-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/model/AirtightRoomModel.lua

module("logic.extensions.airtightroom.model.AirtightRoomModel", package.seeall)

local M = class("AirtightRoomModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._noticeMap = {}

	for i = 10, 1, -1 do
		table.insert(self._noticeMap, {
			showRed = false,
			time = 82800 + (60 - i) * 60,
			content = i
		})
	end

	for i = 10, 1, -1 do
		table.insert(self._noticeMap, {
			showRed = true,
			time = 86340 + (60 - i),
			content = i
		})
	end

	self:onReset()
end

function M:onReset()
	self._exitTime = 0
	self._editOffsetTime = 0
	self._airtightStartTimeStamp = nil
	self._airtightPreviewState = nil

	self:setCacheTimeStatus(nil)
	self:setIgnoreSpSetting(nil)
end

function M:getServerTime()
	return ServerTime.nowServerLook() + self:getEditOffsetTime()
end

function M:getEditOffsetTime()
	return self._editOffsetTime or 0
end

function M:setEditOffsetTime(t)
	self._editOffsetTime = t and t or 0

	GlobalDispatcher:dispatchEvent(EventType.ON_ARITIGHT_EDITOR_OFFSET)
end

function M:setCacheTimeStatus(status)
	self._cacheAirtightStatus = status
end

function M:getCacheTimeStatus()
	return self._cacheAirtightStatus
end

function M:setIgnoreSpSetting(ignore)
	self._ignoreSpSetting = ignore
end

function M:getIgnoreSpSetting()
	return self._ignoreSpSetting
end

function M:getPreviewState()
	return self._airtightPreviewState
end

function M:setPreviewState(state)
	self._airtightPreviewState = state

	GlobalDispatcher:dispatchEvent(EventType.ON_ARITIGHT_STATE_PREVIEW, state)
end

function M:getAirtightStartTimeStamp()
	if not self._airtightStartTimeStamp then
		local str = ConstConfig.instance:getStrValueByKey("AirtightRoomStartTime")

		if string.nilorempty(str) then
			printError("密室时间，常量配置为空")
			self:setAirtightStartTimeStamp(9999999999)
		else
			local _, _, _y, _m, _d, _hour, _min, _sec = string.find(str, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local timestamp = os.time({
				year = _y,
				month = _m,
				day = _d,
				hour = _hour,
				min = _min,
				sec = _sec
			})

			self:setAirtightStartTimeStamp(timestamp)
		end
	end

	return self._airtightStartTimeStamp
end

function M:setAirtightStartTimeStamp(timeStamp)
	self._airtightStartTimeStamp = timeStamp
end

function M:setExitTime(exitTime)
	self._exitTime = tonumber(exitTime)
end

function M:getExitTime()
	return self._exitTime or 0
end

function M:getNoticeMap()
	return self._noticeMap
end

M.instance = M.New()

return M
