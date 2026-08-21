-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueSceneLight.lua

module("logic.extensions.roguelike.scene.RogueSceneLight", package.seeall)

local M = class("RogueSceneLight", SceneComponentBase)

function M:onInit()
	self._characterLight = false
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:activeNormalLight()
end

function M:onExitScene()
	LightMgr.instance:releaseTemporaryLight(self._characterLight)

	self._characterLight = false
end

function M:activeNormalLight()
	self:_activeLightCode(6)
end

function M:getCharacterLight()
	return self._characterLight
end

function M:_activeLightCode(lightCode)
	if self._characterLight then
		LightMgr.instance:releaseTemporaryLight(self._characterLight)

		self._characterLight = false
	end

	local goMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getGO()
	local light = LightMgr.instance:getTemporaryLight(lightCode)

	goutil.addChildToParent(light.mainGO, goMainCamera)

	self._characterLight = light
end

return M
