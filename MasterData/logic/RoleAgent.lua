-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/agent/RoleAgent.lua

module("logic.extensions.role.agent.RoleAgent", package.seeall)

local RoleAgent = class("RoleAgent", BaseAgent)

function RoleAgent:sendHeartBeatReq()
	local req = UserExtension_pb.HeartBeatReq()

	self:sendMsg(req)
	NetConnMgrExt.markHeartBeatRequested()
	AcceleratorCheckController.instance:mark()
end

function RoleAgent:handleHeartBeatRes(status, msg)
	if status == 0 then
		NetConnMgrExt.markHeartBeatRespont()
		RoleController.instance:syncServerTime(msg.currentTimeMillis)
	end
end

function RoleAgent:sendExitGameReq()
	local req = UserExtension_pb.ExitGameReq()

	self:sendMsg(req)

	LoginModel.instance.isLogout = true
end

function RoleAgent:handleExitGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function RoleAgent:handlePM_NotifyUserBanInfoChangeRes(status, msg)
	if status == 0 and #msg.userBanInfos > 0 then
		RoleModel.instance:handleUserBanInfoChange(msg.userBanInfos)
	end
end

function RoleAgent:handlePM_ServerMsgNotifyRes(status, msg)
	if status == 0 then
		LoginController.instance:handleServerMsgNotifyRes(msg.type == 999, msg.customMsg)
	end
end

function RoleAgent:sendPM_CloseUserReq()
	local req = UserExtension_pb.PM_CloseUserReq()

	self:sendMsg(req)
end

function RoleAgent:handlePM_CloseUserRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openTipWindowNoX("注销成功", lang("zhuxiao_popup_4"))
	end
end

RoleAgent.instance = RoleAgent.New()

return RoleAgent
