-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionGotoScene.lua

module("logicscene.scene.unit.action.UnitActionGotoScene", package.seeall)

local UnitActionGotoScene = class("UnitActionGotoScene", UnitActionPathTo)

function UnitActionGotoScene:ctor(sceneId)
	UnitActionGotoScene.super.ctor(self)

	self._sceneId = sceneId
	self._isDone = nil
end

function UnitActionGotoScene:start(unit)
	self._unit = unit

	self:_findDest()

	if self._isDone then
		self._elapsed = 0
		self._duration = 0
		self.isRunning = true

		return
	end

	UnitActionGotoScene.super.start(self, unit)
end

function UnitActionGotoScene:update(deltaTime)
	if self._isDone then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneId() == self._sceneId then
		return
	end

	if self._unit and self._unit.transmitPoint == self._sceneId then
		return
	end

	UnitActionGotoScene.super.update(self, deltaTime)
end

function UnitActionGotoScene:isDone()
	if self._isDone then
		return true
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneId() == self._sceneId then
		return true
	end

	if self._unit and self._unit.transmitPoint == self._sceneId then
		return true
	end

	return UnitActionGotoScene.super.isDone(self)
end

function UnitActionGotoScene:_findDest()
	self._isDone = nil

	local scene = SceneMgr.instance:getCurScene()
	local hasTrans, destX, destY = scene:getTransmitPoint(self._sceneId, nil, nil)

	if not hasTrans then
		self._isDone = true
		self._unit.transmitPoint = self._sceneId

		GlobalFacade.instance:enterCity(self._sceneId, scene:getSceneId())
	else
		self._destX = destX
		self._destY = destY
	end
end

return UnitActionGotoScene
