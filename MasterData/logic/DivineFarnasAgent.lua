-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/agent/DivineFarnasAgent.lua

module("logic.extensions.divinefarnas.agent.DivineFarnasAgent", package.seeall)

local DivineFarnasAgent = class("DivineFarnasAgent", BaseAgent)

function DivineFarnasAgent:sendPM_DivineFarnasClgGetInfoReq(activityId)
	local req = DivineFarnasClgExtension_pb.PM_DivineFarnasClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineFarnasAgent:handlePM_DivineFarnasClgGetInfoRes(status, msg)
	if status == 0 then
		DivineFarnasController.instance:handlePM_DivineFarnasClgGetInfoRes(msg)
	end
end

function DivineFarnasAgent:sendPM_DivineFarnasClgExtremeFightReq(activityId, stageId, form)
	local req = DivineFarnasClgExtension_pb.PM_DivineFarnasClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineFarnasAgent:handlePM_DivineFarnasClgExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineFarnasAgent:handlePM_DivineFarnasClgExtremeFightNotifyRes(status, msg)
	if status == 0 then
		DivineFarnasController.instance:handlePM_DivineFarnasClgExtremeFightNotifyRes(msg)
	end
end

function DivineFarnasAgent:sendPM_DivineFarnasClgResetReq(activityId, stageId)
	local req = DivineFarnasClgExtension_pb.PM_DivineFarnasClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineFarnasAgent:handlePM_DivineFarnasClgResetRes(status, msg)
	if status == 0 then
		DivineFarnasController.instance:handlePM_DivineFarnasClgResetRes(msg)
	end
end

function DivineFarnasAgent:sendPM_DivineFarnasClgNormalFightReq(activityId, stageId, form)
	local req = DivineFarnasClgExtension_pb.PM_DivineFarnasClgNormalFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineFarnasAgent:handlePM_DivineFarnasClgNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineFarnasAgent:handlePM_DivineFarnasClgNormalFightNotifyRes(status, msg)
	if status == 0 then
		DivineFarnasController.instance:handlePM_DivineFarnasClgNormalFightNotifyRes(msg)
	end
end

function DivineFarnasAgent:sendPM_DivineFarnasClgGainPrizeReq(activityId, prizeId)
	local req = DivineFarnasClgExtension_pb.PM_DivineFarnasClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineFarnasAgent:handlePM_DivineFarnasClgGainPrizeRes(status, msg)
	if status == 0 then
		DivineFarnasController.instance:handlePM_DivineFarnasClgGainPrizeRes(msg)
	end
end

DivineFarnasAgent.instance = DivineFarnasAgent.New()

return DivineFarnasAgent
