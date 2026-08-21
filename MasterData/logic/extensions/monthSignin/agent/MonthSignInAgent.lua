-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/agent/MonthSignInAgent.lua

module("logic.extensions.monthSignin.agent.MonthSignInAgent", package.seeall)

local M = class("MonthSignInAgent", BaseAgent)

function M:sendGetMonthSignInInfoRequest()
	local msg = MonthSignInExtension_pb.GetMonthSignInInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetMonthSignInInfoReply(status, msg)
	if status == 0 then
		MonthSigninController.instance:handlerGetSignInfo(msg)
	end
end

function M:sendSignInRequest()
	local msg = MonthSignInExtension_pb.SignInRequest()

	self:sendMsg(msg)
end

function M:handleSignInReply(status, msg)
	if status == 0 then
		MonthSigninController.instance:handlerSignSuccess(msg)
	end
end

M.instance = M:New()

return M
