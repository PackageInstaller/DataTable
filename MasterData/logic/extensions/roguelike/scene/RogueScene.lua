-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueScene.lua

module("logic.extensions.roguelike.scene.RogueScene", package.seeall)

local M = class("RogueScene", SceneBaseSpacx)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("stage", RogueSceneStage)
	self:_addComponent("camera", SceneCamera)
	self:_addComponent("light", RogueSceneLight)
	self:_addComponent("music", RogueSceneMusic)
end

function M:getSceneType()
	return SceneType.RunGroup
end

return M
