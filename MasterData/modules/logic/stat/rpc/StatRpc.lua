-- chunkname: @modules/logic/stat/rpc/StatRpc.lua

module("modules.logic.stat.rpc.StatRpc", package.seeall)

local StatRpc = class("StatRpc", BaseRpc)

function StatRpc:sendClientStatBaseInfoRequest(info)
	local req = StatModule_pb.ClientStatBaseInfoRequest()

	req.info = info

	return self:sendMsg(req)
end

function StatRpc:onReceiveClientStatBaseInfoReply(resultCode, msg)
	return
end

function StatRpc:onReceiveStatInfoPush(resultCode, msg)
	if resultCode == 0 then
		StatModel.instance:setRoleType(msg.userTag)

		if string.nilorempty(msg.userTag) == false then
			SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
		end
	end
end

StatRpc.instance = StatRpc.New()

return StatRpc
