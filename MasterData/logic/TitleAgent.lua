-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/agent/TitleAgent.lua

module("logic.extensions.title.agent.TitleAgent", package.seeall)

local TitleAgent = class("TitleAgent", BaseAgent)

TitleAgent.PM_LoadAllTitleRes = "TitleAgent_PM_LoadAllTitleRes"
TitleAgent.PM_WearTitleRes = "TitleAgent_PM_WearTitleRes"
TitleAgent.PM_notifyGainTitleRes = "TitleAgent_PM_notifyGainTitleRes"

function TitleAgent:ctor()
	return
end

function TitleAgent:setExtId(extId)
	TitleAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TitleAgent:sendPM_LoadAllTitleReq(handler, handlerObj, errHandler)
	local req = TitleExtension_pb.PM_LoadAllTitleReq()

	self:sendMsg(req)
	self:addEventOnce(TitleAgent.PM_LoadAllTitleRes, handler, handlerObj, errHandler)
end

function TitleAgent:handlePM_LoadAllTitleRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadTitleData===back")

	if status == 0 then
		local titlelist = msg.titleList

		TitleModel.instance:updateTitleList(titlelist)
	end

	self:dispatch(TitleAgent.PM_LoadAllTitleRes, status, msg)
end

function TitleAgent:sendPM_WearTitleReq(titleId, handler, handlerObj, errHandler)
	local req = TitleExtension_pb.PM_WearTitleReq()

	req.titleId = titleId

	self:sendMsg(req)
	self:addEventOnce(TitleAgent.PM_WearTitleRes, handler, handlerObj, errHandler)
end

function TitleAgent:handlePM_WearTitleRes(status, msg)
	if status == 0 then
		local curtitleid = msg.curTitleId

		TitleModel.instance:setWear(curtitleid)
	end

	self:dispatch(TitleAgent.PM_WearTitleRes, status, msg)
end

function TitleAgent:handlePM_notifyGainTitleRes(status, msg)
	if status == 0 then
		local titlelist = msg.titleList

		TitleModel.instance:updateTitleList(titlelist, true)
	end

	self:dispatch(TitleAgent.PM_notifyGainTitleRes, status, msg)
end

TitleAgent.instance = TitleAgent.New()

return TitleAgent
