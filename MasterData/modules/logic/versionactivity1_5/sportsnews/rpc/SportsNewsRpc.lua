-- chunkname: @modules/logic/versionactivity1_5/sportsnews/rpc/SportsNewsRpc.lua

module("modules.logic.versionactivity1_5.sportsnews.rpc.SportsNewsRpc", package.seeall)

local SportsNewsRpc = class("SportsNewsRpc", BaseRpc)

function SportsNewsRpc:sendFinishReadTaskRequest(actId, orderId)
	return TaskRpc.instance:sendFinishReadTaskRequest(orderId)
end

SportsNewsRpc.instance = SportsNewsRpc.New()

return SportsNewsRpc
