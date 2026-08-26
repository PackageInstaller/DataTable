-- chunkname: @modules/logic/prototest/core/ProtoTestPreSender.lua

module("modules.logic.prototest.core.ProtoTestPreSender", package.seeall)

local ProtoTestPreSender = class("ProtoTestPreSender", BasePreSender)

function ProtoTestPreSender:ctor()
	return
end

function ProtoTestPreSender:preSendSysMsg(cmd, dataTable, socketId)
	return
end

function ProtoTestPreSender:preSendProto(cmd, proto, socketId)
	if not ProtoEnum.IgnoreCmdList[cmd] then
		local mo = ProtoTestCaseMO.New()

		mo:initFromProto(cmd, proto)
		ProtoTestCaseModel.instance:addAtLast(mo)
	end
end

return ProtoTestPreSender
