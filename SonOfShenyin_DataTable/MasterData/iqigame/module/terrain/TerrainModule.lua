-- chunkname: @IQIGame\\Module\\Terrain\\TerrainModule.lua

TerrainModule = {}

function TerrainModule.GetMap(id)
	if not CfgMapTable[id] then
		logError("Map表找不到id={0}的项", id)

		return
	end

	return CfgMapTable[id]
end
