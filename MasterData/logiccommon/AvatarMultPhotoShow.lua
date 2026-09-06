-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatartool/AvatarMultPhotoShow.lua

module("logiccommon.common.avatar.new.avatartool.AvatarMultPhotoShow", package.seeall)

local AvatarMultPhotoShow = class("AvatarMultPhotoShow")

function AvatarMultPhotoShow:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._RTRawImg = self:getRTRawImg()

	self:resetRTRawImg()
	self:initCamParams()

	self._photo = Framework.PhotoBase.Add(self._go)

	self._photo:TurnOn()
end

function AvatarMultPhotoShow.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, AvatarMultPhotoShow)

	component = component or Framework.LuaComponentContainer.Add(go, AvatarMultPhotoShow)

	return component
end

function AvatarMultPhotoShow:getRTRawImg()
	self._RTRawImg = self._RTRawImg or self._go:GetComponent(typeof(UnityEngine.UI.RawImage)) or self._go:AddComponent(typeof(UnityEngine.UI.RawImage))

	return self._RTRawImg
end

function AvatarMultPhotoShow:resetRTRawImg()
	local rawImg = self:getRTRawImg()

	Game.ImageUtil.SetRawImageAlpha(rawImg, 0)
end

function AvatarMultPhotoShow:initRTCamParams()
	self._RTCamLocPos = {
		z = 0,
		x = 0,
		y = 0
	}
	self._RTCamLocRotate = {
		z = 0,
		x = 0,
		y = 0
	}
	self._RTCamSize = 3
	self._isRTCamOrthographic = true
end

function AvatarMultPhotoShow:setCameraPosition(x, y, z)
	self._RTCamLocPos = {
		x = x,
		y = y,
		z = z
	}

	self:resetCameraPosition()
end

function AvatarMultPhotoShow:resetCameraPosition()
	self._photo:setCameraPosition(self._RTCamLocPos.x, self._RTCamLocPos.y, self._RTCamLocPos.z)
end

function AvatarMultPhotoShow:setCameraRotation(x, y, z)
	self._RTCamLocRotate = {
		x = x,
		y = y,
		z = z
	}

	self:resetCameraRotation()
end

function AvatarMultPhotoShow:resetCameraRotation()
	self._photo:SetCameraRotation(self._RTCamLocRotate.x, self._RTCamLocRotate.y, self._RTCamLocRotate.z)
end

function AvatarMultPhotoShow:setCameraSize(size)
	self._RTCamSize = size

	self:resetCameraSize()
end

function AvatarMultPhotoShow:resetCameraSize()
	self._photo.producer.rtCamera.orthographicSize = self._RTCamSize
end

function AvatarMultPhotoShow:clear()
	self._photo:TurnOff()
	self:resetRTRawImg()
end

return AvatarMultPhotoShow
