-- chunkname: @modules/logic/room/view/mgr/OrthCameraRTMgr.lua

module("modules.logic.room.view.mgr.OrthCameraRTMgr", package.seeall)

local OrthCameraRTMgr = class("OrthCameraRTMgr")

function OrthCameraRTMgr:ctor()
	self._rtIndex = 0
end

function OrthCameraRTMgr:initRT()
	if self._renderTexture then
		return
	end

	local orthCamera = CameraMgr.instance:getOrthCamera()

	if not orthCamera then
		return
	end

	self._orthCamera = orthCamera
	self._renderTexture = UnityEngine.RenderTexture.GetTemporary(768, 512, 0, UnityEngine.RenderTextureFormat.ARGB32)
	self._originalTargetTexture = self._orthCamera.targetTexture
	self._orthographicSize = self._orthCamera.orthographicSize
	self._orthCamera.targetTexture = self._renderTexture
	self._orthCamera.orthographicSize = 2
	self._uvRects = {}

	for i = 1, 24 do
		local tIndex = i - 1
		local sx = math.floor(tIndex % 6)
		local sy = math.floor(tIndex / 6)
		local uv = UnityEngine.Rect.New(sx * 128 / 768, sy * 168 / 512, 0.16666666666666666, 0.328125)

		table.insert(self._uvRects, uv)
	end

	self._rtIndex = self._rtIndex or 0
end

function OrthCameraRTMgr:getNewIndex()
	self._rtIndex = self._rtIndex + 1

	return self._rtIndex
end

function OrthCameraRTMgr:setRawImageUvRect(image, index)
	if not self._renderTexture then
		return nil
	end

	image.texture = self._renderTexture
	image.uvRect = self._uvRects[index] or UnityEngine.Rect.New(0, 0, 1, 1)
end

function OrthCameraRTMgr:destroyRT()
	if self._orthCamera then
		self._orthCamera.targetTexture = self._originalTargetTexture
		self._orthCamera.orthographicSize = self._orthographicSize
		self._orthCamera = nil
		self._originalTargetTexture = nil
	end

	if self._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._renderTexture)

		self._renderTexture = nil
		self._moreSprite = nil
		self._sprites = nil
		self._rtIndex = 0
	end
end

OrthCameraRTMgr.instance = OrthCameraRTMgr.New()

return OrthCameraRTMgr
