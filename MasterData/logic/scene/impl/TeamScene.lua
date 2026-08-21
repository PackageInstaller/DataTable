-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/TeamScene.lua

module("logic.scene.impl.TeamScene", package.seeall)

local M = class("TeamScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", TeamSceneStage)
	self:_addComponent("camera", SceneCamera)
	self:_addComponent("light", SceneLight)
	self:_addComponent("unitFactory", UnitFactory)
end

function M:getSceneType()
	return SceneType.Team
end

return M
