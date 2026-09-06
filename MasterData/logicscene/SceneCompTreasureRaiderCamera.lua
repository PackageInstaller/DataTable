-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderCamera.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderCamera", package.seeall)

local SceneCompTreasureRaiderCamera = class("SceneCompTreasureRaiderCamera", SceneCompSeasonCamera)

function SceneCompTreasureRaiderCamera:ctor(scene)
	SceneCompTreasureRaiderCamera.super.ctor(self, scene)

	self._dragEnabled = true
end

function SceneCompTreasureRaiderCamera:setDragEnabled(value)
	self._dragEnabled = value

	self:_onTouchUp()
end

function SceneCompTreasureRaiderCamera:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderCamera.super.onEnterScene(self, sceneId, bornX, bornZ)
end

function SceneCompTreasureRaiderCamera:onExitScene()
	SceneCompTreasureRaiderCamera.super.onExitScene(self)
end

function SceneCompTreasureRaiderCamera:update(deltaTime)
	if self._scene.animation and self._scene.animation:isPlaying() then
		return
	end

	SceneCompTreasureRaiderCamera.super.update(self, deltaTime)
end

function SceneCompTreasureRaiderCamera:updateCameraParams()
	SceneCompTreasureRaiderCamera.super.updateCameraParams(self)

	local mainCam = self._mainCamera:getCamera()

	mainCam.orthographicSize = 4.8

	local stage = self._scene.stage
	local minX, minY, maxX, maxY = stage.wholeScene:GetCameraRange(nil, nil, nil, nil)

	self._cameraOringinRanges = {
		minX,
		minY,
		maxX,
		maxY
	}

	local camSizeH = mainCam.orthographicSize * 2
	local camSizeW = mainCam.aspect * camSizeH

	self._cameraRanges[1] = self._cameraOringinRanges[1] + camSizeW * 0.2
	self._cameraRanges[2] = self._cameraOringinRanges[2] + camSizeH * 0.4
	self._cameraRanges[3] = self._cameraOringinRanges[3] - camSizeW * 0.2
	self._cameraRanges[4] = self._cameraOringinRanges[4] - camSizeH * 0.4
end

function SceneCompTreasureRaiderCamera:isDragEnabled()
	return self._dragEnabled
end

return SceneCompTreasureRaiderCamera
