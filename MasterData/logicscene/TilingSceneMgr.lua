-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/tiling/TilingSceneMgr.lua

module("logicscene.scene.tiling.TilingSceneMgr", package.seeall)

local TilingSceneMgr = class("TilingSceneMgr")
local tilingSceneId = -10000
local hasInitTilingConfig = false
local answerSceneConfig = {
	default = {
		landform = "grass",
		edgeLeft = 6.1,
		cols = 5,
		angleRight = 26.6,
		edgeRight = 6.1,
		verticalMargins = 3.6,
		tileSizeX = 3.84,
		horizontalMargins = 3.6,
		angleLeft = 153.5,
		tileSizeY = 1.92,
		rows = 5,
		sky = "scene/tiling/sky/tiling_sky_cloud.prefab",
		tilesNum = 4
	},
	wanshengjie = {
		landform = "answerscenewanshengjie",
		edgeLeft = 8.1,
		cols = 4,
		angleRight = 26.6,
		edgeRight = 8.1,
		verticalMargins = 3.6,
		tileSizeX = 2.76,
		horizontalMargins = 3.6,
		angleLeft = 153.5,
		tileSizeY = 1.36,
		rows = 4,
		tilesNum = 1
	}
}

function TilingSceneMgr:ctor()
	self._expEvents = {}
	self._tilingSceneConfig = {}
end

function TilingSceneMgr:reset()
	self._expEvents = {}
	self._tilingSceneConfig = {}
end

function TilingSceneMgr:createTilingSceneId()
	tilingSceneId = tilingSceneId - 1

	return tilingSceneId
end

function TilingSceneMgr:enterPetZoo(cfgId)
	cfgId = cfgId or 1

	local zooSceneCo = ZooConfig.instance:getZooSceneCo(cfgId)
	local sceneId = tilingSceneId

	tilingSceneId = tilingSceneId - 1

	local sceneConfig = TilingSceneConfig.New()

	sceneConfig.sceneId = sceneId
	sceneConfig.assetPath = zooSceneCo.assetPath
	self._tilingSceneConfig[sceneId] = sceneConfig

	self:enter(SceneType.PetZoo, sceneId, zooSceneCo.birthPoint[1], zooSceneCo.birthPoint[2])
end

function TilingSceneMgr:enterAnswerScene(sceneId, festival)
	local aswSceneConfig = answerSceneConfig[festival]
	local sceneConfig = TilingSceneConfig.New()

	sceneConfig.sceneId = sceneId
	self._tilingSceneConfig[sceneId] = sceneConfig

	local assetPath = GameUrl.getScenCityStageResUrls(sceneId, festival)
	local tilingMap = STilingMapConfig.New()
	local tilingConfig = STilingConfig.New()

	tilingConfig.tileSizeX = aswSceneConfig.tileSizeX
	tilingConfig.tileSizeY = aswSceneConfig.tileSizeY
	tilingConfig.tilesNum = aswSceneConfig.tilesNum
	tilingConfig.landform = aswSceneConfig.landform
	tilingConfig.angleLeft = aswSceneConfig.angleLeft
	tilingConfig.angleRight = aswSceneConfig.angleRight
	tilingConfig.edgeLeft = aswSceneConfig.edgeLeft
	tilingConfig.edgeRight = aswSceneConfig.edgeRight
	tilingMap.config = tilingConfig
	tilingMap.rows = aswSceneConfig.rows
	tilingMap.cols = aswSceneConfig.cols
	tilingMap.horizontalMargins = aswSceneConfig.horizontalMargins
	tilingMap.verticalMargins = aswSceneConfig.verticalMargins
	tilingMap.tilingMap = assetPath[1]
	tilingMap.sky = aswSceneConfig.sky

	tilingMap:Calculate()

	self._tilingMapConfig = self._tilingMapConfig or {}
	self._tilingMapConfig[sceneId] = tilingMap

	return tilingMap
end

function TilingSceneMgr:enterExpEventMap()
	local xAsix, yAxis = ExpeditionTilingModel.instance:getTilingMapGrid()
	local mapData = ExpeditionTilingModel.instance:getTilingMapInfos()

	if not xAsix or not yAxis or not mapData or mapData.gridMapId == -1 then
		return
	end

	local key = xAsix .. "_" .. yAxis .. "_" .. mapData.gridMapId
	local sceneConfig = self._expEvents[key]

	if sceneConfig then
		if not sceneConfig.sceneId then
			local sceneId

			if not sceneId then
				sceneId = tilingSceneId
				tilingSceneId = tilingSceneId - 1
				sceneConfig = TilingSceneConfig.New()
				sceneConfig.sceneId = sceneId
				sceneConfig.key = key

				sceneConfig:fromExpedGridDatas(mapData)

				self._expEvents[key] = sceneConfig
				self._tilingSceneConfig[sceneId] = sceneConfig
			end

			ExpeditionTilingModel.instance:setTilingMapSceneId(sceneId)

			local cfg = ExpeditionConfig.instance:getMapGripCfg(mapData.gridMapId)

			self:enterRandomScene(SceneType.ExpedScene, sceneConfig.sceneId, self:getRandomLanformId(), cfg.mapSize[1], cfg.mapSize[2])
		end
	end
end

function TilingSceneMgr:updateExpEventMapConfig(sceneId)
	local config = self._tilingSceneConfig[sceneId]
	local mapData = ExpeditionTilingModel.instance:getTilingMapInfos()

	if not config or not config.elements or not mapData or mapData.gridMapId == -1 then
		return
	end

	local currEvtId, count = ExpeditionTilingModel.instance:getCurEventId()
	local isNewEvtId

	for i = 1, #mapData.gridList do
		local gridData = mapData.gridList[i]

		for j = 1, #config.elements do
			if config.elements[j].bindExpGridData and config.elements[j].bindExpGridData.eventId ~= currEvtId then
				local elemData = config.elements[j]

				table.remove(config.elements, j)

				isNewEvtId = true

				GlobalDispatcher:dispatch(GlobalNotify.TilingElemDelete, elemData)

				break
			end

			if config.elements[j].bindExpGridData and config.elements[j].bindExpGridData.eventId == gridData.eventId and config.elements[j].bindExpGridData.eventIndex == gridData.eventIndex then
				config.elements[j]:fromExpedGridData(gridData)

				if ExpeditionModel.instance:isEventCompeleted(gridData.eventId, gridData.progress) then
					local elemData = config.elements[j]

					table.remove(config.elements, j)
					GlobalDispatcher:dispatch(GlobalNotify.TilingElemDelete, elemData)
				end

				break
			end
		end
	end

	if isNewEvtId then
		config:fromExpedGridDatas(mapData)

		for j = 1, #config.elements do
			GlobalDispatcher:dispatch(GlobalNotify.TilingElemCreate, config.elements[j])
		end
	end

	if mapData.canLeave then
		local elemData = config:createExitrance()

		if elemData then
			GlobalDispatcher:dispatch(GlobalNotify.TilingElemCreate, elemData)
		end
	end
end

function TilingSceneMgr:getRandomLanformId()
	local cfgs = SceneConfig.instance:getTilingSceneConfigList()
	local index = math.random(1, #cfgs)

	return cfgs[index].id
end

function TilingSceneMgr:enterScene(sceneType, sceneId, cfgId, assetPath, tileRows, tileCols)
	local tilingMap = self:_buildTilingMapConfig(sceneId, cfgId, assetPath, tileRows, tileCols)

	self:enter(sceneType, sceneId, tilingMap.birthX, tilingMap.birthY)
end

function TilingSceneMgr:enter(sceneType, sceneId, birthX, birthY)
	local playerUsersVars, playerBirdgeSgate

	if SceneMainPlayer.instance then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			playerBirdgeSgate = mainPlayer:isUnderBridge()
		end
	end

	SceneStatusMgr.instance:saveStatus()
	SceneMgr.instance:enter(sceneType, sceneId, birthX, birthY, playerBirdgeSgate, playerUsersVars)
end

function TilingSceneMgr:enterRandomScene(sceneType, sceneId, cfgId, tileRows, tileCols)
	if not hasInitTilingConfig then
		hasInitTilingConfig = true

		local tilingAssets = CommonPreloader.instance:getConfigAsset("config/tilingmap_counter.txt")

		STilingMapAssets.Initialize(tilingAssets.text)
	end

	local tilingMap = self:_buildRandomTilingMapConfig(sceneId, cfgId, tileRows, tileCols)

	self:enter(sceneType, sceneId, tilingMap.birthX, tilingMap.birthY)
end

function TilingSceneMgr:getTilingMapConfig(sceneId)
	if not self._tilingMapConfig then
		return
	end

	return self._tilingMapConfig[sceneId]
end

function TilingSceneMgr:getTilingSceneConfig(sceneId)
	return self._tilingSceneConfig[sceneId]
end

function TilingSceneMgr:clearTilingSceneConfig(sceneId)
	if not sceneId then
		return
	end

	local config = self._tilingSceneConfig[sceneId]

	if config then
		self._tilingSceneConfig[sceneId] = nil

		if self._expEvents and config.key then
			self._expEvents[config.key] = nil
		end
	end
end

function TilingSceneMgr:_buildRandomTilingMapConfig(sceneId, cfgId, tileRows, tileCols)
	local tilingMap = self:getTilingMapConfig(sceneId)

	if tilingMap then
		return tilingMap
	end

	local configData = SceneConfig.instance:getTilingSceneConfig(cfgId)
	local landform = configData.landform
	local num = STilingMapAssets.GetLandformNum(landform, tileRows, tileCols)
	local assetPath = STilingMapConfig.GetRandomConfigPath(num, landform, tileRows, tileCols)

	return self:_buildTilingMapConfig(sceneId, cfgId, assetPath, tileRows, tileCols)
end

function TilingSceneMgr:_buildTilingMapConfig(sceneId, cfgId, assetPath, tileRows, tileCols)
	local tilingMap = STilingMapConfig.New()
	local configData = SceneConfig.instance:getTilingSceneConfig(cfgId)
	local tilingConfig = STilingConfig.New()

	tilingConfig.id = cfgId
	tilingConfig.tileSizeX = configData.tileSizeX
	tilingConfig.tileSizeY = configData.tileSizeY
	tilingConfig.tilesNum = configData.tilesNum
	tilingConfig.landform = configData.landform
	tilingConfig.angleLeft = configData.angleLeft
	tilingConfig.angleRight = configData.angleRight
	tilingConfig.edgeLeft = configData.edgeLeft
	tilingConfig.edgeRight = configData.edgeRight
	tilingMap.config = tilingConfig
	tilingMap.rows = tileRows
	tilingMap.cols = tileCols
	tilingMap.horizontalMargins = 3.6
	tilingMap.verticalMargins = 3.6
	tilingMap.tilingMap = assetPath
	tilingMap.airwall = "scene/tiling/airwalls/" .. configData.airwall .. "_p.prefab"

	local skies = configData.bkg
	local skyIdx = math.random(1, #skies)

	tilingMap.sky = "scene/tiling/sky/" .. skies[skyIdx] .. ".prefab"

	if GMModel.instance:getExpedTilingMapPath() then
		local path, landformGM = GMModel.instance:getExpedTilingMapPath()

		tilingConfig.landform = landformGM
		tilingMap.tilingMap = path
		tilingConfig.id = SceneConfig.instance:getTilingSceneConfigIdByLandform(landformGM)
	end

	tilingMap:Calculate()

	self._tilingMapConfig = self._tilingMapConfig or {}
	self._tilingMapConfig[sceneId] = tilingMap

	return tilingMap
end

function TilingSceneMgr:buildTilingMapElem(tilingMap)
	if tilingMap.hasGenerateElems then
		return
	end

	tilingMap.hasGenerateElems = true

	local elems = SceneConfig.instance:getLanformTilingElems(tilingMap.config.id)

	if not elems then
		return
	end

	local rates = {}

	for i = 1, #elems do
		for j = 1, elems[i].count do
			if not rates[i] then
				local currRate = 1

				if rates[i] > 0 then
					local rate = math.random(0, 1)

					if rate <= rates[i] then
						currRate = rates[i] - 1 / elems[i].count
						rates[i] = rates[i]

						local pos = tilingMap:GetRandomElemPos()

						tilingMap:CreateElem(elems[i].assetPath .. ".prefab", pos, elems[i].scale, (elems[i].flipx or nil) and math.random(0, 1) < 0.5, elems[i].layer, elems[i].layerOrder)
					end
				end
			end
		end
	end
end

function TilingSceneMgr:enterSeasonTilingScene(mapName)
	local sceneId = tilingSceneId

	tilingSceneId = tilingSceneId - 1

	local sceneConfig = TilingSceneConfig.New()

	sceneConfig.sceneId = sceneId
	sceneConfig.assetPath = {
		"scene/configs/season/" .. mapName .. ".txt"
	}
	sceneConfig.sky = "scene/tiling/sky/tiling_sky_cloud.prefab"
	self._tilingSceneConfig[sceneId] = sceneConfig

	self:enter(SceneType.SeasonTiling, sceneId, 0, 0)
end

function TilingSceneMgr:enterTreasureRaiderScene()
	local sceneId = tilingSceneId

	tilingSceneId = tilingSceneId - 2

	local sceneConfig = TilingSceneConfig.New()

	sceneConfig.sceneId = sceneId
	sceneConfig.assetPath = {
		"scene/configs/treasure_raider/treasure_raider.txt"
	}
	sceneConfig.sky = "scene/tiling/sky/tiling_sky_cloud.prefab"
	self._tilingSceneConfig[sceneId] = sceneConfig

	self:enter(SceneType.TreasureRaider, sceneId, 0, 0)
end

function TilingSceneMgr:enterDomainAdventureScene(sceneId, mapDataName)
	local sceneConfig = TilingSceneConfig.New()

	sceneConfig.sceneId = sceneId
	sceneConfig.assetPath = {
		mapDataName
	}
	sceneConfig.sky = "scene/tiling/sky/default_tiling_sky_cloud.prefab"
	self._tilingSceneConfig[sceneId] = sceneConfig

	self:enter(SceneType.DomainAdventure, sceneId, 0, 0)
end

TilingSceneMgr.instance = TilingSceneMgr.New()

return TilingSceneMgr
