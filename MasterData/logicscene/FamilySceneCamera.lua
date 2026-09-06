-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/FamilySceneCamera.lua

module("logicscene.scene.component.camera.FamilySceneCamera", package.seeall)

local FamilySceneCamera = class("FamilySceneCamera", SceneCameraBase)

function FamilySceneCamera:ctor(scene)
	FamilySceneCamera.super.ctor(self, scene)

	self._playerToCamDir = FamilyScene.playerToCamDir
	self._cameraEulerAngle = FamilyScene.CameraEulerAngle
	self._fov = FamilyScene.CameraFov
end

function FamilySceneCamera:_initCameraFollow()
	local mainCameraGO = self._mainCamera:getGO()
	local follower = Framework.CameraMmoFollow.Get(mainCameraGO)

	follower.enabled = false

	return follower
end

function FamilySceneCamera:onEnterScene(sceneId, bornX, bornZ)
	self._mainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

	local mainCam = self._mainCamera:getCamera()

	GlobalModel.instance.skillCamera.gameObject:SetActive(false)
	GlobalModel.instance.skillUICamera.gameObject:SetActive(false)
	AMCameraShake.StopShake(mainCam.gameObject)
	AMFollowTarget.StopFollow(mainCam.gameObject)
	Spine.Unity.BoneFollower.StopFollow(mainCam.gameObject)
	self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
end

function FamilySceneCamera:onEnterSceneFinished(sceneId, bornX, bornZ)
	local mainCamera = self._mainCamera:getCamera()
	local x, y, z = self._mainPlayer.transform:getPos()

	mainCamera.farClipPlane = 1000
	mainCamera.orthographic = false
	mainCamera.fieldOfView = self._fov

	self:setPosFocus(x, y, z)
end

function FamilySceneCamera:onExitScene()
	self._follower.enabled = false

	self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
end

function FamilySceneCamera:updateCameraParams()
	return
end

function FamilySceneCamera:_onMainUnitPosChanged(x, y, z, isSetPosDirectly)
	self:setPosFocus(x, y, z)
end

function FamilySceneCamera:setPosFocus(x, y, z)
	local mainCamera = self._mainCamera:getCamera()
	local posX = x + self._playerToCamDir.x
	local posY = y + self._playerToCamDir.y
	local posZ = z + self._playerToCamDir.z

	posX = Mathf.Clamp(posX, FamilyScene.CameraLimitStartPos.x, FamilyScene.CameraLimitEndPos.x)
	posZ = Mathf.Clamp(posZ, FamilyScene.CameraLimitStartPos.z, FamilyScene.CameraLimitEndPos.z)

	Framework.TransformUtil.SetPos(mainCamera.transform, posX, posY, posZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, self._cameraEulerAngle.x, self._cameraEulerAngle.y, self._cameraEulerAngle.z)
end

return FamilySceneCamera
