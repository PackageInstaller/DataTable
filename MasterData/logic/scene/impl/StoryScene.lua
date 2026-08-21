-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/StoryScene.lua

module("logic.scene.impl.StoryScene", package.seeall)

local M = class("StoryScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", StorySceneStage)
end

function M:getSceneType()
	return SceneType.Story
end

return M
