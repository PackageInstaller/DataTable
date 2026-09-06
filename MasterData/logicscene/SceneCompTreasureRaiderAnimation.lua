-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderAnimation.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderAnimation", package.seeall)

local SceneCompTreasureRaiderAnimation = class("SceneCompTreasureRaiderAnimation", SceneComponentBase)

SceneCompTreasureRaiderAnimation.ZoomIn = 1
SceneCompTreasureRaiderAnimation.ZoomOut = 2

local ZoomUrls = {
	[SceneCompTreasureRaiderAnimation.ZoomIn] = "storyconfig/animations/treasureraider/treasureraider_camera_zoomin.txt",
	[SceneCompTreasureRaiderAnimation.ZoomOut] = "storyconfig/animations/treasureraider/treasureraider_camera_zoomout.txt"
}

function SceneCompTreasureRaiderAnimation:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderAnimation.super.onEnterScene(self, sceneId, bornX, bornZ)

	self._cameraZoomPlayer = TreasureRaiderSceneAnimatorPlayer.New(self._scene)
	self._zoomType = SceneCompTreasureRaiderAnimation.ZoomOut
end

function SceneCompTreasureRaiderAnimation:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompTreasureRaiderAnimation:onExitScene()
	self._zoomType = SceneCompTreasureRaiderAnimation.ZoomOut

	if self._cameraZoomPlayer then
		self._cameraZoomPlayer:clear()

		self._cameraZoomPlayer = nil
	end

	self:_destroyTempObject()
end

function SceneCompTreasureRaiderAnimation:getZoomType()
	return self._zoomType
end

function SceneCompTreasureRaiderAnimation:isPlaying()
	if self._cameraZoomPlayer and self._cameraZoomPlayer:isPlayingAnim() then
		return true
	end
end

function SceneCompTreasureRaiderAnimation:playCameraZoom(x, y, type, callback)
	if not self._cameraZoomPlayer then
		return
	end

	if self._zoomType == type then
		return
	end

	self._zoomType = type

	self._cameraZoomPlayer:stop()
	self:_createTempObject()

	local mainCam = GlobalModel.instance.mainCamera.gameObject

	Framework.TransformUtil.SetPos(self._tempGameObj.transform, x, y, 0)

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {
			mainCam,
			self._tempGameObj
		}
		local url = ZoomUrls[type]

		self._cameraZoomPlayer:playWithTargets(url, targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)

			if callback then
				callback()
			end
		end)
	end

	self._cameraZoomPlayer:preloadResources(x, y, nil, do_playAnim)
end

function SceneCompTreasureRaiderAnimation:_createTempObject()
	if not self._tempGameObj then
		self._tempGameObj = goutil.create("Treasure Raider Anim Temp")

		self._tempGameObj:SetActive(false)
	end
end

function SceneCompTreasureRaiderAnimation:_destroyTempObject()
	if self._tempGameObj then
		goutil.destroy(self._tempGameObj)

		self._tempGameObj = nil
	end
end

return SceneCompTreasureRaiderAnimation
