-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/TilingElemsMgr.lua

module("logicscene.scene.component.mainplayer.TilingElemsMgr", package.seeall)

local TilingElemsMgr = class("TilingElemsMgr", SceneComponentBase)

function TilingElemsMgr:ctor(scene)
	TilingElemsMgr.super.ctor(self, scene)

	self._isReady = nil
end

function TilingElemsMgr:onEnterScene(sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.TilingElemDelete, self._onTilingElemDelete, self)
	GlobalDispatcher:addListener(GlobalNotify.TilingElemCreate, self._onTilingElemCreate, self)
end

function TilingElemsMgr:onEnterSceneFinished()
	self._isReady = true

	self:_createAllElements()
end

function TilingElemsMgr:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.TilingElemCreate, self._onTilingElemCreate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TilingElemDelete, self._onTilingElemDelete, self)

	self._isReady = nil
end

function TilingElemsMgr:isReady()
	return self._isReady
end

function TilingElemsMgr:_createAllElements()
	local sceneConfig = TilingSceneMgr.instance:getTilingSceneConfig(self._scene:getSceneId())

	if not sceneConfig or not sceneConfig.elements then
		return
	end

	for i = 1, #sceneConfig.elements do
		self._scene.unitFactory:createTilingElem(sceneConfig.elements[i])
	end
end

function TilingElemsMgr:_onTilingElemDelete(elemData)
	return
end

function TilingElemsMgr:_onTilingElemCreate(elemData)
	if self._isReady then
		self._scene.unitFactory:createTilingElem(elemData)
	end
end

return TilingElemsMgr
