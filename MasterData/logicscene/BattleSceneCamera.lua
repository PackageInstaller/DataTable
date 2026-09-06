-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/BattleSceneCamera.lua

module("logicscene.scene.component.camera.BattleSceneCamera", package.seeall)

local BattleSceneCamera = class("BattleSceneCamera", SceneCameraBase)

BattleSceneCamera.cameraRotX = 16.654
BattleSceneCamera.cameraRotY = 0
BattleSceneCamera.cameraRotZ = 0
BattleSceneCamera.cameraPosX = 0
BattleSceneCamera.cameraPosY = 82
BattleSceneCamera.cameraPosZ = -228
BattleSceneCamera.cameraSkillRotX = 20
BattleSceneCamera.cameraSkillPosX = 0
BattleSceneCamera.cameraSkillPosY = 87.5
BattleSceneCamera.cameraSkillPosZ = -216.8

function BattleSceneCamera:ctor(scene)
	BattleSceneCamera.super.ctor(self, scene)
end

function BattleSceneCamera:_initCameraFollow()
	local mainCameraGO = self._mainCamera:getGO()
	local follower = Framework.CameraMmoFollow.Get(mainCameraGO)

	follower.enabled = false

	return follower
end

function BattleSceneCamera:setCameraParams(fov, dist, pitch, yaw)
	self:setFov(fov)
	self:setDist(dist)
	self:setPitch(pitch)
	self:setYaw(yaw)
end

function BattleSceneCamera:shake(lifeTime, magnitude, shakeMode, shakeMagnitudeDecreaseRate)
	if not self._shaker then
		return
	end

	shakeMode = shakeMode or Framework.ShakeMode.Sphere
	shakeMagnitudeDecreaseRate = shakeMagnitudeDecreaseRate or 0.1

	self._shaker:Shake(lifeTime, magnitude, shakeMode, shakeMagnitudeDecreaseRate)
end

function BattleSceneCamera:stopShake()
	if not self._shaker then
		return
	end

	self._shaker:Clear()
end

function BattleSceneCamera:onEnterSceneFinished()
	local groundCamera = GlobalModel.instance.groundCamera

	groundCamera.farClipPlane = 1200

	if BattleModel.instance.isEndlessBattle or BattleModel.instance.isSeniorArena or BattleModel.instance.Infinitefuture or BattleModel.instance.VillainPet or BattleModel.instance.HolyStripeCopyFight or BattleModel.instance.StarGodChallenge or BattleModel.instance.PeakTournamentFight or BattleModel.instance.StartGodStatuesWar then
		BattleSceneCamera.cameraPosX = BattleSceneCamera.cameraSkillPosX
		BattleSceneCamera.cameraPosY = BattleSceneCamera.cameraSkillPosY
		BattleSceneCamera.cameraPosZ = BattleSceneCamera.cameraSkillPosZ
		BattleSceneCamera.cameraRotX = BattleSceneCamera.cameraSkillRotX
	else
		BattleSceneCamera.cameraRotX = 16.654
		BattleSceneCamera.cameraPosX = 0
		BattleSceneCamera.cameraPosY = 82
		BattleSceneCamera.cameraPosZ = -228
	end

	local mainCamera = self._mainCamera:getCamera()

	mainCamera.farClipPlane = 1000
	mainCamera.orthographic = false
	mainCamera.fieldOfView = 15

	Framework.TransformUtil.SetPos(mainCamera.transform, BattleSceneCamera.cameraPosX, BattleSceneCamera.cameraPosY, BattleSceneCamera.cameraPosZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, BattleSceneCamera.cameraRotX, BattleSceneCamera.cameraRotY, BattleSceneCamera.cameraRotZ)

	local skillCamera = GlobalModel.instance.skillCamera
	local rawImage = goutil.findChild(skillCamera, "FADEBACKGROUND")

	skillCamera.gameObject:SetActive(true)

	skillCamera.farClipPlane = 1000
	skillCamera.orthographic = false
	skillCamera.fieldOfView = 15

	local _skillCameraGO = skillCamera.gameObject

	if _skillCameraGO then
		local _post = _skillCameraGO:GetComponent(typeof(UnityEngine.PostProcessing.PostProcessingBehaviour))

		if _post then
			_post.enabled = HardwareQuality.getBloomSwitch()
		end
	end

	rawImage:SetActive(false)
	Framework.TransformUtil.SetPos(skillCamera.transform, BattleSceneCamera.cameraPosX, BattleSceneCamera.cameraPosY, BattleSceneCamera.cameraPosZ)
	Framework.TransformUtil.SetLocalRotation(skillCamera.transform, BattleSceneCamera.cameraRotX, BattleSceneCamera.cameraRotY, BattleSceneCamera.cameraRotZ)
	GlobalModel.instance.skillUICamera.gameObject:SetActive(true)
end

function BattleSceneCamera:MirrorFlipCamera()
	GoUtil.MirrorFlipCamera(self._skillCamera)
end

function BattleSceneCamera:onExitScene()
	self._follower.enabled = false
end

function BattleSceneCamera:resetCamera()
	local mainCamera = self._mainCamera:getCamera()

	Framework.TransformUtil.SetPos(mainCamera.transform, BattleSceneCamera.cameraSkillPosX, BattleSceneCamera.cameraSkillPosY, BattleSceneCamera.cameraSkillPosZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, BattleSceneCamera.cameraSkillRotX, BattleSceneCamera.cameraRotY, BattleSceneCamera.cameraRotZ)
end

return BattleSceneCamera
