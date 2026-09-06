-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/agent/DivineIsaacClgAgent.lua

module("logic.extensions.divineisaacclg.agent.DivineIsaacClgAgent", package.seeall)

local DivineIsaacClgAgent = class("DivineIsaacClgAgent", BaseAgent)

function DivineIsaacClgAgent:sendPM_DivineIsaacClgInfoReq(activityId)
	local req = DivineIsaacClgExtension_pb.PM_DivineIsaacClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineIsaacClgAgent:handlePM_DivineIsaacClgInfoRes(status, msg)
	if status == 0 then
		DivineisaacclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineIsaacClgInfoRes)
	end
end

function DivineIsaacClgAgent:sendPM_DivineIsaacClgProducePuppetReq(activityId, phaseId, puppetId)
	local req = DivineIsaacClgExtension_pb.PM_DivineIsaacClgProducePuppetReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.puppetId = puppetId

	self:sendMsg(req)
end

function DivineIsaacClgAgent:handlePM_DivineIsaacClgProducePuppetRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("合成1个傀儡")

		local activityId = msg.activityId

		DivineIsaacClgAgent.instance:sendPM_DivineIsaacClgInfoReq(activityId)

		if msg.isPassPhase then
			UIStateManager.instance:popByName(ViewName.DivineisaacclgfactoryView)
			FloatWordMgr.instance:show("关卡目标已达成")

			return
		end

		DivineisaacclgModel.instance:onProducePuppetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineIsaacClgProducePuppetRes)
	end
end

function DivineIsaacClgAgent:sendPM_DivineIsaacClgResetReq(activityId, phaseId)
	local req = DivineIsaacClgExtension_pb.PM_DivineIsaacClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function DivineIsaacClgAgent:handlePM_DivineIsaacClgResetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		FloatWordMgr.instance:show("重置成功")
		DivineisaacclgModel.instance:onClgResetRes(activityId)
		DivineisaacclgModel.instance:resetUsePuppets(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.DivineIsaacClgResetRes)
	end
end

function DivineIsaacClgAgent:sendPM_DivineIsaacClgChallengeReq(activityId, phaseId, stageId, usePuppets, form)
	local req = DivineIsaacClgExtension_pb.PM_DivineIsaacClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	for i, v in ipairs(usePuppets) do
		if v.num > 0 then
			local add = req.usePuppets:add()

			add.puppetId = v.puppetId
			add.num = v.num
		end
	end

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineIsaacClgAgent:handlePM_DivineIsaacClgChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineIsaacClgChallengeRes)
	end
end

function DivineIsaacClgAgent:handlePM_NotifyDivineIsaacClgChallengeFinishRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		DivineisaacclgController.instance:clgChallengeFinishRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineIsaacClgChallengeFinishRes)
		self:sendPM_DivineIsaacClgInfoReq(activityId)
	end
end

DivineIsaacClgAgent.instance = DivineIsaacClgAgent.New()

return DivineIsaacClgAgent
