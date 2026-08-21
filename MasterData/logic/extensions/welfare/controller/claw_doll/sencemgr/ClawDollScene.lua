-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollScene.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollScene", package.seeall)

local M = class("ClawDollScene", SceneBaseSpacx)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("stage", ClawDollSceneStage)
	self:_addComponent("camera", SceneCamera)
end

function M:getSceneType()
	return SceneType.ClawDoll
end

return M
