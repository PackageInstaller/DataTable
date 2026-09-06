-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/agent/DragonAwakenAgent.lua

module("logic.extensions.dragonawaken.agent.DragonAwakenAgent", package.seeall)

local DragonAwakenAgent = class("DragonAwakenAgent", BaseAgent)

function DragonAwakenAgent:sendPM_DragonAwakenGetInfoReq(activityId)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenGetInfoRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleGetInfo(msg)
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenBuyPetReq(activityId, creepsId)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenBuyPetReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenBuyPetRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleBuyPetReq(msg)
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenUpgradeReq(activityId, strengthType)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenUpgradeReq()

	req.activityId = activityId
	req.strengthType = strengthType

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenUpgradeRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleUpgradeReq(msg)
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenTrainingFightReq(activityId, hard, form_pb)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenTrainingFightReq()

	req.activityId = activityId
	req.hard = hard

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenTrainingFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenConfirmResultReq(activityId)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenConfirmResultReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenConfirmResultRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleConfirmTrainingResult(msg)
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenPhaseFightReq(activityId, form_pb)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenPhaseFightReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenPhaseFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenRankViewReq(activityId)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenRankViewRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleGetRankInfo(msg)
	end
end

function DragonAwakenAgent:sendPM_DragonAwakenRandomFormReq(activityId, hard)
	local req = DragonAwakenExtension_pb.PM_DragonAwakenRandomFormReq()

	req.activityId = activityId
	req.hard = hard

	self:sendMsg(req)
end

function DragonAwakenAgent:handlePM_DragonAwakenRandomFormRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleRandomTrainingForm(msg)
	end
end

function DragonAwakenAgent:handlePM_DragonAwakenNotifyTrainingRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleNotifyTrainingRes(msg)
	end
end

function DragonAwakenAgent:handlePM_DragonAwakenNotifyPhaseFightRes(status, msg)
	if status == 0 then
		DragonAwakenController.instance:handleNotifyFightRes(msg)
	end
end

DragonAwakenAgent.instance = DragonAwakenAgent.New()

return DragonAwakenAgent
