-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneResObjectCache.lua

module("logicscene.scene.component.mainplayer.SceneResObjectCache", package.seeall)

local SceneResObjectCache = class("SceneResObjectCache", SceneComponentBase)

function SceneResObjectCache:ctor(scene)
	SceneResObjectCache.super.ctor(self, scene)
	ResCache.instance:setPermanent("scene/misc/prefabs/foot_step_p.prefab", true)
end

function SceneResObjectCache:newObject(resPath, loadedHandler, handlerTarget)
	if not self._isReady then
		return
	end

	return ResCache.instance:newObject(resPath, loadedHandler, handlerTarget)
end

function SceneResObjectCache:recycleObject(handler)
	if self._isReady then
		ResCache.instance:recycleObject(handler)
	elseif not goutil.isNil(handler.go) then
		UnityEngine.GameObject.Destroy(handler.go)
	end
end

function SceneResObjectCache:onEnterScene(sceneId, bornX, bornZ)
	self._isReady = true
end

function SceneResObjectCache:onExitSceneFinished()
	self._isReady = nil

	ResCache.instance:releaseUnuseResources()
end

return SceneResObjectCache
