-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/TerrainConfig.lua

module("logic.battle.config.TerrainConfig", package.seeall)

local TerrainConfig = class("TerrainConfig", BaseConfig)

function TerrainConfig:onInit()
	self._cfgTerrain = false
	self._cfgAdditionalTerrain = false
end

function TerrainConfig:getNames()
	return {
		ConfigName.Terrain,
		ConfigName.AdditionalTerrain
	}
end

function TerrainConfig:handleConfig(name, content)
	if name == ConfigName.Terrain then
		self._cfgTerrain = content

		self:_updateHeightMapProxyHeight()
	elseif name == ConfigName.AdditionalTerrain then
		self._cfgAdditionalTerrain = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function TerrainConfig:getTerrainCO(code)
	return self._cfgTerrain[code]
end

function TerrainConfig:getAdditionalTerrainCO(code)
	local terrainCO = self._cfgAdditionalTerrain[code]

	if not terrainCO then
		printError("cannot find additional terrain config for code = ", code)

		return false
	end

	return terrainCO
end

function TerrainConfig:_updateHeightMapProxyHeight()
	local dataList = self._cfgTerrain.dataList

	for _, terrainCO in ipairs(dataList) do
		SpaceX.HeightMapProxy.SetTerrainHeight(terrainCO.code, terrainCO.height)
	end
end

TerrainConfig.instance = TerrainConfig.New()

return TerrainConfig
