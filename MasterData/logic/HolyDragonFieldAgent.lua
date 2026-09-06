-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/agent/HolyDragonFieldAgent.lua

module("logic.extensions.holydragonfield.agent.HolyDragonFieldAgent", package.seeall)

local HolyDragonFieldAgent = class("HolyDragonFieldAgent", BaseAgent)

function HolyDragonFieldAgent:sendPM_HolyDragonFieldInfoReq(activityId)
	local req = HolyDragonFieldExtension_pb.PM_HolyDragonFieldInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyDragonFieldAgent:handlePM_HolyDragonFieldInfoRes(status, msg)
	if status == 0 then
		HolyDragonFieldController.instance:handlePM_HolyDragonFieldInfoRes(msg)
	end
end

function HolyDragonFieldAgent:sendPM_HolyDragonFieldChallengeReq(activityId, form, fieldId, stageId, selectBossSettle)
	local req = HolyDragonFieldExtension_pb.PM_HolyDragonFieldChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.fieldId = fieldId
	req.stageId = stageId

	if selectBossSettle then
		for _, bossSettle in ipairs(selectBossSettle) do
			table.insert(req.selectBossSettle, bossSettle)
		end
	end

	self:sendMsg(req)
end

function HolyDragonFieldAgent:handlePM_HolyDragonFieldChallengeRes(status, msg)
	HolyDragonFieldController.instance:handlePM_HolyDragonFieldChallengeRes(status, msg)
end

function HolyDragonFieldAgent:handlePM_HolyDragonFieldNotifyChallengeRes(status, msg)
	if status == 0 then
		HolyDragonFieldController.instance:handlePM_HolyDragonFieldNotifyChallengeRes(msg)
	end
end

function HolyDragonFieldAgent:sendPM_HolyDragonFieldUpgradeBuffReq(activityId, fieldId)
	local req = HolyDragonFieldExtension_pb.PM_HolyDragonFieldUpgradeBuffReq()

	req.activityId = activityId
	req.fieldId = fieldId

	self:sendMsg(req)
end

function HolyDragonFieldAgent:handlePM_HolyDragonFieldUpgradeBuffRes(status, msg)
	if status == 0 then
		HolyDragonFieldController.instance:handlePM_HolyDragonFieldUpgradeBuffRes(msg)
	end
end

function HolyDragonFieldAgent:sendPM_HolyDragonFieldRankViewReq(activityId, fieldId)
	local req = HolyDragonFieldExtension_pb.PM_HolyDragonFieldRankViewReq()

	req.activityId = activityId
	req.fieldId = fieldId

	self:sendMsg(req)
end

function HolyDragonFieldAgent:handlePM_HolyDragonFieldRankViewRes(status, msg)
	if status == 0 then
		HolyDragonFieldController.instance:handlePM_HolyDragonFieldRankViewRes(msg)
	end
end

HolyDragonFieldAgent.instance = HolyDragonFieldAgent.New()

return HolyDragonFieldAgent
