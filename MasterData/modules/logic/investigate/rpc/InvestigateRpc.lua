-- chunkname: @modules/logic/investigate/rpc/InvestigateRpc.lua

module("modules.logic.investigate.rpc.InvestigateRpc", package.seeall)

local InvestigateRpc = class("InvestigateRpc", BaseRpc)

function InvestigateRpc:sendGetInvestigateRequest()
	local req = InvestigateModule_pb.GetInvestigateRequest()

	self:sendMsg(req)
end

function InvestigateRpc:onReceiveGetInvestigateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	InvestigateOpinionModel.instance:initOpinionInfo(info)
end

function InvestigateRpc:sendPutClueRequest(id, clueId)
	local req = InvestigateModule_pb.PutClueRequest()

	req.id = id
	req.clueId = clueId

	self:sendMsg(req)
end

function InvestigateRpc:onReceivePutClueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local clueId = msg.clueId

	InvestigateOpinionModel.instance:setLinkedStatus(clueId, true)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.LinkedOpinionSuccess, clueId)
end

function InvestigateRpc:onReceiveInvestigateInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	InvestigateOpinionModel.instance:initOpinionInfo(info)
end

InvestigateRpc.instance = InvestigateRpc.New()

return InvestigateRpc
