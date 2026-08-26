-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoMapInfo.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapInfo", package.seeall)

local GaoSiNiaoMapInfo = class("GaoSiNiaoMapInfo")

function GaoSiNiaoMapInfo:make_bagCO(ptype, count)
	if false and self.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			ptype = ptype,
			count = count or 0
		}
	end
end

function GaoSiNiaoMapInfo:make_gridCO(gtype, ptype, bMovable, zRot)
	if false and self.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			gtype = gtype,
			ptype = ptype,
			bMovable = bMovable or false,
			zRot = zRot or 0
		}
	end
end

function GaoSiNiaoMapInfo:make_gridCOZot(gtype, zRot)
	if false and self.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			bMovable = false,
			gtype = gtype,
			ptype = GaoSiNiaoEnum.PathType.None,
			zRot = zRot or 0
		}
	end
end

local kMapModulePath = "modules.configs.gaosiniao.map_"

function GaoSiNiaoMapInfo:_getMapRequireLuaPath()
	return kMapModulePath .. self.version
end

function GaoSiNiaoMapInfo:_loadMapConfig()
	local path = self:_getMapRequireLuaPath()

	return require(path)
end

function GaoSiNiaoMapInfo:ctor(eVersion)
	self.version = assert(eVersion)

	self:clear()
end

function GaoSiNiaoMapInfo:clear()
	self._mapCO = false
	self.mapId = 0
	self.mapCOList = self.mapCOList or self:_loadMapConfig()
end

function GaoSiNiaoMapInfo:mapCO()
	if not self._mapCO then
		for _, mapCO in ipairs(self.mapCOList) do
			if mapCO.id == self.mapId then
				self._mapCO = tabletool.copy(mapCO)

				break
			end
		end
	end

	if isDebugBuild and not self._mapCO then
		logError("Not Found MapCO!! mapId=" .. tostring(self.mapId))
	end

	return self._mapCO or {}
end

function GaoSiNiaoMapInfo:reset(mapId, eVersion)
	if eVersion then
		self.version = eVersion
	end

	self:clear()

	self.mapId = mapId

	return self:mapCO()
end

function GaoSiNiaoMapInfo:mapSize()
	local mapCO = self:mapCO() or {}

	if not mapCO.width then
		local width = 0

		if not mapCO.height then
			local height = 0

			return width, height
		end
	end
end

function GaoSiNiaoMapInfo:bagList()
	local mapCO = self:mapCO()

	return (mapCO or nil) and (mapCO.bagList or {})
end

function GaoSiNiaoMapInfo:gridList()
	local mapCO = self:mapCO()

	return (mapCO or nil) and (mapCO.gridList or {})
end

return GaoSiNiaoMapInfo
