-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/scene/AirWorkShopSceneLight.lua

module("logic.extensions.airworkshop.flow.defflow.scene.AirWorkShopSceneLight", package.seeall)

local M = class("AirWorkShopSceneLight", SceneComponentBase)

function M:onInit()
	self._goSceneMainCharacterLight = false
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	local stage = self._scene.stage

	self._goSceneMainCharacterLight = GameObjectUtils.FindChildRecursivelyBySceneName(stage:getSceneName(), 5, BattleScene.CharacterLightName)
end

function M:onExitScene()
	self._goSceneMainCharacterLight = false
end

function M:onLeaveScene()
	self:onExitScene()
end

function M:onReturnScene()
	self:onEnterScene()
end

return M
