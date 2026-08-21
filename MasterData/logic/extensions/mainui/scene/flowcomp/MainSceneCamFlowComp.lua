-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/flowcomp/MainSceneCamFlowComp.lua

module("logic.extensions.mainui.scene.flowcomp.MainSceneCamFlowComp", package.seeall)

local M = class("MainSceneCamFlowComp", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)

	self._sceneId = 9001
end

function M:onEnter()
	self:_setEvent(true)

	local sceneCO = SceneConfig.instance:getSceneCO(self._sceneId)

	VirtualCameraMgr.instance:resetCameraSettings()
	VirtualCameraMgr.instance:setActiveCamera(sceneCO.cameraCode)
	VirtualCameraMgr.instance:setFollowConfiner(sceneCO.confinerResPath)

	local cameraCO = CameraConfig.instance:getCameraCO(sceneCO.cameraCode)

	MainCameraMgr.instance:setCameraMaskMode(cameraCO.cameraMaskMode)
	VolumeMgr.instance:turnOn(sceneCO.volumeResPath)

	self._cameraUnit = VirtualCameraMgr.instance:getActiveCamera()

	if self._cameraUnit:getMainGO() then
		self:_initCamera()
	else
		self._cameraUnit:setLoadedCallback(self._initCamera, self)
	end
end

function M:onEnterDone()
	return
end

function M:onExit()
	self:clearEnv()

	self._cameraUnit = nil
	self._cameraOffset = nil
end

function M:onExitDone()
	return
end

function M:onLeaveScene(needUnloadRes)
	self:onExit()
end

function M:onReturnScene(needUnloadRes)
	self:onEnter()
end

function M:onReturnSceneFinished()
	return
end

function M:onSceneLoadDone()
	return
end

function M:clearEnv()
	self:_setEvent(false)

	local sceneCO = SceneConfig.instance:getSceneCO(self._sceneId or 0)

	if sceneCO then
		VolumeMgr.instance:turnOff(sceneCO.volumeResPath)
	end

	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:getCamUnit()
	return self._cameraUnit
end

function M:getCamGo()
	local camUnit = self:getCamUnit()
	local camGo = camUnit and camUnit:getMainGO() or nil

	return camGo
end

function M:getCamOffset(showLog)
	if not self._cameraOffset then
		local camGo = self:getCamGo()

		if camGo then
			local virtualCamera = goutil.addComponentOnce(camGo, ComponentType.CinemachineVirtualCamera)

			self._cameraOffset = CineCameraUtils.GetCinemachineCameraOffset(virtualCamera)
		end

		if not self._cameraOffset and showLog then
			printError("无法找到CinemachineExtension,CinemachineCameraOffset")
		end
	end

	return self._cameraOffset
end

function M:camOffsetEnabled(enabled)
	local camOffset = self:getCamOffset()

	if camOffset then
		camOffset.enabled = enabled
	end
end

function M:getRuntimeTransGizmo()
	if not self._camTransGizmo then
		self._camTransGizmo = RuntimeGizmos.TransformGizmo.Get(self._cameraUnit:getMainGO())
	end

	return self._camTransGizmo
end

function M:_initCamera()
	self._cameraUnit:setLoadedCallback(nil, nil)

	local camOffset = self:getCamOffset(true)

	if camOffset then
		camOffset:SetOffset(0, 0, 0)
	end

	self._cameraUnit._relativeComponent.enabled = false

	local defaultCam = MainScenePerformUtil.getAdjutantHeroCamCode()
	local x, y, z, rx, ry, rz, fov = MainPerformConfig.instance:getCamPosData(defaultCam)
	local camGo = self:getCamGo()

	if camGo then
		TransformUtils.SetLocalPosition(camGo.transform, x, y, z)
		TransformUtils.SetLocalEulerAngles(camGo.transform, rx, ry, rz)
	end

	self._cameraUnit:setFieldOfView(fov)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_INIT)
end

return M
