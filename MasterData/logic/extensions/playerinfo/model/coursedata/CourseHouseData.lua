-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseHouseData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseHouseData", package.seeall)

local M = class("CourseHouseData")

function M:ctor()
	self.sortIndex = 0
end

function M.buildFromMsg(msg)
	local data = CourseHouseData.New()

	data._zoneId = msg.zoneId
	data._type = msg.type
	data._name = msg.name
	data._atmosphere = msg.atmosphere
	data._atmosphereSpecial = msg.atmosphereSpecial

	local livingFacilitiesCo = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, data._type)

	if livingFacilitiesCo then
		data._icon = livingFacilitiesCo.bgIcon
		data._atmosphereType = livingFacilitiesCo.atmosphere
	end

	if not name or name == "" then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, data._zoneId)

		data._name = roomCO.defaultName
	end

	return data
end

function M.buildFromDepot(mo)
	local data = CourseHouseData.New()

	data._zoneId = mo:getId()
	data._type = mo:getType()
	data._name = mo:getName()
	data._atmosphere = mo:getAtmosphere()
	data._atmosphereSpecial = mo:getAtmosphereSpecial()
	data._icon = mo:getBgIcon()
	data._atmosphereType = mo:getAtmosType()

	return data
end

function M:getId()
	return self._zoneId
end

function M:getName()
	return self._name
end

function M:getIcon()
	return self._icon
end

function M:getAtmosphere()
	return self._atmosphere
end

function M:getAtmosphereType()
	return self._atmosphereType
end

function M:getAtmosphereSpecial()
	return self._atmosphereSpecial
end

return M
