-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionWaitSceneLoaded.lua

module("logicscene.scene.unit.action.UnitActionWaitSceneLoaded", package.seeall)

local UnitActionWaitSceneLoaded = class("UnitActionWaitSceneLoaded", UnitActionBase)

function UnitActionWaitSceneLoaded:ctor(sceneId)
	UnitActionWaitSceneLoaded.super.ctor(self)

	self._sceneId = sceneId
end

function UnitActionWaitSceneLoaded:update(deltaTime)
	return
end

function UnitActionWaitSceneLoaded:isDone()
	local scene = SceneMgr.instance:getCurScene()

	return scene:getSceneId() == self._sceneId and scene.isReady
end

return UnitActionWaitSceneLoaded
