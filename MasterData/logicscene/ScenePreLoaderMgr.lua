-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/ScenePreLoaderMgr.lua

module("logicscene.scene.transition.ScenePreLoaderMgr", package.seeall)

local ScenePreLoaderMgr = class("ScenePreLoaderMgr")

function ScenePreLoaderMgr:ctor()
	return
end

function ScenePreLoaderMgr:onEnterScene()
	self._currSceneId = nil
end

function ScenePreLoaderMgr:onEnterSceneFinished(scene)
	return
end

function ScenePreLoaderMgr:update(deltaTime)
	return
end

function ScenePreLoaderMgr:clearAll()
	return
end

function ScenePreLoaderMgr:disable(disable)
	return
end

function ScenePreLoaderMgr:clearExcept(sceneId)
	return
end

ScenePreLoaderMgr.instance = ScenePreLoaderMgr.New()

return ScenePreLoaderMgr
