-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/agent/DivineAoJiuClgAgent.lua

module("logic.extensions.divineaojiuclg.agent.DivineAoJiuClgAgent", package.seeall)

local DivineAoJiuClgAgent = class("DivineAoJiuClgAgent", BaseAgent)

function DivineAoJiuClgAgent:sendPM_DivineAoJiuClgGetInfoReq(activityId)
	local req = DivineAoJiuClgExtension_pb.PM_DivineAoJiuClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgGetInfoRes(status, msg)
	if status == 0 then
		DivineAoJiuController.instance:handlePM_DivineAoJiuClgGetInfoRes(msg)
	end
end

function DivineAoJiuClgAgent:sendPM_DivineAoJiuClgExtremeClgReq(activityId, stageId, selectBuffId, form)
	local req = DivineAoJiuClgExtension_pb.PM_DivineAoJiuClgExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId
	req.selectBuffId = selectBuffId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgExtremeClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgNotifyExtremeClgRes(status, msg)
	if status == 0 then
		DivineAoJiuController.instance:handlePM_DivineAoJiuClgNotifyExtremeClgRes(msg)
	end
end

function DivineAoJiuClgAgent:sendPM_DivineAoJiuClgConfirmReq(activityId, stageId)
	local req = DivineAoJiuClgExtension_pb.PM_DivineAoJiuClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgConfirmRes(status, msg)
	if status == 0 then
		DivineAoJiuController.instance:handlePM_DivineAoJiuClgConfirmRes(msg)
	end
end

function DivineAoJiuClgAgent:sendPM_DivineAoJiuClgNormalClgReq(activityId, stageId, form)
	local req = DivineAoJiuClgExtension_pb.PM_DivineAoJiuClgNormalClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgNormalClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgNotifyNormalClgRes(status, msg)
	if status == 0 then
		DivineAoJiuController.instance:handlePM_DivineAoJiuClgNotifyNormalClgRes(msg)
	end
end

function DivineAoJiuClgAgent:sendPM_DivineAoJiuClgBuyPassReq(activityId, buyPassCount)
	local req = DivineAoJiuClgExtension_pb.PM_DivineAoJiuClgBuyPassReq()

	req.activityId = activityId
	req.buyPassCount = buyPassCount

	self:sendMsg(req)
end

function DivineAoJiuClgAgent:handlePM_DivineAoJiuClgBuyPassRes(status, msg)
	if status == 0 then
		DivineAoJiuController.instance:handlePM_DivineAoJiuClgBuyPassRes(msg)
	end
end

DivineAoJiuClgAgent.instance = DivineAoJiuClgAgent.New()

return DivineAoJiuClgAgent
