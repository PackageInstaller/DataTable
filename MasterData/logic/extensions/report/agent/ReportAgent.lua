-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/agent/ReportAgent.lua

module("logic.extensions.report.agent.ReportAgent", package.seeall)

local M = class("ReportAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendReportUserRequest(userId, reportType, cause, content)
	local msg = FriendExtension_pb.ReportUserRequest()

	msg.userId = userId
	msg.reportType = reportType

	if cause and cause ~= "" then
		msg.cause = cause
	end

	if content then
		msg.content = content
	end

	self:sendMsg(msg)
end

function M:handleReportUserReply(status, msg)
	if status == 0 then
		local userId = msg.userId
	end
end

M.instance = M.New()

return M
