-- chunkname: @modules/logic/explore/map/scene/ExploreMapScenePreloadComp.lua

module("modules.logic.explore.map.scene.ExploreMapScenePreloadComp", package.seeall)

local ExploreMapScenePreloadComp = class("ExploreMapScenePreloadComp", LuaCompBase)
local emptLightmapColorPath = "scenes/dynamic/textures/empty_white.png"
local CHECK_INTERVAL = 0.01
local delay_updateTime = 0.3
local MAX_SHOW = 20
local fovAdd = 2
local far = 15
local near = 1

function ExploreMapScenePreloadComp:init(go)
	self.go = go
	self.showRage = Vector4.New(0, 0, 6, 6)
	self._allObjDic = {}
	self._allMajorDic = {}
	self._allShadowObjDic = {}
	self._lightMapObjs = {}
	self._lightmapUseByDic = {}
	self._lightMapCSArr = nil
	self.showObjIdDict = {}

	local levelId = GameSceneMgr.instance:getCurLevelId()
	local levelCO = lua_scene_level.configDict[levelId]

	if SLFramework.FrameworkSettings.IsEditor then
		local filePath = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/explore/lua_explore_scene_" .. levelCO.resName .. ".lua"

		if SLFramework.FileHelper.IsFileExists(filePath) == false then
			self.hasInit = false

			logError("congfig not find :" .. filePath)

			return
		end
	end

	local luaPath = "modules.configs.explore.lua_explore_scene_" .. levelCO.resName

	self._config = addGlobalModule(luaPath)
	self.hasInit = true
	self._waitAtiveDict = {}
	self.camera = CameraMgr.instance:getMainCamera()

	local curScene = GameSceneMgr.instance:getCurScene()

	self._lights = nil

	if curScene then
		local sceneGo = curScene.level:getSceneGo()

		self._lights = sceneGo:GetComponentsInChildren(typeof(UnityEngine.Light))
	end

	self._lightmapABPath = "modules/explore/scene/" .. levelCO.resName
	self._lightMapLoader = MultiAbLoader.New()

	for i, v in ipairs(self._config.lightmapList) do
		self._lightmapUseByDic[i] = {}

		self._lightMapLoader:addPath(v[1])
		self._lightMapLoader:addPath(v[2])
	end

	self._lightMapLoader:addPath(emptLightmapColorPath)
	self._lightMapLoader:startLoad(self._initLightMap, self)

	local scenObjContainer = gohelper.create3d(self.go, "sceneObj")
	local map = ExploreController.instance:getMap()

	for i, v in ipairs(self._config.objList) do
		local obj = ExploreMapSceneObj.New((v.areaId and v.areaId > 0 or nil) and map:getContainRootByAreaId(v.areaId).sceneObj)

		obj:setData(v)

		self._allObjDic[v.id] = obj

		if v.major == 1 then
			self._allMajorDic[v.id] = true
		end

		if ExploreConstValue.MapSceneObjAlwaysShowEffectType[obj.effectType] then
			obj:show()
		end
	end

	self:_buildTree()

	if self._config.shadowObjs then
		for i, v in ipairs(self._config.shadowObjs) do
			local obj = ExploreMapShadowObj.New((v.areaId and v.areaId > 0 or nil) and map:getContainRootByAreaId(v.areaId).sceneObj)

			obj:setData(v)

			self._allShadowObjDic[v.id] = obj
		end
	end

	self:addEventListeners()
end

function ExploreMapScenePreloadComp:addEventListeners()
	if self.hasInit then
		self.addEventCb(self, ExploreController.instance, ExploreEvent.SetCameraPos, self.updateCameraPos, self)
		self.addEventCb(self, ExploreController.instance, ExploreEvent.ShowSceneObj, self.showSceneObj, self)
		self.addEventCb(self, ExploreController.instance, ExploreEvent.HideSceneObj, self.hideSceneObj, self)
		self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
		TaskDispatcher.runRepeat(self._checkActive, self, CHECK_INTERVAL)
	end
end

function ExploreMapScenePreloadComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SetCameraPos, self.updateCameraPos, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.ShowSceneObj, self.showSceneObj, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.HideSceneObj, self.hideSceneObj, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SceneObjLoadedCb, self.SceneObjLoadedCb, self)
	TaskDispatcher.cancelTask(self._checkActive, self)
end

function ExploreMapScenePreloadComp:showSceneObj(id)
	local obj = self._allObjDic[id]

	obj:markShow()

	self._waitAtiveDict[id] = true

	self:_updateLightMapUseBy(obj, true)
end

function ExploreMapScenePreloadComp:hideSceneObj(id)
	local obj = self._allObjDic[id]

	self._waitAtiveDict[id] = nil

	if ExploreConstValue.MapSceneObjAlwaysShowEffectType[obj.effectType] ~= true then
		local changed = obj:hide()

		if changed then
			self:_updateLightMapUseBy(obj, false)
		end
	end
end

function ExploreMapScenePreloadComp:_onScreenResize()
	self:updateCameraPos(self._targetPos)
end

function ExploreMapScenePreloadComp:updateCameraPos(targetPos)
	local first = self._targetPos == nil

	self._targetPos = targetPos or self._targetPos
	self.showRage.x = self._targetPos.x
	self.showRage.y = self._targetPos.z

	if first then
		self:_firstInitMap()
	elseif self.markDelayUpdate ~= true then
		self.markDelayUpdate = true

		TaskDispatcher.runDelay(self._delayUpdate, self, delay_updateTime)
	end
end

function ExploreMapScenePreloadComp:_firstInitMap()
	self.leftInitActiveNum = self:calcNeedLoadedSceneObj()

	if self.leftInitActiveNum > 0 then
		self.addEventCb(self, ExploreController.instance, ExploreEvent.SceneObjLoadedCb, self.SceneObjLoadedCb, self)
	end
end

function ExploreMapScenePreloadComp:calcNeedLoadedSceneObj()
	self.markDelayUpdate = false

	self:_delayUpdate()
	TaskDispatcher.cancelTask(self._delayUpdate, self)

	return self:_checkActive(tabletool.len(self._waitAtiveDict))
end

function ExploreMapScenePreloadComp:SceneObjLoadedCb()
	self.leftInitActiveNum = self.leftInitActiveNum - 1

	if self.leftInitActiveNum <= 0 then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
		self.removeEventCb(self, ExploreController.instance, ExploreEvent.SceneObjLoadedCb, self.SceneObjLoadedCb, self)
	end
end

function ExploreMapScenePreloadComp:clearUnUseObj()
	for i, v in pairs(self._allObjDic) do
		v:unloadnow()
	end
end

local RebuildFrustumPlanes = LuaProfiler.GetID("RebuildFrustumPlanes")
local GetTreeCheckResult = LuaProfiler.GetID("GetTreeCheckResult")
local GetTreeCheckResult_For = LuaProfiler.GetID("GetTreeCheckResult_For")

function ExploreMapScenePreloadComp:_delayUpdate()
	if ExploreConstValue.UseCSharpTree then
		local camera = CameraMgr.instance:getMainCamera()
		local fov = camera.fieldOfView + fovAdd
		local asp = camera.aspect
		local farClipPlane = far
		local nearClipPlane = near

		LuaProfiler.BeginSample(RebuildFrustumPlanes)
		ZProj.ExploreHelper.RebuildFrustumPlanes(camera, farClipPlane, nearClipPlane, fov, asp)
		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(GetTreeCheckResult)

		local result, count = ZProj.ExploreHelper.GetTreeCheckResult(self.showRage, 1)

		LuaProfiler.EndSample()
		LuaProfiler.BeginSample(GetTreeCheckResult_For)

		for i = 0, count - 1 do
			local id = result[i] + 1
			local obj = self._allObjDic[id]

			if obj.ishide == true then
				self:showSceneObj(id)
			else
				self:hideSceneObj(id)
			end
		end

		LuaProfiler.EndSample()
	else
		for k, v in pairs(self.showObjIdDict) do
			self.showObjIdDict[k] = 0
		end

		self._tree:triggerMove(self.showRage, self.showObjIdDict)

		for id in pairs(self._allObjDic) do
			if self.showObjIdDict[id] == 1 then
				self:showSceneObj(id)
			else
				self:hideSceneObj(id)
			end
		end
	end

	self:_updateLightMap()
	self:_updateShadow()

	self.markDelayUpdate = false
end

function ExploreMapScenePreloadComp:_buildTree()
	if ExploreConstValue.UseCSharpTree then
		ZProj.ExploreHelper.InitTreeObj(self._config.tree, #self._allObjDic)
	else
		self._tree = ExploreMapTree.New()

		self._tree:setup(self._config.tree, self)
	end
end

function ExploreMapScenePreloadComp:_updateShadow()
	if self._lights then
		local fov = self.camera.fieldOfView + 2
		local asp = self.camera.aspect
		local farClipPlane = 25
		local nearClipPlane = 0.01

		ZProj.ExploreHelper.RebuildDirectionalCullingPlanes(self.camera, farClipPlane, nearClipPlane, fov, asp, self._lights)

		for i, v in pairs(self._allShadowObjDic) do
			if ZProj.ExploreHelper.CheckBoundIsInDirectionalCullingPlanes(v.bounds) then
				v:show()
			else
				v:hide()
			end
		end
	end
end

function ExploreMapScenePreloadComp:_initLightMap()
	if #self._config.lightmapList <= 0 then
		UnityEngine.LightmapSettings.lightmaps = tolua.toarray({}, typeof(UnityEngine.LightmapData))

		ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, 0)

		return
	end

	local assetItem = self._lightMapLoader:getAssetItem(emptLightmapColorPath)
	local lightmapColorAssetItem = self._lightMapLoader:getFirstAssetItem()
	local lightmapDirAssetItem = self._lightMapLoader:getFirstAssetItem()
	local emptRes = assetItem:GetResource(emptLightmapColorPath)
	local lightmaps = {}

	for i, v in ipairs(self._config.lightmapList) do
		local lightmapData = UnityEngine.LightmapData()

		lightmapData.lightmapColor = emptRes
		lightmapData.lightmapDir = emptRes

		if GameResMgr.IsFromEditorDir then
			lightmapColorAssetItem = self._lightMapLoader:getAssetItem(v[1])
			lightmapDirAssetItem = self._lightMapLoader:getAssetItem(v[2])
		end

		lightmaps[i] = lightmapData
		self._lightMapObjs[i] = ExploreMapLightMapObj.New(lightmapData, v, emptRes, lightmapColorAssetItem, lightmapDirAssetItem)
	end

	self._lightMapCSArr = tolua.toarray(lightmaps, typeof(UnityEngine.LightmapData))
	UnityEngine.LightmapSettings.lightmaps = self._lightMapCSArr

	self:_updateLightMap()
end

function ExploreMapScenePreloadComp:_updateLightMapUseBy(sceneObj, add)
	local list = sceneObj.useLightMapIndexList

	for _, index in ipairs(list) do
		index = index + 1

		if index > 0 then
			self._lightmapUseByDic[index][sceneObj.id] = add and true or nil
		end
	end
end

function ExploreMapScenePreloadComp:_updateLightMap()
	local count = 0

	for index, obj in ipairs(self._lightMapObjs) do
		local useCount = tabletool.len(self._lightmapUseByDic[index])

		if useCount > 0 then
			obj:show()

			count = count + 1
		elseif useCount == 0 then
			obj:hide()
		end
	end

	UnityEngine.LightmapSettings.lightmaps = self._lightMapCSArr

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateLightMap, count)
end

function ExploreMapScenePreloadComp:_checkActive(checkNum)
	checkNum = checkNum or MAX_SHOW

	local doActiveNum = 0

	if next(self._waitAtiveDict) then
		for id in pairs(self._waitAtiveDict) do
			if checkNum == 0 then
				break
			end

			if self._allMajorDic[id] then
				local obj = self._allObjDic[id]

				self._waitAtiveDict[id] = nil

				if obj.ishide == false and obj:show() then
					doActiveNum = doActiveNum + 1
					checkNum = checkNum - 1
				end
			end
		end

		for id in pairs(self._waitAtiveDict) do
			if checkNum == 0 then
				break
			end

			local obj = self._allObjDic[id]

			self._waitAtiveDict[id] = nil

			if obj.ishide == false and obj:show() then
				doActiveNum = doActiveNum + 1
				checkNum = checkNum - 1
			end
		end
	end

	return doActiveNum
end

function ExploreMapScenePreloadComp:_getFirstActive()
	local id = next(self._waitAtiveDict)

	while id do
		self._waitAtiveDict[id] = nil

		local obj = self._allObjDic[id]

		if obj.ishide == false then
			return obj
		end

		id = next(self._waitAtiveDict)
	end
end

function ExploreMapScenePreloadComp:onDestroy()
	for i, v in pairs(self._allObjDic) do
		v:dispose()
	end

	for i, v in pairs(self._lightMapObjs) do
		v:dispose()
	end

	for i, v in pairs(self._allShadowObjDic) do
		v:dispose()
	end

	TaskDispatcher.cancelTask(self._delayUpdate, self)

	if self._tree then
		self._tree:onDestroy()
	end

	self._tree = nil
	self._waitAtiveDict = nil
	self._allObjDic = nil
	self._lightMapObjs = nil
	self._allShadowObjDic = nil
	self._lightMapCSArr = nil

	if self._lightMapLoader then
		self._lightMapLoader:dispose()
	end

	self._lightMapLoader = nil
end

return ExploreMapScenePreloadComp
