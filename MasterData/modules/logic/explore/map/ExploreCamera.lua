-- chunkname: @modules/logic/explore/map/ExploreCamera.lua

module("modules.logic.explore.map.ExploreCamera", package.seeall)

local ExploreCamera = class("ExploreCamera", LuaCompBase)
local defaultCameraId = 3
local defaultHeightCameraId = 4

function ExploreCamera:onDestroy()
	TaskDispatcher.cancelTask(self._everyFrameCheckRotate, self)

	if self._clipObjs then
		for k, v in pairs(self._clipObjs) do
			v:clear()
		end

		self._clipObjs = nil
	end

	if self._cameraComp then
		self._cameraComp.transparencySortMode = self._lastTransparencySortMode
		self._cameraComp = nil
	end

	self._nowCameraType = nil

	if self._animComp and self._animComp.runtimeAnimatorController == self._animatorInst then
		self._animComp:Play(0, 0, 1)
		self._animComp:Update(0)

		self._animComp.runtimeAnimatorController = nil
		self._animComp.enabled = false
	end

	self._animComp = nil
	self._animatorInst = nil
end

function ExploreCamera:setMap(map)
	self._map = map
end

function ExploreCamera:initHeroPos()
	local node = ExploreMapModel.instance:getNode(ExploreHelper.getKey(self._map:getHeroPos()))

	if node and node.cameraId ~= defaultCameraId then
		self:setCameraCOType(node.cameraId, true)
		self._cameraComp:applyDirectly()
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		self._animatorInst = self._map:getLoader():getAssetItem(ExploreConstValue.EntryCameraCtrlPath):GetResource(ExploreConstValue.EntryCameraCtrlPath)
		self._animComp = CameraMgr.instance:getCameraRootAnimator()
		self._animComp.enabled = true
		self._animComp.runtimeAnimatorController = nil
		self._animComp.runtimeAnimatorController = self._animatorInst

		self._animComp:Update(0)

		self._animComp.enabled = false
	end
end

function ExploreCamera:beginCameraAnim()
	if self._animComp then
		self._animComp.enabled = true
	end

	self:setCameraPos()
end

function ExploreCamera:init(go)
	self._mapGo = go

	self:initCamera()

	self._occlusionLayerMask = LayerMask.GetMask("SceneOpaqueOcclusionClip")
	self._clipObjs = {}
	self._cameraCODefault = lua_camera.configDict[defaultCameraId]
	self._cameraCOHight = lua_camera.configDict[defaultHeightCameraId]
	self._scale = 0
end

function ExploreCamera:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnScaleMap, self.setScale, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnDeltaScaleMap, self.deltaScale, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnChangeCameraCO, self.setCameraCOType, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.SetCameraPos, self.setCameraPos, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, self.beginCameraAnim, self)
end

function ExploreCamera:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnScaleMap, self.setScale, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnDeltaScaleMap, self.deltaScale, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnChangeCameraCO, self.setCameraCOType, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SetCameraPos, self.setCameraPos, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, self.beginCameraAnim, self)
end

function ExploreCamera:getCamera()
	return self._camera
end

function ExploreCamera:getCameraGO()
	return self._cameraGo
end

function ExploreCamera:getMainCameraTrs()
	return self._cameraTrs
end

function ExploreCamera:getRotation()
	return transformhelper.getLocalRotation(self._cameraTrs.parent)
end

function ExploreCamera:initCamera()
	self._cameraComp = GameSceneMgr.instance:getCurScene().camera
	self._camera = CameraMgr.instance:getMainCamera()

	self._cameraComp:setCameraTraceEnable(true)

	self._cameraGo = CameraMgr.instance:getMainCameraGO()
	self._cameraTrs = CameraMgr.instance:getMainCameraTrs()
	self._lastTransparencySortMode = self._cameraComp.transparencySortMode
	self._cameraComp.transparencySortMode = UnityEngine.TransparencySortMode.Perspective
end

function ExploreCamera:deltaScale(deltaScale)
	local scale = self._scale + deltaScale

	self:setScale(scale)
end

function ExploreCamera:setScale(scale)
	self._scale = Mathf.Clamp(scale, 0, 1)
	self._cameraCODefault = lua_camera.configDict[defaultCameraId]
	self._cameraCOHight = lua_camera.configDict[defaultHeightCameraId]

	local fov = self._cameraCODefault.fov + (self._cameraCOHight.fov - self._cameraCODefault.fov) * self._scale

	self._cameraComp:setFov(fov)
end

function ExploreCamera:_everyFrameCheckRotate()
	local _cameraCo = lua_camera.configDict[self._nowCameraType]
	local x, y, z = self:getRotation()

	if not _cameraCo or y == _cameraCo.yaw then
		TaskDispatcher.cancelTask(self._everyFrameCheckRotate, self)
	end

	ExploreMapModel.instance.nowMapRotate = y

	ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
end

function ExploreCamera:setCameraCOType(type, isFirst)
	if not type or type == 0 then
		type = defaultCameraId
	end

	if self._nowCameraType == type then
		return
	end

	local _cameraCO = lua_camera.configDict[type]

	if not isFirst then
		if _cameraCO.yaw ~= ExploreMapModel.instance.nowMapRotate then
			TaskDispatcher.runRepeat(self._everyFrameCheckRotate, self, 0.05, -1)
		end
	else
		ExploreMapModel.instance.nowMapRotate = _cameraCO.yaw

		ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
	end

	self._nowCameraType = type
	self._scale = (_cameraCO.fov - self._cameraCODefault.fov) / (self._cameraCOHight.fov - self._cameraCODefault.fov)

	local fov = self._scale * (self._cameraCOHight.fov - self._cameraCODefault.fov) + self._cameraCODefault.fov

	self._cameraComp:resetParam(_cameraCO)
	self._cameraComp:setFocus(self._targetPos.x, self._targetPos.y, self._targetPos.z)
	self._cameraComp:setFov(fov)
end

function ExploreCamera:setCameraPos(targetPos)
	targetPos = targetPos or self._targetPos

	if not targetPos then
		return
	end

	self._targetPos = targetPos

	self._cameraComp:setFocus(targetPos.x, targetPos.y, targetPos.z)
	self:_raycast(self._targetPos)
end

function ExploreCamera:_raycast(pos)
	local cameraPos = self._cameraTrs.position
	local dis = Vector3.Distance(cameraPos, pos)
	local hitInfos = UnityEngine.Physics.RaycastAll(cameraPos, pos - cameraPos, dis, self._occlusionLayerMask)

	for k, v in pairs(self._clipObjs) do
		v:markClip(false)
	end

	for i = 0, hitInfos.Length - 1 do
		local hitInfo = hitInfos[i]
		local hitTrans = hitInfo.transform

		if not self._clipObjs[hitTrans] then
			self._clipObjs[hitTrans] = ExploreMapClipObj.New()

			self._clipObjs[hitTrans]:init(hitTrans)
		end

		self._clipObjs[hitTrans]:markClip(true)
	end

	for _, v in pairs(self._clipObjs) do
		v:checkNow()
	end
end

return ExploreCamera
