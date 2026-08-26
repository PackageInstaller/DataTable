-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/scene/VersionActivityFixedDungeonMapScene1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.scene.VersionActivityFixedDungeonMapScene1", package.seeall)

local VersionActivityFixedDungeonMapScene1 = class("VersionActivityFixedDungeonMapScene1", VersionActivityFixedDungeonMapScene)

function VersionActivityFixedDungeonMapScene1:addEvents()
	VersionActivityFixedDungeonMapScene1.super.addEvents(self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent1.CameraSizeChange, self._onCameraSizeChange, self)
end

function VersionActivityFixedDungeonMapScene1:_editableInitView()
	VersionActivityFixedDungeonMapScene1.super._editableInitView(self)

	self._tempTargetPos = Vector2()
end

function VersionActivityFixedDungeonMapScene1:_onCameraSizeChange()
	if self._sceneGo and self._scenePos then
		self:_initScene()
		self:directSetScenePos(self._scenePos)
	end
end

function VersionActivityFixedDungeonMapScene1:_onDragBegin(param, pointerEventData)
	VersionActivityFixedDungeonMapScene1.super._onDragBegin(self, param, pointerEventData)
	VersionActivityFixedDungeonLogicController1.instance:setDragFrameBegin()
end

function VersionActivityFixedDungeonMapScene1:_onDragEnd(param, pointerEventData)
	VersionActivityFixedDungeonMapScene1.super._onDragEnd(self, param, pointerEventData)
	VersionActivityFixedDungeonLogicController1.instance:setDragFrameEnd()
end

function VersionActivityFixedDungeonMapScene1:tweenSetScenePos(targetPos, srcPos)
	self._tempTargetPos.x = targetPos.x
	self._tempTargetPos.y = targetPos.y
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(targetPos)
	self._tweenStartPosX, self._tweenStartPosY = self:getTargetPos(srcPos or self._scenePos)

	self:killTween()

	local time = DungeonEnum.DefaultTweenMapTime

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function VersionActivityFixedDungeonMapScene1:tweenFrameCallback(value)
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(self._tempTargetPos)

	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self._tempVector:Set(x, y, 0)
	self:directSetScenePos(self._tempVector)
end

return VersionActivityFixedDungeonMapScene1
