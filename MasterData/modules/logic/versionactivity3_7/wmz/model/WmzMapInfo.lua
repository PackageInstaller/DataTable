-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapInfo.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzMapInfo", package.seeall)

local WmzMapInfo = class("WmzMapInfo")
local ti = table.insert
local sf = string.format

function WmzMapInfo.s_makeEmpty(x, y, optCellInfo)
	local res = {
		x = x,
		y = y,
		floorType = WmzEnum.FloorType.PassableEmpty,
		pathType = WmzEnum.FloorType.None
	}

	if optCellInfo then
		res.zoneId = optCellInfo.zoneId
		res.sprite = optCellInfo.sprite
		res._fSprite = optCellInfo._fSprite
	end

	return res
end

function WmzMapInfo.s_makeVoid(x, y, optCellInfo)
	local res = {
		x = x,
		y = y,
		floorType = WmzEnum.FloorType.Void,
		pathType = WmzEnum.FloorType.None
	}

	if optCellInfo then
		res.zoneId = optCellInfo.zoneId
		res.sprite = optCellInfo.sprite
		res._fSprite = optCellInfo._fSprite
	end

	return res
end

function WmzMapInfo.s_isStart(pt)
	return pt == WmzEnum.PathType.L or pt == WmzEnum.PathType.T or pt == WmzEnum.PathType.R or pt == WmzEnum.PathType.B
end

function WmzMapInfo.s_isTile(pt, ft)
	if WmzMapInfo.s_isStart(pt) then
		return false
	end

	if pt == WmzEnum.PathType.MoveableNone then
		return true
	end

	if ft ~= WmzEnum.FloorType.Passable then
		return false
	end

	return pt ~= WmzEnum.PathType.None and pt ~= WmzEnum.PathType.__End
end

function WmzMapInfo:ctor()
	self:clear()
end

function WmzMapInfo:clear()
	self.mapId = 0
	self._mapCO = false
end

local kMapModulePath = "modules.configs.wmz.map_"

function WmzMapInfo:_getMapRequireLuaPath()
	return kMapModulePath .. tostring(self.mapId)
end

function WmzMapInfo:_loadMapConfig()
	local path = self:_getMapRequireLuaPath()

	return require(path)
end

function WmzMapInfo:reset(mapId)
	self:clear()

	self.mapId = mapId

	return self:mapCO()
end

function WmzMapInfo:mapCO()
	self._mapCO = self._mapCO or self:_loadMapConfig()

	if isDebugBuild then
		if not self._mapCO then
			logError("Not Found MapCO!! mapId=" .. tostring(self.mapId))
		elseif WmzEnum.rDir then
			local list = self._mapCO.girds
			local strBuf = {}

			for _, cellInfo in ipairs(list) do
				local ptStr = WmzEnum.nameOfPT(cellInfo.pathType or WmzEnum.PathType.None)
				local var_10_4 = WmzEnum.nameOfFT(cellInfo.floorType or WmzEnum.FloorType.Void)

				ti(strBuf, sf("(%s,%s): pt:%s, ft:%s, gp:%s, zId:%s, sprite:%s fsprite:%s", cellInfo.x, cellInfo.y, ptStr, ftStr, cellInfo.groupId or 0, cellInfo.zoneId or 0, cellInfo.sprite or "None", cellInfo._fSprite or "None"))
			end

			logError(table.concat(strBuf, "\n"))
		end
	end

	return self._mapCO or {}
end

function WmzMapInfo:girds()
	return self:mapCO().girds
end

function WmzMapInfo:mapSize()
	local w = self:mapCO().width
	local h = self:mapCO().height

	return w, h
end

return WmzMapInfo
