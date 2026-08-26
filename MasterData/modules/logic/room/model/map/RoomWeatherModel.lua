-- chunkname: @modules/logic/room/model/map/RoomWeatherModel.lua

module("modules.logic.room.model.map.RoomWeatherModel", package.seeall)

local RoomWeatherModel = class("RoomWeatherModel", BaseModel)

function RoomWeatherModel:onInit()
	self:_clearData()
end

function RoomWeatherModel:reInit()
	self:_clearData()
end

function RoomWeatherModel:clear()
	RoomWeatherModel.super.clear(self)
	self:_clearData()
end

function RoomWeatherModel:_clearData()
	return
end

function RoomWeatherModel:setIsNight(isNight)
	self._isNight = isNight == true
end

function RoomWeatherModel:getIsNight()
	return self._isNight
end

RoomWeatherModel.instance = RoomWeatherModel.New()

return RoomWeatherModel
