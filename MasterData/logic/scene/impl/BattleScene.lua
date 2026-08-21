-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/BattleScene.lua

module("logic.scene.impl.BattleScene", package.seeall)

local BattleScene = class("BattleScene", SceneBaseSpacx)

BattleScene.DynamicVisualObjectsName = "dynamic_visual_objects_trigger"
BattleScene.PerformancePositionName = "position_mirror"
BattleScene.BaseHeightMapProxyName = "^base_height_map_proxy"
BattleScene.WorldStreamerName = "WorldStreamer"
BattleScene.CharacterLightName = "character_directional_light"
BattleScene.HighImportanceLayerName = "high_importance"

function BattleScene:_initComponents()
	self:_addComponent("stage", BattleSceneStage)
	self:_addComponent("light", BattleSceneLight)
	self:_addComponent("camera", BattleSceneCamera)
	self:_addComponent("visualCulling", BattleSceneVisualCulling)
	self:_addComponent("audioMgr", BattleAudioMgr)
end

function BattleScene:getSceneType()
	return SceneType.Battle
end

return BattleScene
