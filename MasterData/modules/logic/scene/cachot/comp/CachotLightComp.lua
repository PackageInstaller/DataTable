-- chunkname: @modules/logic/scene/cachot/comp/CachotLightComp.lua

module("modules.logic.scene.cachot.comp.CachotLightComp", package.seeall)

local CachotLightComp = class("CachotLightComp", BaseSceneComp)

function CachotLightComp:onScenePrepared(sceneId, levelId)
	self._scene = self:getCurScene()
	self._preloadComp = self._scene.preloader
	self._lightGo = gohelper.create3d(self._scene:getSceneContainerGO(), "Light")

	local go = self._preloadComp:getResInst(CachotScenePreloader.LightPath, self._lightGo)

	self._lightAnim = go:GetComponent(typeof(UnityEngine.Animator))

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, self._playClickAnim, self)
end

function CachotLightComp:_playClickAnim()
	self._lightAnim:Play("open", 0, 0)
end

function CachotLightComp:onSceneClose()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, self._playClickAnim, self)

	if self._lightGo then
		gohelper.destroy(self._lightGo)

		self._lightGo = nil
	end

	self._preloadComp = nil
	self._scene = nil
	self._lightAnim = nil
end

return CachotLightComp
