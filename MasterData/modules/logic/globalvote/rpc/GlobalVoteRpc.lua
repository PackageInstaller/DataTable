-- chunkname: @modules/logic/globalvote/rpc/GlobalVoteRpc.lua

module("modules.logic.globalvote.rpc.GlobalVoteRpc", package.seeall)

local GlobalVoteRpc = class("GlobalVoteRpc", BaseRpc)

function GlobalVoteRpc:sendGlobalVoteGetInfo(voteId, callback, callobj)
	local req = GlobalVoteModule_pb.GlobalVoteGetInfoRequest()

	req.voteId = voteId

	return self:sendMsg(req, callback, callobj)
end

function GlobalVoteRpc:onReceiveGlobalVoteGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		GlobalVoteModel.instance:onReceiveGlobalVoteGetInfoReply(msg)
		GlobalVoteController.instance:dispatchEvent(GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply, msg)
	end
end

GlobalVoteRpc.instance = GlobalVoteRpc.New()

return GlobalVoteRpc
