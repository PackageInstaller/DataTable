-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/scene/BattleCalculateEditorScene.lua

module("logic.extensions.battlecalculateeditor.scene.BattleCalculateEditorScene", package.seeall)

local BattleCalculateEditorScene = class("BattleCalculateEditorScene", SceneBaseSpacx)

BattleCalculateEditorScene.CharacterLightName = "character_directional_light"

function BattleCalculateEditorScene:_initComponents()
	self:_addComponent("stage", BattleCalculateEditorSceneStage)
	self:_addComponent("light", BattleSceneLight)
	self:_addComponent("camera", BattleCalculateEditorSceneCamera)
	self:_addComponent("visualCulling", BattleSceneVisualCulling)
end

function BattleCalculateEditorScene:getSceneType()
	return SceneType.BattleCalculateEditor
end

return BattleCalculateEditorScene
