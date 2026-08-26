-- chunkname: @modules/logic/versionactivity3_7/wmz/config/WmzConfig.lua

module("modules.logic.versionactivity3_7.wmz.config.WmzConfig", package.seeall)

local WmzConfig = class("WmzConfig", Activity220SimpleBaseConfig)

function WmzConfig:reqConfigNames()
	local tbl = WmzConfig.super.reqConfigNames(self)

	table.insert(tbl, "activity220_wmz_map")
	table.insert(tbl, "activity220_wmz_const")
	table.insert(tbl, "activity220_wmz_map_zone")

	return tbl
end

local function _constCO(id)
	return lua_activity220_wmz_const.configDict[id]
end

function WmzConfig:actId()
	if self.__activityId then
		return self.__activityId
	end

	self.__activityId = VersionActivity3_7Enum.ActivityId.Wmz or 13723

	return self.__activityId
end

function WmzConfig:getGameCO(mapId)
	return lua_activity220_wmz_map.configDict[mapId]
end

function WmzConfig:getZoneCO(zoneId)
	return lua_activity220_wmz_map_zone.configDict[zoneId]
end

function WmzConfig:getZoneCOList(mapId)
	local list = {}
	local CO = self:getGameCO(mapId)

	for i = 1, 1999 do
		local mem = "zoneId" .. tostring(i)
		local zoneId = CO[mem]

		if not zoneId then
			break
		end

		if zoneId ~= 0 then
			table.insert(list, self:getZoneCO(zoneId))
		end
	end

	return list
end

function WmzConfig:getConst(id, fallback)
	local CO = _constCO(id)

	return (CO or nil) and (CO.strValue or fallback)
end

function WmzConfig:getConstAsNumber(id, fallback)
	return tonumber(self:getConst(id)) or fallback
end

function WmzConfig:focusDurationSec()
	return self:getConstAsNumber(1, 0.5)
end

function WmzConfig:titleDescDurationSec()
	return self:getConstAsNumber(2, 3)
end

function WmzConfig:grayScaleHex()
	return self:getConst(6, "#1c1209D9")
end

function WmzConfig:waitDurationSecOnCompletedZone()
	return self:getConstAsNumber(4, 1.5)
end

function WmzConfig:waitDurationSecOnCompletedGame()
	return self:getConstAsNumber(5, 2)
end

function WmzConfig:selectedCompletedFrameGrayScaleHex()
	return self:getConst(3, "#828282ff")
end

WmzConfig.instance = WmzConfig.New()

return WmzConfig
