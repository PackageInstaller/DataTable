-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonCamera.lua

module("logicscene.scene.component.season.SceneCompSeasonCamera", package.seeall)

local SceneCompSeasonCamera = class("SceneCompSeasonCamera", CitySceneCameraEx)
local scale = 0.01

function SceneCompSeasonCamera:_onMainUnitPosChanged(x, y, z, isSetPosDirectly)
	if self._enableFollow then
		self:setPosFocus(x, y, z)
	end
end

function SceneCompSeasonCamera:onEnterSceneFinished(sceneId, bornX, bornZ)
	SceneCompSeasonCamera.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function SceneCompSeasonCamera:onExitScene()
	SceneCompSeasonCamera.super.onExitScene(self)
end

function SceneCompSeasonCamera:update(deltaTime)
	if self._scene.eventsAnimation and self._scene.eventsAnimation:isPlaying() then
		return
	end

	if not self._isTouchedDown then
		if UGUIToolHelper.IsTouchDown() and not UGUIToolHelper.IsOverUI() then
			self:_onTouchDown()
		end
	elseif UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	else
		self._touchTime = (self._touchTime or 0) + deltaTime

		self:_onTouchMove()
	end
end

function SceneCompSeasonCamera:_onTouchDown()
	self._isTouchedDown = true
	self._touchTime = 0
	self._touchDownPos = UGUIToolHelper.GetTouchPosition()
end

function SceneCompSeasonCamera:_onTouchMove()
	local mousePos = UGUIToolHelper.GetTouchPosition()
	local a, b = GameUtil.checkVector2(mousePos), GameUtil.checkVector2(self._touchDownPos)
	local directionX, directionY = b.x - a.x, b.y - a.y

	self._touchDownPos = mousePos

	if self._touchTime < 0.1 then
		return
	end

	directionX = directionX * scale
	directionY = directionY * scale

	self:enablFollowTarget(false)
	self:setPosFocusMovement(directionX, directionY)
end

function SceneCompSeasonCamera:_onTouchUp()
	self._isTouchedDown = nil
	self._touchDownPos = nil
	self._touchTime = 0
end

return SceneCompSeasonCamera
