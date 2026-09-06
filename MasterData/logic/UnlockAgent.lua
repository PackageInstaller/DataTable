-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/agent/UnlockAgent.lua

module("logic.extensions.unlock.agent.UnlockAgent", package.seeall)

local UnlockAgent = class("UnlockAgent", BaseAgent)

UnlockAgent.GetUnlockNeedInfoRes = "UnlockAgent_GetUnlockNeedInfoRes"

function UnlockAgent:ctor()
	return
end

function UnlockAgent:setExtId(extId)
	UnlockAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function UnlockAgent:sendGetUnlockNeedInfoReq(challengeIds_i32_Ary, handler, handlerObj, errHandler)
	local req = UnlockExtension_pb.GetUnlockNeedInfoReq()

	for i, v1 in ipairs(challengeIds_i32_Ary) do
		req.challengeIds:append(v1)
	end

	self:sendMsg(req)
	self:addEventOnce(UnlockAgent.GetUnlockNeedInfoRes, handler, handlerObj, errHandler)
end

function UnlockAgent:handleGetUnlockNeedInfoRes(status, msg)
	self:dispatch(UnlockAgent.GetUnlockNeedInfoRes, status, msg)
end

UnlockAgent.instance = UnlockAgent.New()

return UnlockAgent
