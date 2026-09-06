-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/agent/DivineMiZongClgAgent.lua

module("logic.extensions.divinemizongclg.agent.DivineMiZongClgAgent", package.seeall)

local DivineMiZongClgAgent = class("DivineMiZongClgAgent", BaseAgent)

function DivineMiZongClgAgent:sendPM_DivineMiZongClgGetInfoReq(activityId)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgGetInfoRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgGetInfoRes(msg)
	end
end

function DivineMiZongClgAgent:sendPM_DivineMiZongClgFightReq(activityId, stageId, form, specialPetId)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.specialPetId = specialPetId

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgFightRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgFightRes(msg)
	end
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgNotifyFightRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgNotifyFightRes(msg)
	end
end

function DivineMiZongClgAgent:sendPM_DivineMiZongClgGainBuffItemReq(activityId)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgGainBuffItemReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgGainBuffItemRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgGainBuffItemRes(msg)
	end
end

function DivineMiZongClgAgent:sendPM_DivineMiZongClgUpgradeBuffReq(activityId, buffType)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgUpgradeBuffReq()

	req.activityId = activityId
	req.buffType = buffType

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgUpgradeBuffRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgUpgradeBuffRes(msg)
	end
end

function DivineMiZongClgAgent:sendPM_DivineMiZongClgResetBuffReq(activityId)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgResetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgResetBuffRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgResetBuffRes(msg)
	end
end

function DivineMiZongClgAgent:sendPM_DivineMiZongClgGainPrizeReq(activityId, prizeId)
	local req = DivineMiZongClgExtension_pb.PM_DivineMiZongClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineMiZongClgAgent:handlePM_DivineMiZongClgGainPrizeRes(status, msg)
	if status == 0 then
		DivineMiZongClgController.instance:handlePM_DivineMiZongClgGainPrizeRes(msg)
	end
end

DivineMiZongClgAgent.instance = DivineMiZongClgAgent.New()

return DivineMiZongClgAgent
