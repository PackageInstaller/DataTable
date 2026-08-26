-- chunkname: @modules/logic/scene/room/fsm/action/RoomActionShowTimeCharacterBuilding.lua

module("modules.logic.scene.room.fsm.action.RoomActionShowTimeCharacterBuilding", package.seeall)

local RoomActionShowTimeCharacterBuilding = class("RoomActionShowTimeCharacterBuilding", RoomBaseFsmAction)

function RoomActionShowTimeCharacterBuilding:checkInteract()
	local interactionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	if interactionParam and interactionParam.id == self._interationId then
		return true
	end

	return false
end

function RoomActionShowTimeCharacterBuilding:onStart(param)
	self._param = param
	self._heroId = param.heroId
	self._buildingId = param.buildingId
	self._buildingUid = param.buildingUid
	self._interationId = param.id
	self._cameraId = param.cameraId
	self._faithOp = param.faithOp
	self._interaTionCfg = RoomConfig.instance:getCharacterInteractionConfig(param.id)
	self._roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)
	self._characterId = self._roomCharacterMO.id
	self._skinId = self._roomCharacterMO.skinId
	self._scene = GameSceneMgr.instance:getCurScene()
	self._heroAnimName, self._heroAnimDelay = self:_splitAnimState(self._interaTionCfg.heroAnimState)
	self._effectCfgList = self._heroAnimName and RoomConfig.instance:getCharacterEffectListByAnimName(self._skinId, self._heroAnimName)
	self._interactHeroPointName = RoomEnum.EntityChildKey.CritterPointList[1]
	self._interactSpineList = {}

	local strInteractSpines = self._interaTionCfg.buildingInsideSpines

	if not string.nilorempty(strInteractSpines) then
		self._interactSpineList = string.split(strInteractSpines, "#")
	end

	local config = RoomConfig.instance:getCharacterInteractionConfig(param.id)

	RoomCharacterController.instance:startDialogInteraction(config, param.buildingUid)
	self:onDone()
	TaskDispatcher.cancelTask(self._onInteractionFinish, self)
	TaskDispatcher.cancelTask(self._onDelayLoadDone, self)
	TaskDispatcher.cancelTask(self._onDelayNextCamera, self)

	self._isCameraDone = true

	if self:checkInteract() then
		self._isCameraDone = false

		self:tweenCamera(self._heroId, self._buildingUid, self._cameraId)
		ViewMgr.instance:openView(ViewName.RoomBuildingInteractionView)
	end

	self:_loaderEffect()
	self:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, true)

	self._delayCameraParam = nil
	self._nextCameraParams = self:_getNextCameraParams(self._cameraId)
end

function RoomActionShowTimeCharacterBuilding:_splitAnimState(animStr)
	if string.nilorempty(animStr) then
		return nil, 0
	end

	local arr = string.split(animStr, "#")
	local delay = #arr > 1 and tonumber(arr[2]) or 0

	return arr[1], delay
end

function RoomActionShowTimeCharacterBuilding:_loaderEffect(skinId)
	if self._effectCfgList then
		local hasEffect = #self._effectCfgList > 0

		if self._interactSpineList then
			local hasSpine = #self._interactSpineList > 0

			if hasEffect or hasSpine then
				self._isLoaderDone = false

				if self._loader == nil then
					self._loader = SequenceAbLoader.New()
				end

				local characterEntity = self._scene.charactermgr:getCharacterEntity(self._characterId, SceneTag.RoomCharacter)

				if characterEntity then
					characterEntity.characterspine:addResToLoader(self._loader)
					characterEntity.characterspineeffect:addResToLoader(self._loader)
				end

				if hasEffect then
					for _, cfg in ipairs(self._effectCfgList) do
						self._loader:addPath(self:_getEffecResAb(cfg.effectRes))
					end
				end

				if hasSpine then
					for _, spineName in ipairs(self._interactSpineList) do
						local spinePath = ResUrl.getSpineBxhyPrefab(spineName)

						self._loader:addPath(spinePath)
					end
				end

				self._loader:setConcurrentCount(10)
				self._loader:setLoadFailCallback(self._onLoadOneFail)
				self._loader:startLoad(self._onLoadFinish, self)
			elseif self._loader == nil then
				self._isLoaderDone = true
			end
		end
	end
end

function RoomActionShowTimeCharacterBuilding:_onLoadOneFail(loader, assetItem)
	logError("RoomActionShowTimeCharacterBuilding: 加载失败, url: " .. assetItem.ResPath)
end

function RoomActionShowTimeCharacterBuilding:_onLoadFinish(loader)
	TaskDispatcher.runDelay(self._onDelayLoadDone, self, 0.001)
end

function RoomActionShowTimeCharacterBuilding:_onDelayLoadDone()
	if not self._isLoaderDone then
		self._isLoaderDone = true

		self:_checkNext(true)
	end
end

function RoomActionShowTimeCharacterBuilding:_runTweenCamera(buildingUid, cameraId, frameCallback, finishCallback, callbackObj)
	local scene = self._scene
	local cfg = self:_getCameraConfig(cameraId)
	local focusXYZ = string.splitToNumber(cfg.focusXYZ, "#")

	if focusXYZ then
		if not focusXYZ[1] then
			local fx = 0

			if focusXYZ then
				if not focusXYZ[2] then
					local fy = 0

					if focusXYZ then
						if not focusXYZ[3] then
							local fz = 0
							local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)
							local foucsPos = buildingEntity:transformPoint(fx, fy, fz)
							local targetRotate = tonumber(cfg.rotate) + buildingEntity:getMO().rotate * 60

							targetRotate = RoomRotateHelper.getMod(targetRotate, 360) * Mathf.Deg2Rad

							local cameraState = RoomEnum.CameraState.InteractionCharacterBuilding
							local cameraParam = {
								focusX = foucsPos.x,
								focusY = foucsPos.z,
								zoom = scene.camera:getZoomInitValue(cameraState),
								rotate = targetRotate
							}

							scene.camera:setCharacterbuildingInteractionById(cameraId)
							scene.camera:switchCameraState(cameraState, cameraParam, frameCallback, finishCallback, callbackObj)

							return cameraParam
						end
					end
				end
			end
		end
	end
end

function RoomActionShowTimeCharacterBuilding:_getNextCameraParams(cameraId)
	local cfg = self:_getCameraConfig(cameraId)

	if not cfg or string.nilorempty(cfg.nextCameraParams) then
		return nil
	end

	local arr = GameUtil.splitString2(cfg.nextCameraParams, true)

	if not arr or #arr < 1 then
		return nil
	end

	local params = {}

	for _, nums in ipairs(arr) do
		if nums and #nums > 0 then
			local var_9_1 = {
				cameraId = nums[1]
			}

			var_9_1.delay = nums[2] or 0

			table.insert(params, var_9_1)
		end
	end

	return params
end

function RoomActionShowTimeCharacterBuilding:_getCameraConfig(cameraId)
	if self._param and self._param._debugCameraCfgDict then
		return self._param._debugCameraCfgDict[cameraId]
	end

	return (RoomConfig.instance:getCharacterBuildingInteractCameraConfig(cameraId))
end

function RoomActionShowTimeCharacterBuilding:_checkNextCamera()
	if self._delayCameraParam == nil and self._nextCameraParams and #self._nextCameraParams > 0 then
		self._delayCameraParam = self._nextCameraParams[1]

		table.remove(self._nextCameraParams, 1)
		TaskDispatcher.cancelTask(self._onDelayNextCamera, self)

		if self._delayCameraParam.delay and self._delayCameraParam.delay > 0 then
			TaskDispatcher.runDelay(self._onDelayNextCamera, self, self._delayCameraParam.delay)
		else
			self:_onDelayNextCamera()
		end
	end
end

function RoomActionShowTimeCharacterBuilding:_onDelayNextCamera()
	if self._delayCameraParam and self:checkInteract() then
		local cameraId = self._delayCameraParam.cameraId

		self._delayCameraParam = nil

		local curCameraState = self._scene.camera:getCameraState()

		if curCameraState == RoomEnum.CameraState.InteractionCharacterBuilding then
			self._runTweenCamera(self, self._buildingUid, cameraId, nil, self._checkNextCamera, self)
		else
			logNormal(string.format("camera state is [%s], not [%s].", curCameraState, RoomEnum.CameraState.InteractionCharacterBuilding))
		end
	end
end

function RoomActionShowTimeCharacterBuilding:tweenCamera(heroId, buildingUid, cameraId)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)
	local pos = roomCharacterMO.currentPosition
	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	table.insert(playingInteractionParam.positionList, pos)

	playingInteractionParam.cameraParam = self._runTweenCamera(self, buildingUid, cameraId, nil, self.interactionCameraDone, self)
end

function RoomActionShowTimeCharacterBuilding:interactionCameraDone()
	self._isCameraDone = true

	self:_checkNext()
end

function RoomActionShowTimeCharacterBuilding:_checkNext(isAfterLoad)
	if not self._isLoaderDone then
		return
	end

	if self._isCameraDone then
		self:playInteraction()
		self:playIneteractionEffect()
		self:createInteractionSpine()
		self:_checkNextCamera()
	end
end

function RoomActionShowTimeCharacterBuilding:playInteraction()
	self:endState()

	self._buildingEntity = self._scene.buildingmgr:getBuildingEntity(self._buildingUid, SceneTag.RoomBuilding)

	local buildingEntity = self._buildingEntity

	if buildingEntity and not string.nilorempty(self._interaTionCfg.buildingAnimState) then
		buildingEntity:playAnimator(self._interaTionCfg.buildingAnimState)
	end

	if self._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithAll then
		RoomCharacterController.instance:gainAllCharacterFaith(nil, nil, self._characterId)
	elseif self._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithOne then
		RoomCharacterController.instance:gainCharacterFaith({
			self._characterId
		})
	end

	local showtime = self:_getShowTime()

	TaskDispatcher.cancelTask(self._onInteractionFinish, self)
	TaskDispatcher.runDelay(self._onInteractionFinish, self, showtime)
	TaskDispatcher.cancelTask(self._onPlayHeroAnimState, self)

	if self._heroAnimDelay and self._heroAnimDelay > 0 then
		TaskDispatcher.runDelay(self._onPlayHeroAnimState, self, self._heroAnimDelay)
	else
		self:_onPlayHeroAnimState()
	end

	if self._interaTionCfg.buildingAudio and self._interaTionCfg.buildingAudio ~= 0 and buildingEntity then
		buildingEntity:playAudio(self._interaTionCfg.buildingAudio)
	end

	if self._interaTionCfg.buildingInside then
		TaskDispatcher.cancelTask(self.moveCharacterInsideBuilding, self)

		if self._interaTionCfg.delayEnterBuilding and self._interaTionCfg.delayEnterBuilding > 0 then
			TaskDispatcher.runDelay(self.moveCharacterInsideBuilding, self, self._interaTionCfg.delayEnterBuilding)
		else
			self:moveCharacterInsideBuilding()
		end
	end
end

function RoomActionShowTimeCharacterBuilding:_onPlayHeroAnimState()
	local characterEntity = self._scene.charactermgr:getCharacterEntity(self._characterId, SceneTag.RoomCharacter)

	if characterEntity and not string.nilorempty(self._heroAnimName) then
		characterEntity.characterspine:play(self._heroAnimName, false, true)
	end
end

function RoomActionShowTimeCharacterBuilding:moveCharacterInsideBuilding()
	self._characterEntity = self._scene.charactermgr:getCharacterEntity(self._characterId, SceneTag.RoomCharacter)

	local characterEntity = self._characterEntity

	if not characterEntity then
		return
	end

	local pointTrs
	local buildingEntity = self._buildingEntity
	local effectKey = buildingEntity:getMainEffectKey()
	local trsList = self._buildingEntity.effect:getGameObjectsTrsByName(effectKey, self._interactHeroPointName)

	if gohelper.isNil((trsList and #trsList > 0 or nil) and trsList[1]) then
		local positionZeroGO = buildingEntity and buildingEntity:getPlayerInsideInteractionNode()

		if gohelper.isNil(positionZeroGO) then
			return
		end

		local posZeroTrans = positionZeroGO.transform
		local x, y, z = transformhelper.getPos(posZeroTrans)

		characterEntity:setLocalPos(x, y, z)

		self.charOriScaleX, self.charOriScaleY, self.charOriScaleZ = characterEntity:getLocalScaleXYZ()

		local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(posZeroTrans)

		characterEntity:setLocalScale(scaleX, scaleY, scaleZ)
	else
		local showtime = self:_getShowTime()

		self._tweenMoveId = self._scene.tween:tweenFloat(0, 1, showtime, self._framePointCallback, self._finishCallback, self)
	end

	self._roomCharacterMO:setIsFreeze(true)
end

function RoomActionShowTimeCharacterBuilding:_framePointCallback(value, param)
	local pointTrs
	local effectKey = self._buildingEntity:getMainEffectKey()
	local trsList = self._buildingEntity.effect:getGameObjectsTrsByName(effectKey, self._interactHeroPointName)

	if trsList and #trsList > 0 then
		pointTrs = trsList[1]
	end

	if gohelper.isNil(pointTrs) then
		return
	end

	local tx, ty, tz = transformhelper.getPos(pointTrs)

	self._characterEntity:setLocalPos(tx, ty, tz)
end

function RoomActionShowTimeCharacterBuilding:_finishCallback(value, param)
	return
end

function RoomActionShowTimeCharacterBuilding:_killTween()
	if self._tweenMoveId then
		self._scene.tween:killById(self._tweenMoveId)

		self._tweenMoveId = nil
	end
end

function RoomActionShowTimeCharacterBuilding:setInteractBuildingSideIsActive(sideKey, isActive)
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(self._buildingUid, SceneTag.RoomBuilding)

	if buildingEntity then
		buildingEntity:setSideIsActive(sideKey, isActive)
	end
end

function RoomActionShowTimeCharacterBuilding:_getShowTime()
	if self._interaTionCfg and self._interaTionCfg.showtime and self._interaTionCfg.showtime ~= 0 then
		return self._interaTionCfg.showtime * 0.001
	end

	return 8
end

function RoomActionShowTimeCharacterBuilding:playIneteractionEffect()
	local effectCfgList = self._effectCfgList

	if not effectCfgList then
		return
	end

	local scene = self._scene
	local characterEntity = scene.charactermgr:getCharacterEntity(self._characterId, SceneTag.RoomCharacter)
	local go = characterEntity.characterspine:getCharacterGO()
	local spineEffect = characterEntity.characterspineeffect

	self._interationGOs = self._interationGOs or {}
	self._interationGODict = self._interationGODict or {}

	for i, cfg in ipairs(effectCfgList) do
		if not spineEffect:isHasEffectGO(cfg.animName) then
			local nameKey = "effect_" .. cfg.id
			local effectGo = self._interationGODict[nameKey]

			if gohelper.isNil(effectGo) then
				local pointPath = RoomCharacterHelper.getSpinePointPath(cfg.point)
				local pointGo = gohelper.findChild(go, pointPath) or go or characterEntity.containerGO
				local res = self:_getEffecRes(cfg.effectRes)
				local resAb = self:_getEffecResAb(cfg.effectRes)
				local prefabAssetItem = self._loader:getAssetItem(resAb)
				local prefab = prefabAssetItem:GetResource(res)

				effectGo = gohelper.clone(prefab, pointGo, nameKey)

				table.insert(self._interationGOs, effectGo)

				self._interationGODict[nameKey] = effectGo
			else
				gohelper.setActive(effectGo, false)
				gohelper.setActive(effectGo, true)
			end
		end
	end
end

function RoomActionShowTimeCharacterBuilding:createInteractionSpine()
	local interactSpineList = self._interactSpineList
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(self._buildingUid, SceneTag.RoomBuilding)

	if not interactSpineList or #interactSpineList <= 0 or not buildingEntity then
		return
	end

	self._interactionSpineGODict = self._interactionSpineGODict or {}

	for i, spineName in ipairs(interactSpineList) do
		local spineGO = self._interactionSpineGODict[spineName]

		if gohelper.isNil(spineGO) then
			local pointGo = buildingEntity:getSpineWidgetNode(i)
			local spinePath = ResUrl.getSpineBxhyPrefab(spineName)
			local prefabAssetItem = self._loader:getAssetItem(spinePath)
			local prefab = prefabAssetItem and prefabAssetItem:GetResource(spinePath)

			if prefab then
				spineGO = gohelper.clone(prefab, pointGo, spineName)
				self._interactionSpineGODict[spineName] = spineGO

				local spineSkeletonAnim = spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

				if spineSkeletonAnim then
					spineSkeletonAnim:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
				end
			end
		else
			gohelper.setActive(spineGO, false)
			gohelper.setActive(spineGO, true)
		end
	end
end

function RoomActionShowTimeCharacterBuilding:playInteractionSpineAnim()
	local interactSpineList = self._interactSpineList

	if not interactSpineList or #interactSpineList <= 0 then
		return
	end

	self._interactionSpineGODict = self._interactionSpineGODict or {}

	for _, spineName in ipairs(interactSpineList) do
		local spineSkeletonAnim
		local spineGO = self._interactionSpineGODict[spineName]

		if not gohelper.isNil(spineGO) then
			spineSkeletonAnim = spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		end

		if spineSkeletonAnim then
			spineSkeletonAnim:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
		end
	end
end

function RoomActionShowTimeCharacterBuilding:_clearLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._interationGOs then
		local count = #self._interationGOs

		for i = 1, count do
			local go = self._interationGOs[i]

			self._interationGOs[i] = nil

			gohelper.destroy(go)
		end

		self._interationGOs = nil
	end

	if self._interationGODict then
		for key, v in pairs(self._interationGODict) do
			self._interationGODict[key] = nil
		end

		self._interationGODict = nil
	end

	if self._interactionSpineGODict then
		for _, go in pairs(self._interactionSpineGODict) do
			gohelper.destroy(go)
		end

		self._interactionSpineGODict = nil
	end
end

function RoomActionShowTimeCharacterBuilding:_getEffecRes(path)
	return RoomResHelper.getCharacterEffectPath(path)
end

function RoomActionShowTimeCharacterBuilding:_getEffecResAb(path)
	return RoomResHelper.getCharacterEffectABPath(path)
end

function RoomActionShowTimeCharacterBuilding:_onInteractionFinish()
	self:_killTween()

	local isCurIntact = self:checkInteract()

	if isCurIntact then
		RoomCharacterController.instance:endInteraction()
		ViewMgr.instance:closeView(ViewName.RoomBuildingInteractionView)
	end

	local sceneCamera = self._scene.camera

	if isCurIntact and sceneCamera:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		local pos = self._roomCharacterMO.currentPosition

		sceneCamera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = pos.x,
			focusY = pos.z
		}, nil, self.insideBuildingInteractFinish, self)
	else
		self:insideBuildingInteractFinish()
	end

	self:_clearLoader()

	if self.charOriScaleX and self.charOriScaleY and self.charOriScaleZ then
		self._characterEntity:setLocalScale(self.charOriScaleX, self.charOriScaleY, self.charOriScaleZ)
	end

	self.charOriScaleX = nil
	self.charOriScaleY = nil
	self.charOriScaleZ = nil

	if self._interaTionCfg.buildingInside then
		self._roomCharacterMO:setIsFreeze(false)
		RoomCharacterController.instance:correctCharacterHeight(self._roomCharacterMO)
	end
end

function RoomActionShowTimeCharacterBuilding:insideBuildingInteractFinish()
	if not self._interaTionCfg.buildingInside then
		return
	end

	self:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)
end

function RoomActionShowTimeCharacterBuilding:onDone()
	return
end

function RoomActionShowTimeCharacterBuilding:endState()
	self:_killTween()

	if self.fsmTransition then
		self.fsmTransition:endState()
	end
end

function RoomActionShowTimeCharacterBuilding:stop()
	self:_killTween()
end

function RoomActionShowTimeCharacterBuilding:clear()
	self:_killTween()
	self:_clearLoader()
	TaskDispatcher.cancelTask(self._onInteractionFinish, self)
	TaskDispatcher.cancelTask(self._onDelayLoadDone, self)
	TaskDispatcher.cancelTask(self._onDelayNextCamera, self)
	TaskDispatcher.cancelTask(self._onPlayHeroAnimState, self)
	TaskDispatcher.cancelTask(self.moveCharacterInsideBuilding)
end

return RoomActionShowTimeCharacterBuilding
