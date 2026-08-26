-- chunkname: @modules/spine/roleeffect/DoorRoleEffect.lua

module("modules.spine.roleeffect.DoorRoleEffect", package.seeall)

local DoorRoleEffect = class("DoorRoleEffect", BaseSpineRoleEffect)

function DoorRoleEffect:init(roleEffectConfig)
	self._roleEffectConfig = roleEffectConfig
	self._spineGo = self._spine._spineGo

	local cameraGo = gohelper.findChild(self._spineGo, "mountroot/mountweapon/roleeffect_b_idle2/zhujue_camera")

	self._idle2Camera = cameraGo and cameraGo:GetComponent(typeof(UnityEngine.Camera))

	local effectPath = "mountroot/mountweapon"

	self._effectGo = gohelper.findChild(self._spineGo, effectPath)
	self._videoList = {}
end

function DoorRoleEffect:showBodyEffect(bodyName)
	self:_setIdle2CameraEnabled(false)
	self:_stopVideo()

	local transform = self._effectGo.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)
		local showEffect = child.name == "roleeffect_" .. bodyName

		gohelper.setActive(child.gameObject, showEffect)
		self:_playBodyEffect(showEffect, child, bodyName)
	end
end

function DoorRoleEffect:_playBodyEffect(showEffect, child, bodyName)
	if not showEffect then
		return
	end

	if bodyName == "b_idle2" then
		self:_setIdle2CameraEnabled(true)

		if self._spine:isInMainView() then
			self:_setLightEnvColor()

			return
		end
	end

	self:_playVideo(child, bodyName)
end

function DoorRoleEffect:_setIdle2CameraEnabled(value)
	if gohelper.isNil(self._idle2Camera) then
		return
	end

	self._idle2Camera.enabled = value
end

function DoorRoleEffect:_setLightEnvColor()
	local reportLightMode = WeatherController.instance.reportLightMode

	if not reportLightMode then
		return
	end

	local mat = self:_getLightMat()

	if not mat then
		return
	end

	local lightColor = WeatherEnum.DoorLightColor[reportLightMode]

	self._lightColor = self._lightColor or Color.New()
	self._lightColor.r = lightColor[1] / 255
	self._lightColor.g = lightColor[2] / 255
	self._lightColor.b = lightColor[3] / 255
	self._lightColor.a = lightColor[4] / 255

	MaterialUtil.setMainColor(mat, self._lightColor)
end

function DoorRoleEffect:_getLightMat()
	if self._material then
		return self._material
	end

	local effectPath = "mountroot/mountweapon/roleeffect_b_idle2/504301_banshen_light"
	local lightGo = gohelper.findChild(self._spine._spineGo, effectPath)
	local meshRenderer = lightGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	self._material = meshRenderer.sharedMaterial

	return self._material
end

function DoorRoleEffect:_playVideo(child, bodyName)
	local videoName = ""

	if bodyName == "b_idle4" then
		videoName = "door_idle4"
	elseif bodyName == "b_idle5" then
		videoName = "door_idle5"
	elseif bodyName == "b_biaoyan" then
		videoName = "door_idle6"
	elseif bodyName == "b_bowen" then
		videoName = "door_bowen"
	end

	if videoName == "" then
		return
	end

	local avProVideoPlayer = VideoPlayerMgr.instance:createVideoPlayer(child.gameObject)

	if avProVideoPlayer then
		local particleSystem = child:GetComponent(typeof(UnityEngine.ParticleSystem))

		particleSystem:Stop()
		avProVideoPlayer:setEventListener(self._videoStatusUpdate, self)
		gohelper.setActive(child.gameObject, true)
		avProVideoPlayer:loadMedia(videoName)

		local audioComp = child.gameObject:GetComponent(typeof(UnityEngine.AudioSource))

		if audioComp then
			audioComp.enabled = false
		end

		self._avProVideoPlayer = avProVideoPlayer
		self._particleSystem = particleSystem

		table.insert(self._videoList, avProVideoPlayer)
	end
end

function DoorRoleEffect:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FirstFrameReady or status == VideoEnum.PlayerStatus.ReadyToPlay then
		if self._avProVideoPlayer then
			self._avProVideoPlayer:playLoadMedia(true)
		end

		if self._particleSystem then
			self._particleSystem:Play()
		end
	end
end

function DoorRoleEffect:_stopVideo()
	if self._avProVideoPlayer then
		self._avProVideoPlayer = nil
		self._particleSystem = nil
	end
end

function DoorRoleEffect:_clearVideos()
	self:_setIdle2CameraEnabled(false)

	self._videoList = {}
	self._avProVideoPlayer = nil
	self._particleSystem = nil
	self._idle2Camera = nil
	self._spineGo = nil
end

function DoorRoleEffect:onDestroy()
	self:_clearVideos()
end

return DoorRoleEffect
