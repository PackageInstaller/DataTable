-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/ProfilerScene.lua

module("logic.scene.impl.ProfilerScene", package.seeall)

local M = class("ProfilerScene", SceneBase)

function M:_initComponents()
	self:_addComponent("stage", ProfilerSceneStage)
end

function M:getSceneType()
	return SceneType.Profiler
end

return M
