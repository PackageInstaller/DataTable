-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/agent/LingWenAgent.lua

module("logic.extensions.lingwen.agent.LingWenAgent", package.seeall)

local LingWenAgent = class("LingWenAgent", BaseAgent)

LingWenAgent.LingWenGetInfoRes = "LingWenGetInfoRes_LingWenGetInfoRes"
LingWenAgent.LingWenSweepRes = "LingWenAgent_LingWenSweepRes"

function LingWenAgent:sendPM_LingWenGetInfoReq()
	local req = LingWenExtension_pb.PM_LingWenGetInfoReq()

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenGetInfoRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleGetInfo(msg)
	end

	self:dispatch(LingWenAgent.LingWenGetInfoRes, status, msg)
end

function LingWenAgent:sendPM_LingWenSetFormReq(isGroupForm, formList)
	local req = LingWenExtension_pb.PM_LingWenSetFormReq()

	req.isGroupForm = isGroupForm

	for i, v in ipairs(formList) do
		local param = req.formList:add()

		param:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenSetFormRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleSaveForm(msg)
	end
end

function LingWenAgent:sendPM_LingWenFightReq(tabId, stageId, formList)
	local req = LingWenExtension_pb.PM_LingWenFightReq()

	req.tabId = tabId
	req.stageId = stageId

	for i, v in ipairs(formList) do
		local param = req.formList:add()

		param:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenFightRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleStartFight(msg)
	else
		if ViewMgr.instance:isOpen(ViewName.CustomMissionView) then
			UIStateManager.instance:clear(true)
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function LingWenAgent:sendPM_LingWenGetFormReq(isGroupForm)
	local req = LingWenExtension_pb.PM_LingWenGetFormReq()

	req.isGroupForm = isGroupForm

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenGetFormRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleGetLastForm(msg)
	end
end

function LingWenAgent:sendPM_LingWenReadyReq(form_pb)
	local req = LingWenExtension_pb.PM_LingWenReadyReq()

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenReadyRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleReadyForTeamBattle(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
		FormTeamController.instance:onFightErrorForceLeaveCurTeam()
	end
end

function LingWenAgent:handlePM_LingWenNotifySingleFightFinish(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleNotifySoloFightResult(msg)
	end
end

function LingWenAgent:handlePM_LingWenNotifyGroupFightFinish(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:handleNotifyTeamFightResult(msg)
	end
end

function LingWenAgent:handlePM_LingWenNotifyEnd(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:dealFightError(msg.reason)
	end
end

function LingWenAgent:handlePM_LingWenGameStart(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:dealEnterTeamFight()
	end
end

function LingWenAgent:sendPM_LingWenSweepReq(tabId, stageId, sweepTimes)
	local req = LingWenExtension_pb.PM_LingWenSweepReq()

	req.tabId = tabId
	req.stageId = stageId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function LingWenAgent:handlePM_LingWenSweepRes(status, msg)
	if status == 0 then
		HolyStripeCopyController.instance:_onSweepRes(msg)
	end

	self:dispatch(LingWenAgent.LingWenSweepRes, status, msg)
end

LingWenAgent.instance = LingWenAgent.New()

return LingWenAgent
