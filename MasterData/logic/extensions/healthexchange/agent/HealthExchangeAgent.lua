-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/agent/HealthExchangeAgent.lua

module("logic.extensions.healthexchange.agent.HealthExchangeAgent", package.seeall)

local M = class("HealthExchangeAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:sendUseEnergyItemsRequest(sendStr)
	local req = PlayerExtension_pb.UseEnergyItemsRequest()

	req.useItems = sendStr

	self:sendMsg(req)
end

function M:handleUseEnergyItemsReply(status, msg)
	GlobalDispatcher:dispatchEvent(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE)
end

M.instance = M.New()

return M
