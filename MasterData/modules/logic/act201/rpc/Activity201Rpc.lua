-- chunkname: @modules/logic/act201/rpc/Activity201Rpc.lua

module("modules.logic.act201.rpc.Activity201Rpc", package.seeall)

local Activity201Rpc = class("Activity201Rpc", BaseRpc)

function Activity201Rpc:sendGet201InfoRequest(activityId, callBack, callBackObj)
	local req = Activity201Module_pb.Get201InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callBack, callBackObj)
end

function Activity201Rpc:onReceiveGet201InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity201Model.instance:setActivityInfo(msg)
		Activity201Controller.instance:dispatchEvent(Activity201Event.OnGetInfoSuccess)
	end
end

Activity201Rpc.instance = Activity201Rpc.New()

return Activity201Rpc
