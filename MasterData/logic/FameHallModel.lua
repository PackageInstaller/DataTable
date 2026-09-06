-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/model/FameHallModel.lua

module("logic.extensions.famehall.model.FameHallModel", package.seeall)

local FameHallModel = class("FameHallModel", BaseModel)

function FameHallModel:ctor()
	return
end

function FameHallModel:onInit()
	self:onReset()
end

function FameHallModel:onReset()
	self._info = {}
end

function FameHallModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._info[info.type] = self._info[info.type] or {}

	if info.periodId then
		self._info[info.type][info.periodId] = info.player
	else
		self._info[info.type][1] = info.player
	end
end

function FameHallModel:getInfo(typeId, periodId)
	if self._info and self._info[typeId] then
		return self._info[typeId][periodId]
	end

	return nil
end

FameHallModel.instance = FameHallModel.New()

return FameHallModel
