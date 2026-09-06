-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/config/SceneConfig.lua

module("logic.extensions.city.config.SceneConfig", package.seeall)

local SceneConfig = class("SceneConfig", BaseConfig)

SceneConfig.BattleSceneId = 1
SceneConfig.CreateRolelSceneId = 2

function SceneConfig:onInit()
	self._sceneCfg = nil
	self._engSceneName2SceneIdDict = nil
	self._sceneBornAreaCfg = nil
	self._cameraCfg = nil
	self._npcCfg = nil
	self._monsterMaster = nil
	self._monstersConfig = nil
	self._monstersScene = nil
end

function SceneConfig:getNames()
	return {
		"scene",
		"scene_born_area",
		"camera",
		"npc",
		"scene_monster_master",
		"scene_monster_creeps",
		"scene_monster_client",
		"scene_monster_zone",
		"scene_sourcemon_appear",
		"scene_tiling_config",
		"scene_tiling_elems_config",
		"audio_battle_bgm",
		"scene_festival"
	}
end

function SceneConfig:handleConfig(name, content)
	if name == "scene" then
		self._sceneCfg = content

		local engSceneName2SceneIdDict = {}
		local sceneName

		for k, v in pairs(content) do
			if type(k) == "number" then
				if not engSceneName2SceneIdDict[v.eng_scene_name] then
					engSceneName2SceneIdDict[v.eng_scene_name] = k
				else
					printError("存在重复的场景名称,sceneId=" .. k .. ",eng_scene_name=" .. engSceneName2SceneIdDict[v.eng_scene_name])
				end
			end
		end

		self._engSceneName2SceneIdDict = engSceneName2SceneIdDict
	elseif name == "scene_born_area" then
		self._sceneBornAreaCfg = content

		self:_initLinkedScenes()
	elseif name == "camera" then
		self._cameraCfg = content
	elseif name == "npc" then
		self:_handleNpcConfig(content)
	elseif name == "scene_monster_master" then
		self._monsterMaster = content

		self:_initMstSceneZones()
		self:_initSourcemons()
	elseif name == "scene_monster_client" then
		self._monstersConfig = content
	elseif name == "scene_monster_zone" then
		self._monstersScene = content

		self:_initMstSceneZones()
	elseif name == "scene_monster_creeps" then
		self._monsterCreeps = content
	elseif name == "scene_sourcemon_appear" then
		self._monsterSourceMonAppear = content

		self:_initMstSceneZones()
	elseif name == "scene_tiling_config" then
		self._sceneTilingConfig = content
	elseif name == "scene_tiling_elems_config" then
		self._sceneTilingElemConfig = content

		self:_handleTilingElems()
	elseif name == "audio_battle_bgm" then
		self._audioBattleBgm = content
	elseif name == "scene_festival" then
		self._sceneFestival = content
	end
end

function SceneConfig:_handleNpcConfig(content)
	self._npcCfg = content
	self._npcsInScene = {}

	for k, v in pairs(content) do
		if type(k) == "number" then
			local idStr = tostring(v.id)
			local len = #idStr

			v.sceneId = tonumber(string.sub(idStr, 1, len - 4))
			self._npcsInScene[v.sceneId] = self._npcsInScene[v.sceneId] or {}

			local npcsInScene = self._npcsInScene[v.sceneId]

			table.insert(npcsInScene, v)
		end
	end
end

function SceneConfig:_handleTilingElems()
	self._sortTilingElemConfig = {}
	self._sceneTilingElemWithLanform = {}

	for i = 1, #self._sceneTilingElemConfig.dataList do
		local data = self._sceneTilingElemConfig.dataList[i]
		local cfgs = self._sortTilingElemConfig[data.scene]

		if not cfgs then
			cfgs = {}
			self._sortTilingElemConfig[data.scene] = cfgs
		end

		table.insert(cfgs, data)

		if data.scene == TilingElemScene.Default then
			local elemWithLanform = self._sceneTilingElemWithLanform[data.landform]

			if not elemWithLanform then
				elemWithLanform = {}
				self._sceneTilingElemWithLanform[data.landform] = elemWithLanform
			end

			table.insert(elemWithLanform, data)
		end
	end
end

function SceneConfig:_initLinkedScenes()
	self._sceneLinkPaths = {}

	for i = 1, #self._sceneBornAreaCfg.dataList do
		local bCo = self._sceneBornAreaCfg.dataList[i]

		if bCo.fromScene ~= 0 then
			self._sceneLinkPaths[bCo.fromScene] = self._sceneLinkPaths[bCo.fromScene] or {}

			table.insert(self._sceneLinkPaths[bCo.fromScene], bCo.sceneId)
		end
	end
end

function SceneConfig:_initMstSceneZones()
	if self._monstersScene and self._monsterMaster and self._monsterSourceMonAppear then
		for k, v in pairs(self._monsterMaster) do
			if type(k) == "number" then
				v.sceneZoneId = 0
				v.isSourcemon = false
			end
		end

		for k, v in pairs(self._monstersScene) do
			if v.creepMasterIds then
				local len = #v.creepMasterIds

				for i = 1, len do
					local mstCo = self:getMonsterMaskterCo(v.creepMasterIds[i])

					if mstCo then
						mstCo.sceneZoneId = v.sceneZoneId
					end
				end
			end

			self:_initSourceMonZones(v.normalSourcemonPlanId, v.sceneZoneId)
			self:_initSourceMonZones(v.mutatedSourcemonPlanId, v.sceneZoneId)
		end
	end
end

function SceneConfig:_initSourceMonZones(planIds, zoneId)
	if planIds then
		local len = #planIds

		for i = 1, len do
			local appearCos = self:getSourceMonAppearCo(planIds[i])

			for k2, v2 in pairs(appearCos) do
				if v2.monsterId then
					for j = 1, #v2.monsterId do
						local mstCo = self:getMonsterMaskterCo(v2.monsterId[j])

						if mstCo then
							mstCo.sceneZoneId = zoneId
						end
					end
				end
			end
		end
	end
end

function SceneConfig:_initSourcemons()
	if self._monsterMaster then
		self._sourceMons = {}

		for k, v in pairs(self._monsterMaster) do
			if type(k) == "number" then
				v.isSourcemon = false

				if v.isSourcemon then
					table.insert(self._sourceMons, v)
				end
			end
		end
	end
end

function SceneConfig:getSceneCfg()
	return self._sceneCfg
end

function SceneConfig:getNpcCosBySceneId(sceneId)
	return self._npcsInScene[sceneId]
end

function SceneConfig:getTilingSceneConfig(id)
	return self._sceneTilingConfig[id]
end

function SceneConfig:getTilingSceneConfigIdByLandform(landform)
	for i = 1, #self._sceneTilingConfig.dataList do
		local da = self._sceneTilingConfig.dataList[i]

		if da.landform == landform then
			return da.id
		end
	end
end

function SceneConfig:getTilingSceneConfigList()
	return self._sceneTilingConfig.dataList
end

function SceneConfig:getSceneCo(sceneId)
	return self._sceneCfg[sceneId]
end

function SceneConfig:getScenePath(sceneId, toSceneId)
	if self._scenePaths and self._scenePaths[sceneId] and self._scenePaths[sceneId][toSceneId] then
		return self._scenePaths[sceneId][toSceneId]
	end

	local path = {}
	local ingCheckNode = {}

	self:_searchPath(sceneId, toSceneId, path, ingCheckNode)

	if #path > 0 then
		self._scenePaths = self._scenePaths or {}
		self._scenePaths[toSceneId] = self._scenePaths[toSceneId] or {}
		self._scenePaths[toSceneId][sceneId] = path

		local path1 = {}

		for i = #path, 1, -1 do
			table.insert(path1, path[i])
		end

		self._scenePaths[sceneId] = self._scenePaths[sceneId] or {}
		self._scenePaths[sceneId][toSceneId] = path1

		return path1
	end
end

function SceneConfig:_searchPath(sceneId, toSceneId, path, ingCheckNode)
	if ingCheckNode[sceneId] then
		return
	end

	local nodes = self._sceneLinkPaths[sceneId]

	if not nodes then
		return
	end

	ingCheckNode[sceneId] = true

	for i = 1, #nodes do
		if nodes[i] == toSceneId then
			return true
		end
	end

	for i = 1, #nodes do
		if self:_searchPath(nodes[i], toSceneId, path, ingCheckNode) then
			table.insert(path, nodes[i])

			return true
		end
	end
end

function SceneConfig:getSourceMonAppearCo(id)
	return self._monsterSourceMonAppear[id]
end

function SceneConfig:getSceneIdByEngSceneName(engSceneName)
	return self._engSceneName2SceneIdDict[engSceneName]
end

function SceneConfig:getCameraCo(cameraId)
	if not self._cameraCfg[cameraId] then
		printError("cannot find camera config,cameraId=", cameraId)
	end

	return self._cameraCfg[cameraId]
end

function SceneConfig:getNpcCo(npcId)
	return self._npcCfg[npcId]
end

function SceneConfig:getNpcModelFromConfig(npcId)
	local npcData = self:getNpcCo(npcId)

	if npcData == nil or string.nilorempty(npcData.model) then
		return ""
	end

	local modelName = npcData.model

	if npcData.funcType == UnitConst.NPC_TASK_TRIGGERD and not string.nilorempty(npcData.funcParams) and string.find(npcData.funcParams, "Daodangui") then
		modelName = self:_getHalloweenNpcModel(npcData)
	end

	return (modelName and #modelName > 0 or nil) and (string.find(modelName, "_lihui") and GameUrl.getLihuiSpineUrl(modelName) or GameUrl.getSpineUrl(modelName))
end

function SceneConfig:_getHalloweenNpcModel(npcCfg)
	local isPass = HalloweenGuestModel.instance:isHalloweenNpsPass(npcCfg.id)

	if isPass then
		return npcCfg.model
	end

	local list = string.split(npcCfg.funcParams, "#")

	if list and not string.nilorempty(list[2]) then
		return list[2]
	end

	return npcCfg.model
end

function SceneConfig:getZoneMonstersMaxNum(zoneId)
	local zone = self._monstersScene[zoneId]

	if zone then
		return zone.sceneZoneMonsterNum
	end
end

function SceneConfig:getMonsterPetId(mstId)
	if self._monsterMaster then
		local mst = self._monsterMaster[mstId]

		if mst then
			return mst.raceId
		end
	end
end

function SceneConfig:getMonsterMaskterCo(mstId)
	if self._monsterMaster then
		return self._monsterMaster[mstId]
	end
end

function SceneConfig:getMonsterSceneId(mstId)
	if self._monstersScene then
		local mstCo = self:getMonsterMaskterCo(mstId)

		if mstCo and mstCo.sceneZoneId then
			local mst = self._monstersScene[mstCo.sceneZoneId]

			if mst then
				return mst.sceneId
			end
		end
	end
end

function SceneConfig:getSceneIdBySceneZoneId(sceneZoneId)
	return self._monstersScene[sceneZoneId]
end

function SceneConfig:getMonstersByRaceId(raceId)
	if self._monsterCreeps then
		local msts

		for k, v in pairs(self._monsterMaster) do
			local formations = self._monsterCreeps[v.creepsMasterId]

			if formations then
				for k1, v1 in pairs(formations) do
					if v1.raceId == raceId then
						msts = msts or {}
						msts[v.creepMasterId] = true

						break
					end
				end
			end
		end

		if msts then
			local mstIds = {}

			for k, v in pairs(msts) do
				table.insert(mstIds, k)
			end

			return mstIds
		end
	end
end

function SceneConfig:getMonsterFormation(monsterId)
	if self._monsterCreeps then
		local creeps = self._monsterCreeps[monsterId]

		if not creeps then
			return
		end

		local formation = {}

		for k, v in pairs(creeps) do
			table.insert(formation, v)
		end

		return formation
	end
end

function SceneConfig:getMonsterConfigCo(mstId)
	if self._monstersConfig then
		return self._monstersConfig[mstId]
	end
end

function SceneConfig:getBornPoint(sceneId, fromSceneId)
	if self._sceneBornAreaCfg[sceneId] then
		local birthInfo = self._sceneBornAreaCfg[sceneId][fromSceneId]

		birthInfo = birthInfo or self._sceneBornAreaCfg[sceneId][0]

		local pos = birthInfo.position

		return pos[1], pos[2]
	end
end

function SceneConfig:getSourceMonsIdByType(sourceMonType)
	local mons

	if sourceMonType > 0 then
		self:_initSourceMonMap()

		for i = 1, #self._sourceMons do
			local raceId = self._sourceMons[i].raceId
			local monCo = self._sourceMonsMap[raceId]

			if monCo and monCo.type == sourceMonType then
				mons = mons or {}

				table.insert(mons, self._sourceMons[i])
			end
		end
	end

	mons = mons or self._sourceMons

	local ids = {}

	for i = 1, #mons do
		table.insert(ids, mons[i].creepMasterId)
	end

	return ids
end

function SceneConfig:getSourceMonsIdBySceneId(sceneId)
	local mons

	if sceneId > 0 then
		for i = 1, #self._sourceMons do
			local sId = self:getMonsterSceneId(self._sourceMons[i].creepMasterId)

			if sId == sceneId then
				mons = mons or {}

				table.insert(mons, self._sourceMons[i])
			end
		end
	end

	mons = mons or self._sourceMons

	local ids = {}

	for i = 1, #mons do
		table.insert(ids, mons[i].creepMasterId)
	end

	return ids
end

function SceneConfig:_initSourceMonMap()
	if self._sourceMonsMap then
		return
	end

	self._sourceMonsMap = {}

	local cfgs = SourceMonConfig.instance:getCfgs()

	for k, v in pairs(cfgs) do
		if type(k) == "number" then
			self._sourceMonsMap[v.modelId] = v
		end
	end
end

function SceneConfig:getRandomTilingElem(scene)
	local datas = self._sortTilingElemConfig[scene]
	local idx = math.random(1, #datas)

	return datas[idx]
end

function SceneConfig:getLanformTilingElems(landform)
	return self._sceneTilingElemWithLanform[landform]
end

function SceneConfig:getTilingElemCo(id)
	return self._sceneTilingElemConfig[id]
end

function SceneConfig:getBattleBgmConfigs()
	return self._audioBattleBgm.dataList
end

function SceneConfig:getSceneFestivals(sceneId)
	if self._sceneFestival then
		return self._sceneFestival[sceneId]
	end
end

function SceneConfig:getSceneFestivalCo(sceneId, festival)
	if string.nilorempty(festival) then
		return
	end

	if self._sceneFestival and self._sceneFestival[sceneId] then
		return self._sceneFestival[sceneId][festival]
	end
end

SceneConfig.instance = SceneConfig.New()

return SceneConfig
