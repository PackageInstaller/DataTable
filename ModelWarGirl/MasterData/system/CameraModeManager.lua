-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\CameraModeManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local CameraModeManager = GLDeclare("CameraModeManager", {})
local GyroUtils = Framework.Device.GyroUtils
local GameSettings = require("Helper/GameSettings")
local self = CameraModeManager
local CameraManager = Framework.CameraSystem.CameraManager
local CameraControllerNodeType = Framework.CameraSystem.CameraControllerNodeType
local Const = require("Const")
local CAMERA_NODE_TYPE_TARGET = 1

function CameraModeManager.init()
	CameraModeManager._gyroEnabled = false

	CameraManager.Init(Const.CAMERA_GROUP_PREFAB)
	self.setMSAA(GameSettings.msaaSample)
	CameraManager.SetModeChangeCallBack(CameraModeManager.onCameraChanged)
end

function CameraModeManager.destroy()
	CameraManager.DestroyInstance()
end

function CameraModeManager.initCameraControllerNode()
	if not self.animatorCamera then
		self.animatorCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_ANIMATOR, CameraControllerNodeType.AnimatorTargetController)
	end

	if not self.mainCamera then
		self.mainCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_FREE, CameraControllerNodeType.FreeTargetController)
	end

	if not self.battleCamera then
		self.battleCamera = CameraManager.AddControllerNode(Const.CAMERA_CONTROL_NODE_BATTLE, CameraControllerNodeType.TargetController)
	end
end

function CameraModeManager.setMainStageMode(translateTime)
	CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
	CameraManager.SwitchToNode(translateTime or 0, self.mainCamera)
	CameraManager.DeactiveAllUnusedNode()
end

function CameraModeManager.setBattleMode(translateTime)
	CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
	CameraManager.SetDefaultNode(self.battleCamera)
	CameraManager.SwitchToNode(translateTime or 0, self.battleCamera)
	CameraManager.DeactiveAllUnusedNode()
end

function CameraModeManager.setAnimatorMode(translateTime)
	CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
	CameraManager.SetDefaultNode(self.animatorCamera)
	CameraManager.SwitchToNode(translateTime or 0, self.animatorCamera)
	CameraManager.DeactiveAllUnusedNode()
end

function CameraModeManager.setBattleOffset(state, offsetX)
	state.cameraCenterPointGo.transform.position = state.centerPoint + state.upDir * 1.2 + state.leftDir * offsetX * 18
	state.centerPointGo.transform.position = state.centerPoint + state.leftDir * offsetX * 18
end

function CameraModeManager.setToBattle(state, cameraNow, centerOffsetX, dist, cameraOffsetX)
	CameraManager.EnableCameraFreeForm(self.battleCamera, 1)

	state.cameraCenterPointGo.transform.position = state.centerPoint + state.upDir * 1.2 + state.leftDir * ((centerOffsetX or 0) + (cameraOffsetX or 0)) * 18
	state.centerPointGo.transform.position = state.centerPoint + state.leftDir * (centerOffsetX or 0) * 18

	CameraModeManager.setBattleMode()
	CameraManager.SetTarget(state.cameraCenterPointGo, true, 0)

	if state:isZombieBattle() then
		CameraManager.SetCameraDist(self.battleCamera, 20, 35)
	else
		CameraManager.SetCameraDist(self.battleCamera, 18, 26)
	end

	if cameraNow then
		CameraModeManager.battleToDefaultMode(0, -state.gridAngle, dist)
	else
		CameraModeManager.battleToDefaultMode(state.cameraFadeDuration or 0.5, -state.gridAngle, dist)
	end

	local minHoriz = 150 + state.gridAngle
	local maxHoriz = 210 + state.gridAngle

	if minHoriz < 0 then
		minHoriz = minHoriz + 360
	elseif minHoriz >= 360 then
		minHoriz = minHoriz - 360
	end

	if maxHoriz <= 0 then
		maxHoriz = maxHoriz + 360
	elseif maxHoriz > 360 then
		maxHoriz = maxHoriz - 360
	end

	CameraManager.LimitHorizAngel(self.battleCamera, 1, minHoriz, maxHoriz)
end

function CameraModeManager.battleToDefaultMode(duration, gridAngle, dist)
	local state = GameFsm.getCurState()

	TouchManager.enabled(false)

	if state and state.battleConfig and state.battleConfig.matrix_type == 1 then
		CameraManager.SetCameraRotation(1, duration, 36, (gridAngle or 0) + 180, 0, dist or 22.6)
	else
		CameraManager.SetCameraRotation(1, duration, 42, (gridAngle or 0) + 180, 0, dist or 22.6)
	end

	CameraManager.CameraGrp:SetFov(25, duration)
end

function CameraModeManager.battleToActMode(duration, x, y)
	TouchManager.enabled(true)
	CameraManager.SetCameraRotation(1, duration, tonumber(x) or 28, tonumber(y) or -160, 0, 22.6)
end

function CameraModeManager.getBattleCameraAngles()
	local tra = CameraManager.GetControlNodeTransform(CameraModeManager.battleCamera)

	if tra then
		return tra.eulerAngles
	end
end

function CameraModeManager.setBattleOver(state)
	CameraManager.SwitchToNode(0.1, 0)
	CameraManager.EnableCameraFreeForm(self.battleCamera, 0)
	TouchManager.enabled(false)

	local p = state:getCenterPointPos()

	state:setCameraCenterPointGoPos({
		x = p.x,
		y = p.y + 0.7,
		z = p.z
	})

	local tra = CameraManager.GetControlNodeTransform(CameraModeManager.battleCamera)
	local angleAniTime = 2.3
	local fovAniTime = 2

	if tra then
		local nodeRotation = tra.eulerAngles

		CameraManager.SetCameraDist(self.battleCamera, 10, 30)
		CameraManager.SetCameraRotation(1, angleAniTime, 15, -state.gridAngle + 180, 0, 11)
		coroutine.wait(angleAniTime - 0.8)
		CameraManager.CameraGrp:SetFov(30, fovAniTime)
	end

	return angleAniTime + fovAniTime
end

function CameraModeManager.setMazeMode(duration)
	CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
	CameraManager.SwitchToNode(duration or 0, self.mainCamera)
	CameraManager.DeactiveAllUnusedNode()
end

function CameraModeManager.onCameraChanged(fromCamera, toCamera)
	if fromCamera == self.nearCamera then
		ClientUtils.checkExitCamNearView(true)
	end
end

function CameraModeManager.setGyroActive(enabled)
	if CameraModeManager._gyroEnabled == enabled then
		return
	end

	if not CameraManager then
		return
	end

	local gameObject = CameraManager.GetMainCamera().gameObject

	if enabled then
		GyroUtils.AddActorOnGameObject(gameObject, 1, 1, 0.3, 0.3)
	else
		GyroUtils.SetActorActive(gameObject, false)
	end

	CameraModeManager._gyroEnabled = enabled
end

function CameraModeManager.set2DHDR(enable)
	CameraManager.Set2DHDR(enable)
end

function CameraModeManager.getScreenPos(pos)
	return CameraManager.GetScreenPos(pos)
end

function CameraModeManager.setMSAA(msaaSample)
	CameraManager.AllowMSAA(msaaSample)
end

function CameraModeManager.setHDR(needHdr)
	CameraManager.AllowHDR(needHdr)
end

CameraModeManager.initCameraControllerNode()

return CameraModeManager
