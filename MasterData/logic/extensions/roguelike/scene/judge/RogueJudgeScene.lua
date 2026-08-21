-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/judge/RogueJudgeScene.lua

module("logic.extensions.roguelike.scene.judge.RogueJudgeScene", package.seeall)

local M = class("RogueJudgeScene", SceneBase)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("stage", RogueJudgeSceneStage)
	self:_addComponent("camera", SceneCamera)
end

function M:getSceneType()
	return SceneType.RunGroupMap
end

return M
