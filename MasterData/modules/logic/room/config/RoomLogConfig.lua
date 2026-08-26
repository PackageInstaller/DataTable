-- chunkname: @modules/logic/room/config/RoomLogConfig.lua

module("modules.logic.room.config.RoomLogConfig", package.seeall)

local RoomLogConfig = class("RoomLogConfig", BaseConfig)

function RoomLogConfig:ctor()
	self._logList = nil
	self._logDict = nil
	self._logTagList = nil
	self._logTagDict = nil
end

function RoomLogConfig:reqConfigNames()
	return {
		"log_room_character",
		"log_room_tag"
	}
end

function RoomLogConfig:onInit()
	return
end

function RoomLogConfig:onConfigLoaded(configName, configTable)
	if configName == "log_room_character" then
		self._logList = configTable.configList
		self._logDict = configTable.configDict

		for index, co in ipairs(self._logList) do
			self._logDict[co.id] = co
		end
	elseif configName == "log_room_tag" then
		self._logTagList = configTable.configList
		self._logTagDict = configTable.configDict
	end
end

function RoomLogConfig:getLogList()
	return self._logList
end

function RoomLogConfig:getLogConfigById(id)
	return self._logDict[id]
end

function RoomLogConfig:getLogTagList()
	return self._logTagList
end

function RoomLogConfig:getLogTagConfigById(id)
	return self._logTagDict[id]
end

RoomLogConfig.instance = RoomLogConfig.New()

return RoomLogConfig
