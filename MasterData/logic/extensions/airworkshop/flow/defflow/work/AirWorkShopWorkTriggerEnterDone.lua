-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkTriggerEnterDone.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkTriggerEnterDone", package.seeall)

local M = class("AirWorkShopWorkTriggerEnterDone", WorkBase)

function M:onEnter(context)
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_ENTER_AIR_SCENE_FINISH)
	context:internal_NotifyComponent(AirWorkShopFunctionName.onEnterDone)
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
