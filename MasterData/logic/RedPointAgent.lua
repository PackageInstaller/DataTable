-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/agent/RedPointAgent.lua

module("logic.extensions.redpoint.agent.RedPointAgent", package.seeall)

local RedPointAgent = class("RedPointAgent", BaseAgent)

RedPointAgent.PM_LoadAllRedPointRes = "RedPointAgent_PM_LoadAllRedPointRes"
RedPointAgent.PM_OnRedPointChangeRes = "RedPointAgent_PM_OnRedPointChangeRes"

function RedPointAgent:ctor()
	return
end

function RedPointAgent:setExtId(extId)
	RedPointAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function RedPointAgent:sendPM_LoadAllRedPointReq(handler, handlerObj, errHandler)
	local req = RedPointExtension_pb.PM_LoadAllRedPointReq()

	self:sendMsg(req)
	self:addEventOnce(RedPointAgent.PM_LoadAllRedPointRes, handler, handlerObj, errHandler)
end

function RedPointAgent:handlePM_LoadAllRedPointRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRedPointInfo===back")

	if status == 0 then
		local redpoints = msg.redPoints

		RedPointModel.instance:updateRedPointInfo(redpoints)
		self:dispatch(RedPointAgent.PM_LoadAllRedPointRes, status, msg)
	end
end

function RedPointAgent:handlePM_OnRedPointChangeRes(status, msg)
	if status == 0 then
		RedPointModel.instance:updateRedPointInfo(msg.redPoints)
	end

	self:dispatch(RedPointAgent.PM_OnRedPointChangeRes, status, msg)
end

RedPointAgent.instance = RedPointAgent.New()

return RedPointAgent
