-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/data/UltimateWarRecord.lua

module("logic.extensions.ultimatewar.data.UltimateWarRecord", package.seeall)

local UltimateWarRecord = class("UltimateWarRecord")

function UltimateWarRecord:ctor()
	return
end

function UltimateWarRecord:onReset()
	self._headInfo = nil
	self._player = nil
	self._time = 0
	self._damage = 0
	self._areaId = 0
end

function UltimateWarRecord:updateData(value)
	self._headInfo = value.headInfo
	self._player = value.player
	self._time = checknumber(value.time)
	self._damage = checknumber(value.damage)
	self._areaId = checknumber(value.areaId)
end

function UltimateWarRecord:isEmpty()
	return self._headInfo == nil
end

function UltimateWarRecord:getHeadInfo()
	return self._headInfo
end

function UltimateWarRecord:getPlayer()
	return self._player
end

function UltimateWarRecord:getTime()
	return self._time
end

function UltimateWarRecord:getDamage()
	return self._damage
end

function UltimateWarRecord:getAreaId()
	return self._areaId
end

return UltimateWarRecord
