-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/stage/BattleEmptySceneBuilder.lua

module("logic.scene.component.stage.BattleEmptySceneBuilder", package.seeall)

local BattleEmptySceneBuilder = {}
local kTypeRenderer = typeof(UnityEngine.Renderer)
local kMainColor = UnityEngine.Shader.PropertyToID("_BaseColor")

local function kSetCellColor(go, colorString)
	local color = Astral.ColorUtil.ParseColor(colorString)
	local renderer = goutil.addComponentOnce(go, kTypeRenderer)

	renderer.material:SetColor(kMainColor, color)
end

function BattleEmptySceneBuilder.build(sceneName, checkerBoardCode, terrainPrefabList)
	local disableTerrainPrefab = terrainPrefabList[1]
	local ableTerrainPrefab = terrainPrefabList[3]
	local highlandTerrainPrefab = terrainPrefabList[6]
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(checkerBoardCode)
	local initPosition = checkerBoardCO.initPosition
	local root = goutil.create(sceneName, false)

	SceneUtil.moveGameObjectToScene(root, sceneName)
	TransformUtils.SetLocalPosition(root.transform, -15, 0, -15)

	local sideLength = SpaceX.CheckBoardSetting.GetSideLength()
	local cellConfigs = checkerBoardCO.cellConfigs

	for _, cellCO in ipairs(cellConfigs) do
		local isHighland = cellCO.cellType == BattleEnum.CellType.TERRAIN102
		local prefab = ableTerrainPrefab

		if not cellCO.isEnable then
			prefab = nil
		elseif isHighland then
			prefab = highlandTerrainPrefab
		end

		if prefab then
			local cellX, cellZ = cellCO.coordinates[1], cellCO.coordinates[2]
			local terrainCO = TerrainConfig.instance:getTerrainCO(cellCO.cellType)
			local height = TerrainCOUtil.getCellHeight(cellCO)
			local name = string.format("%s_%s", cellX, cellZ)
			local goCell = goutil.clone(prefab, name)
			local px = (cellX + 0.5) * sideLength
			local py = height - 0.1
			local pz = (cellZ + 0.5) * sideLength

			goutil.addChildToParent(goCell, root)
			TransformUtils.SetLocalPosition(goCell.transform, px, py, pz)
		end
	end
end

return BattleEmptySceneBuilder
