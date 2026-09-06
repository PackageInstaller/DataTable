-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/DomainAdventureSceneCamera.lua

module("logicscene.scene.component.camera.DomainAdventureSceneCamera", package.seeall)

local DomainAdventureSceneCamera = class("DomainAdventureSceneCamera", CitySceneCameraEx)
local scale = 0.01

function DomainAdventureSceneCamera:ctor(scene)
	DomainAdventureSceneCamera.super.ctor(self, scene)

	self._screenCenter = Vector3.New(UnityEngine.Screen.width / 2, UnityEngine.Screen.height / 2, self._mainCamera.nearClipPlane)
end

function DomainAdventureSceneCamera:_onMainUnitPosChanged(x, y, z, isSetPosDirectly)
	if self._enableFollow then
		self:setPosFocus(x, y, z)
	end
end

function DomainAdventureSceneCamera:onEnterSceneFinished(sceneId, bornX, bornZ)
	DomainAdventureSceneCamera.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function DomainAdventureSceneCamera:onExitScene()
	DomainAdventureSceneCamera.super.onExitScene(self)
end

function DomainAdventureSceneCamera:update(deltaTime)
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

function DomainAdventureSceneCamera:_onTouchDown()
	self._isTouchedDown = true
	self._touchTime = 0
	self._touchDownPos = UGUIToolHelper.GetTouchPosition()
end

function DomainAdventureSceneCamera:_onTouchMove()
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

function DomainAdventureSceneCamera:_onTouchUp()
	self._isTouchedDown = nil
	self._touchDownPos = nil
	self._touchTime = 0
end

function DomainAdventureSceneCamera:getScreenCenterWorldPosition()
	return self._mainCamera:getCamera():ScreenToWorldPoint(self._screenCenter)
end

return DomainAdventureSceneCamera
