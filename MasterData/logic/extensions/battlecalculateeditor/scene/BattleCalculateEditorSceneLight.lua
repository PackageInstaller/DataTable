-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/scene/BattleCalculateEditorSceneLight.lua

module("logic.extensions.battlecalculateeditor.scene.BattleCalculateEditorSceneLight", package.seeall)

local M = class("BattleCalculateEditorSceneLight", SceneComponentBase)

function M:onInit()
	self._goAdditionSceneCharacterLight = false
	self._goActiveCharacterLight = false
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	local stage = self._scene.stage

	self._goAdditionSceneCharacterLight = GameObjectUtils.FindChildRecursivelyBySceneName(stage:getSceneName(), 5, BattleScene.CharacterLightName)

	self:activePerformanceLight()
end

function M:onExitScene()
	self._goAdditionSceneCharacterLight = false
	self._goActiveCharacterLight = false
end

function M:onLeaveScene()
	self:onExitScene()
end

function M:onReturnScene()
	self:onEnterScene()
end

function M:activePerformanceLight()
	self._goActiveCharacterLight = self._goAdditionSceneCharacterLight
end

function M:getCharacterLightGameObject()
	return self._goActiveCharacterLight
end

function M:getAdditionLightGameObject()
	return self._goAdditionSceneCharacterLight
end

return M
