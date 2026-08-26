-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/map/scene/VersionActivity3_5DungeonMapScene.lua

module("modules.logic.versionactivity3_5.dungeon.view.map.scene.VersionActivity3_5DungeonMapScene", package.seeall)

local VersionActivity3_5DungeonMapScene = class("VersionActivity3_5DungeonMapScene", VersionActivityFixedDungeonMapScene)

function VersionActivity3_5DungeonMapScene:addEvents()
	VersionActivity3_5DungeonMapScene.super.addEvents(self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_5DungeonEvent.V3a2CameraSizeChange, self._onCameraSizeChange, self)
end

function VersionActivity3_5DungeonMapScene:_editableInitView()
	VersionActivity3_5DungeonMapScene.super._editableInitView(self)

	self._tempTargetPos = Vector2()
end

function VersionActivity3_5DungeonMapScene:_onCameraSizeChange()
	if self._sceneGo and self._scenePos then
		self:_initScene()
		self:directSetScenePos(self._scenePos)
	end
end

function VersionActivity3_5DungeonMapScene:_onDragBegin(param, pointerEventData)
	VersionActivity3_5DungeonMapScene.super._onDragBegin(self, param, pointerEventData)
	VersionActivity3_5DungeonLogicController.instance:setDragFrameBegin()
end

function VersionActivity3_5DungeonMapScene:_onDragEnd(param, pointerEventData)
	VersionActivity3_5DungeonMapScene.super._onDragEnd(self, param, pointerEventData)
	VersionActivity3_5DungeonLogicController.instance:setDragFrameEnd()
end

function VersionActivity3_5DungeonMapScene:tweenSetScenePos(targetPos, srcPos)
	self._tempTargetPos.x = targetPos.x
	self._tempTargetPos.y = targetPos.y
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(targetPos)
	self._tweenStartPosX, self._tweenStartPosY = self:getTargetPos(srcPos or self._scenePos)

	self:killTween()

	local time = DungeonEnum.DefaultTweenMapTime

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function VersionActivity3_5DungeonMapScene:tweenFrameCallback(value)
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(self._tempTargetPos)

	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self._tempVector:Set(x, y, 0)
	self:directSetScenePos(self._tempVector)
end

return VersionActivity3_5DungeonMapScene
