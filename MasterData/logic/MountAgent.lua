-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/agent/MountAgent.lua

module("logic.extensions.mount.agent.MountAgent", package.seeall)

local MountAgent = class("MountAgent", BaseAgent)

MountAgent.MountInfoRes = "MountAgent_MountInfoRes"
MountAgent.MountUnlockRes = "MountAgent_MountUnlockRes"
MountAgent.MountChangeRes = "MountAgent_MountChangeRes"
MountAgent.MountLevelUpRes = "MountAgent_MountLevelUpRes"
MountAgent.MountBreachRes = "MountAgent_MountBreachRes"
MountAgent.NotifyMountChangedRes = "MountAgent_NotifyMountChangedRes"
MountAgent.OneClickDevelopMount = "MountAgent_OneClickDevelopMount"

function MountAgent:ctor()
	return
end

function MountAgent:setExtId(extId)
	MountAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MountAgent:sendMountInfoReq(handler, handlerObj, errHandler)
	local req = MountExtension_pb.MountInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleMountInfoRes(status, msg)
	self:dispatch(MountAgent.MountInfoRes, status, msg)
end

function MountAgent:sendMountUnlockReq(mountId, handler, handlerObj, errHandler)
	local req = MountExtension_pb.MountUnlockReq()

	req.mountId = mountId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountUnlockRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleMountUnlockRes(status, msg)
	self:dispatch(MountAgent.MountUnlockRes, status, msg)
end

function MountAgent:sendMountChangeReq(mountId, handler, handlerObj, errHandler)
	local req = MountExtension_pb.MountChangeReq()

	req.mountId = mountId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountChangeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleMountChangeRes(status, msg)
	self:dispatch(MountAgent.MountChangeRes, status, msg)
end

function MountAgent:sendMountLevelUpReq(mountId, times, handler, handlerObj, errHandler)
	local req = MountExtension_pb.MountLevelUpReq()

	req.mountId = mountId
	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountLevelUpRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleMountLevelUpRes(status, msg)
	self:dispatch(MountAgent.MountLevelUpRes, status, msg)
end

function MountAgent:sendMountBreachReq(mountId, handler, handlerObj, errHandler)
	local req = MountExtension_pb.MountBreachReq()

	req.mountId = mountId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountBreachRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleMountBreachRes(status, msg)
	self:dispatch(MountAgent.MountBreachRes, status, msg)
end

function MountAgent:handleNotifyMountChangedRes(status, msg)
	self:dispatch(MountAgent.NotifyMountChangedRes, status, msg)
end

function MountAgent:sendMountSelectActiveMountReq(activeMountIds)
	local req = MountExtension_pb.MountSelectActiveMountReq()

	if activeMountIds then
		for k, v in pairs(activeMountIds) do
			req.activeMountIds:append(v)
		end
	end

	self:sendMsg(req)
end

function MountAgent:handleMountSelectActiveMountRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MountAttrActive)
	end
end

function MountAgent:sendOneClickDevelopMountReq(mountId, times, handler, handlerObj, errHandler)
	local req = MountExtension_pb.OneClickDevelopMountReq()

	req.mountId = mountId
	req.developTime = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MountAgent.MountLevelUpRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MountAgent:handleOneClickDevelopMountRes(status, msg)
	MountController.instance:handleOneClickDevelopMountRes(status, msg)
	self:dispatch(MountAgent.MountLevelUpRes, status, msg)
end

function MountAgent:sendMountInviteTeamReq(targetUserId)
	local req = MountExtension_pb.MountInviteTeamReq()

	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function MountAgent:handleMountInviteTeamRes(status, msg)
	if status == 0 then
		MountController.instance:handleMountInviteTeamRes(msg)
	end
end

function MountAgent:sendMountAgreeTeamReq(targetUserId)
	local req = MountExtension_pb.MountAgreeTeamReq()

	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function MountAgent:handleMountAgreeTeamRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MountController.instance:handleMountAgreeTeamRes(status, msg)
end

function MountAgent:sendMountLeaveTeamReq()
	local req = MountExtension_pb.MountLeaveTeamReq()

	self:sendMsg(req)
end

function MountAgent:handleMountLeaveTeamRes(status, msg)
	if status == 0 then
		MountController.instance:handleMountLeaveTeamRes(msg)
	end
end

function MountAgent:handleNotifyTeamMountInvitedRes(status, msg)
	if status == 0 then
		MountController.instance:handleNotifyTeamMountInvitedRes(msg)
	end
end

function MountAgent:handleNotifyTeamMountChangedRes(status, msg)
	if status == 0 then
		MountController.instance:handleNotifyTeamMountChangedRes(msg)
	end
end

MountAgent.instance = MountAgent.New()

return MountAgent
