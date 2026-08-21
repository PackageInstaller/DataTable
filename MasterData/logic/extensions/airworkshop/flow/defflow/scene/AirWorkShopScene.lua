-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/scene/AirWorkShopScene.lua

module("logic.extensions.airworkshop.flow.defflow.scene.AirWorkShopScene", package.seeall)

local M = class("AirWorkShopScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", AirWorkShopSceneStage)
	self:_addComponent("light", AirWorkShopSceneLight)
	self:_addComponent("camera", AirWorkShopSceneCamera)
	self:_addComponent("visualCulling", AirWorkShopSceneVisualCulling)
end

function M:getSceneType()
	return SceneType.AirWorkShop
end

return M
