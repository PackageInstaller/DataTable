-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/agent/SignInBuffAgent.lua

module("logic.extensions.signinbuff.agent.SignInBuffAgent", package.seeall)

local SignInBuffAgent = class("SignInBuffAgent", BaseAgent)

function SignInBuffAgent:sendPM_SignInBuffInfoReq(activityId)
	local req = SignInBuffExtension_pb.PM_SignInBuffInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SignInBuffAgent:handlePM_SignInBuffInfoRes(status, msg)
	if status == 0 then
		SignInBuffController.instance:handleGetInfo(msg)
	end
end

function SignInBuffAgent:sendPM_UpgradeSignInBuffReq(activityId)
	local req = SignInBuffExtension_pb.PM_UpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SignInBuffAgent:handlePM_UpgradeSignInBuffRes(status, msg)
	if status == 0 then
		SignInBuffController.instance:handleUpgradeSignInBuff(msg)
	end
end

function SignInBuffAgent:sendPM_BatchSignInBuffInfoReq(activityId_i32_Ary)
	local req = SignInBuffExtension_pb.PM_BatchSignInBuffInfoReq()

	for i, v1 in ipairs(activityId_i32_Ary) do
		req.activityId:append(v1)
	end

	self:sendMsg(req)
end

function SignInBuffAgent:handlePM_BatchSignInBuffInfoRes(status, msg)
	if status == 0 then
		SignInBuffController.instance:handleBatchSignInBuffInfo(msg)
	end
end

function SignInBuffAgent:sendPM_BatchUpgradeSignInBuffReq(activityId_i32_Ary)
	local req = SignInBuffExtension_pb.PM_BatchUpgradeSignInBuffReq()

	for i, v2 in ipairs(activityId_i32_Ary) do
		req.activityId:append(v2)
	end

	self:sendMsg(req)
end

function SignInBuffAgent:handlePM_BatchUpgradeSignInBuffRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.SignInBuffUpgradeSignIn, status, msg)
end

SignInBuffAgent.instance = SignInBuffAgent.New()

return SignInBuffAgent
