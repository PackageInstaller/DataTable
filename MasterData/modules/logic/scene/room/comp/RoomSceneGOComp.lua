-- chunkname: @modules/logic/scene/room/comp/RoomSceneGOComp.lua

module("modules.logic.scene.room.comp.RoomSceneGOComp", package.seeall)

local RoomSceneGOComp = class("RoomSceneGOComp", BaseSceneComp)

function RoomSceneGOComp:onInit()
	return
end

function RoomSceneGOComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self.sceneGO = self._scene.level:getSceneGo()
	self.groundGO = gohelper.findChild(self.sceneGO, "ground")
	self.blockRoot = gohelper.findChild(self.sceneGO, "ground/blockRoot")
	self.buildingRoot = gohelper.findChild(self.sceneGO, "ground/buildingRoot")
	self.characterRoot = gohelper.findChild(self.sceneGO, "ground/characterRoot")
	self.resourceRoot = gohelper.findChild(self.sceneGO, "ground/resourceRoot")
	self.waterRoot = gohelper.findChild(self.sceneGO, "ground/waterRoot")
	self.planeGO = gohelper.findChild(self.sceneGO, "ground/plane")
	self.ambientGO = gohelper.findChild(self.sceneGO, "ground/ambient")
	self.feature = gohelper.findChild(self.sceneGO, "ground/feature")
	self.initbuildingRoot = gohelper.findChild(self.sceneGO, "ground/initbuildingRoot")
	self.inventoryRootGO = gohelper.findChild(self.sceneGO, "inventoryRoot")
	self.canvasGO = gohelper.findChild(self.sceneGO, "canvas")
	self.virtualCameraGO = gohelper.findChild(self.sceneGO, "virtualCamera")
	self.virtualCameraXZGO = gohelper.findChild(self.sceneGO, "virtualCameraXZ")
	self.poolContainerGO = gohelper.findChild(self.sceneGO, "poolContainer")
	self.directionalLightGO = gohelper.findChild(self.sceneGO, "lighting/Directional Light")
	self.camerahelperGO = gohelper.findChild(self.sceneGO, "camerahelper")
	self.fogRoot = gohelper.findChild(self.sceneGO, "fogRoot")
	self.skyGO = gohelper.findChild(self.sceneGO, "virtualCameraXZ/skybox/sky")
	self.commonEffectRoot = gohelper.findChild(self.sceneGO, "commonEffectRoot")
	self.virtualCameraTrs = self.virtualCameraGO.transform
	self.inventoryRootTrs = self.inventoryRootGO.transform
	self.virtualCameraXZTrs = self.virtualCameraXZGO.transform
	self.directionalLightGOTrs = self.directionalLightGO.transform
	self.vehicleRoot = self:_findOrCreateChild(self.groundGO, "vehicleRoot")
	self.critterRoot = self:_findOrCreateChild(self.groundGO, "critterRoot")
	self.sceneAmbient = self.ambientGO:GetComponent(typeof(ZProj.SceneAmbient))
	self.sceneCulling = self.ambientGO:GetComponent(typeof(SceneCulling))

	if SDKMgr.instance:isEmulator() then
		self.sceneCulling.enabled = false
	end

	self.sceneShadow = self.ambientGO:GetComponent(typeof(SceneShadow))
	self._effectParamList = {}
	self.sceneAmbientData = self.sceneAmbient.data
	self._partGODict = {}

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id
		local partGO = gohelper.findChild(self.initbuildingRoot, "part" .. partId)

		if partGO then
			self._partGODict[partId] = partGO
		end
	end

	if BootNativeUtil.isAndroid() then
		local gpuName = UnityEngine.SystemInfo.graphicsDeviceName

		self.compatibility = string.find(gpuName, "^Adreno") or string.find(gpuName, "^Mali")
		self.compatibility = self.compatibility or SDKMgr.instance:isEmulator()
	else
		self.compatibility = true
	end
end

function RoomSceneGOComp:getPartGOById(partId)
	if self._partGODict then
		return self._partGODict[partId]
	end
end

function RoomSceneGOComp:_findOrCreateChild(parentGO, name)
	local go = gohelper.findChild(parentGO, name)

	go = go or gohelper.create3d(parentGO, name)

	return go
end

function RoomSceneGOComp:setupShadowParam(isOverlook)
	if self.shadowState ~= isOverlook then
		local sceneShadow = self.sceneShadow

		if sceneShadow ~= nil then
			if isOverlook then
				sceneShadow.overrideShadowCascadesOption = true
				sceneShadow.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				sceneShadow.overrideShadowResolution = true
				sceneShadow.shadowResolution = 1600
				sceneShadow.softShadow = true

				UnityEngine.Shader.EnableKeyword("_PERFORMANCE_HIGH")
				gohelper.setActive(self.feature, false)
			else
				sceneShadow.overrideShadowCascadesOption = true
				sceneShadow.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				sceneShadow.overrideShadowResolution = true
				sceneShadow.shadowResolution = 2048
				sceneShadow.softShadow = true

				local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

				if quality == ModuleEnum.Performance.High and self.compatibility then
					UnityEngine.Shader.DisableKeyword("_PERFORMANCE_HIGH")
					gohelper.setActive(self.feature, true)
				end
			end

			sceneShadow:ApplyProperty()
		end

		self.shadowState = isOverlook
	end
end

function RoomSceneGOComp:onSceneClose()
	self.sceneGO = nil
	self.groundGO = nil
	self.blockRoot = nil
	self.buildingRoot = nil
	self.characterRoot = nil
	self.resourceRoot = nil
	self.waterRoot = nil
	self.planeGO = nil
	self.ambientGO = nil
	self.initbuildingRoot = nil
	self.inventoryRootGO = nil
	self.canvasGO = nil
	self.virtualCameraGO = nil
	self.virtualCameraXZGO = nil
	self.poolContainerGO = nil
	self.camerahelperGO = nil
	self.fogRoot = nil
	self.skyGO = nil
	self.commonEffectRoot = nil
	self.inventoryRootTrs = nil
	self.virtualCameraTrs = nil
	self.virtualCameraXZTrs = nil
	self.directionalLightGOTrs = nil
	self.sceneAmbient = nil
	self.sceneShadow = nil
	self.vehicleRoot = nil
	self.sceneAmbientData = nil

	TaskDispatcher.cancelTask(self._onTimeEnd, self)

	if self._effectParamList then
		for i, effectParam in ipairs(self._effectParamList) do
			effectParam.go = nil
		end

		self._effectParamList = nil
	end

	local dataTb = self._partGODict

	self._partGODict = nil

	if dataTb then
		for datakey in pairs(dataTb) do
			rawset(dataTb, datakey, nil)
		end
	end
end

function RoomSceneGOComp:spawnEffect(res, containerGO, name, ab, time)
	local go = RoomGOPool.getInstance(res, containerGO or self.commonEffectRoot, name, ab)

	if not go then
		return nil
	end

	local effectParam = {
		go = go,
		res = res
	}

	if time then
		effectParam.time = time + Time.time
	end

	table.insert(self._effectParamList, effectParam)
	self:_updateTimer()

	return go
end

function RoomSceneGOComp:_updateTimer()
	TaskDispatcher.cancelTask(self._onTimeEnd, self)

	local minTime

	for i, effectParam in ipairs(self._effectParamList) do
		if effectParam.time and (not minTime or minTime > effectParam.time) then
			minTime = effectParam.time
		end
	end

	if minTime then
		TaskDispatcher.runDelay(self._onTimeEnd, self, minTime - Time.time)
	end
end

function RoomSceneGOComp:_onTimeEnd()
	for i = #self._effectParamList, 1, -1 do
		local effectParam = self._effectParamList[i]

		if effectParam.time and effectParam.time <= Time.time then
			RoomGOPool.returnInstance(effectParam.res, effectParam.go)

			effectParam.go = nil

			table.remove(self._effectParamList, i)
		end
	end

	self:_updateTimer()
end

return RoomSceneGOComp
