-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapSceneElements.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapSceneElements", package.seeall)

local VersionActivity2_9DungeonMapSceneElements = class("VersionActivity2_9DungeonMapSceneElements", VersionActivityFixedDungeonMapSceneElements)

function VersionActivity2_9DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = gohelper.findChild(self._sceneGo, "elementRoot")

	if gohelper.isNil(self._elementRoot) then
		self._elementRoot = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(self._sceneGo, self._elementRoot)
	end
end

function VersionActivity2_9DungeonMapSceneElements:addEvents()
	VersionActivity2_9DungeonMapSceneElements.super.addEvents(self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnTweenEpisodeListVisible, self._onTweenEpisodeListVisible, self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnEpisodeListVisibleDone, self._onEpisodeListVisibleDone, self)
end

function VersionActivity2_9DungeonMapSceneElements:isMouseDownElement()
	return self.mouseDownElement ~= nil
end

function VersionActivity2_9DungeonMapSceneElements:_updateArrow(elementComp)
	local arrowItem = self._arrowList[elementComp:getElementId()]

	if not arrowItem then
		return
	end

	local isShowArrow = elementComp:isConfigShowArrow()

	if not isShowArrow then
		gohelper.setActive(arrowItem.go, false)

		return
	end

	local t = elementComp._transform
	local camera = CameraMgr.instance:getMainCamera()
	local pos = camera:WorldToViewportPoint(t.position)

	if pos.z < 0 then
		pos.x = 1 - pos.x
		pos.y = 1 - pos.y
	end

	local x = pos.x
	local y = pos.y
	local isShowElement = x >= 0 and x <= 1 and y >= 0 and y <= 1

	gohelper.setActive(arrowItem.go, not isShowElement)

	if isShowElement then
		return
	end

	local viewportX = math.max(0.02, math.min(x, 0.98))
	local viewportY = math.max(0.035, math.min(y, 0.965))
	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (viewportX - 0.5), height * (viewportY - 0.5))

	local initRotation = arrowItem.initRotation

	if x >= 0 and x <= 1 then
		if y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 180)

			return
		elseif y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 0)

			return
		end
	end

	if y >= 0 and y <= 1 then
		if x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 270)

			return
		elseif x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 90)

			return
		end
	end

	local angle = 90 - Mathf.Atan2(y, x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], angle)
end

function VersionActivity2_9DungeonMapSceneElements:_showElementAnim(animElements, normalElements)
	VersionActivity2_9DungeonMapSceneElements.super._showElementAnim(self, animElements, normalElements)

	if not animElements or #animElements <= 0 then
		self:_dispatchNewElementsFocusDoneEvent()

		return
	end

	if self._showSequence then
		self._showSequence:addWork(FunctionWork.New(self._dispatchNewElementsFocusDoneEvent, self))
	end
end

function VersionActivity2_9DungeonMapSceneElements:_dispatchNewElementsFocusDoneEvent()
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnNewElementsFocusDone)
end

function VersionActivity2_9DungeonMapSceneElements:_onTweenEpisodeListVisible()
	gohelper.setActive(self._goarrow, false)
end

function VersionActivity2_9DungeonMapSceneElements:_onEpisodeListVisibleDone(isVisible)
	gohelper.setActive(self._goarrow, isVisible)
end

return VersionActivity2_9DungeonMapSceneElements
