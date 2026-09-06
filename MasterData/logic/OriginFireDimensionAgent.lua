-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/agent/OriginFireDimensionAgent.lua

module("logic.extensions.originfiredimension.agent.OriginFireDimensionAgent", package.seeall)

local OriginFireDimensionAgent = class("OriginFireDimensionAgent", BaseAgent)

function OriginFireDimensionAgent:sendPM_OriginFireDimensionInfoReq(activityId)
	local req = OriginFireDimensionExtension_pb.PM_OriginFireDimensionInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginFireDimensionAgent:handlePM_OriginFireDimensionInfoRes(status, msg)
	if status == 0 then
		OriginHuociyuanController.instance:onGetInfo(msg)
	end
end

function OriginFireDimensionAgent:sendPM_OriginFireDimensionClgReq(activityId, stageId, petIdToBuffId_pb_Ary, form_pb)
	local req = OriginFireDimensionExtension_pb.PM_OriginFireDimensionClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if petIdToBuffId_pb_Ary ~= nil then
		for i, v1 in ipairs(petIdToBuffId_pb_Ary) do
			local petIdToBuffId = req.petIdToBuffId:add()

			petIdToBuffId:ParseFromString(v1:SerializeToString())
		end
	end

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginFireDimensionAgent:handlePM_OriginFireDimensionClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginFireDimensionAgent:sendPM_OriginFireDimensionResetReq(activityId, stageId)
	local req = OriginFireDimensionExtension_pb.PM_OriginFireDimensionResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginFireDimensionAgent:handlePM_OriginFireDimensionResetRes(status, msg)
	if status == 0 then
		OriginHuociyuanController.instance:onResetFight(msg)
	end
end

function OriginFireDimensionAgent:handlePM_OriginFireDimensionNotifyClgRes(status, msg)
	if status == 0 then
		OriginHuociyuanController.instance:handleFightRes(msg)
	end
end

OriginFireDimensionAgent.instance = OriginFireDimensionAgent.New()

return OriginFireDimensionAgent
