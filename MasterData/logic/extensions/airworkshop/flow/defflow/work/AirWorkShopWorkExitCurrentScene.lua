-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkExitCurrentScene.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkExitCurrentScene", package.seeall)

local M = class("AirWorkShopWorkExitCurrentScene", WorkBase)

function M:onEnter(context)
	SceneFace.instance:exitScene()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
