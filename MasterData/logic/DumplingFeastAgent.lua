-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/agent/DumplingFeastAgent.lua

module("logic.extensions.dumplingfeast.agent.DumplingFeastAgent", package.seeall)

local DumplingFeastAgent = class("DumplingFeastAgent", BaseAgent)

function DumplingFeastAgent:sendPM_DumplingFeastInfoReq(activityId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastInfoRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastInfoRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastRollDoughReq(activityId, seconds)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastRollDoughReq()

	req.activityId = activityId
	req.seconds = seconds

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastRollDoughRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastRollDoughRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastStuffFillingReq(activityId, fillingId, seconds)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastStuffFillingReq()

	req.activityId = activityId
	req.fillingId = fillingId
	req.seconds = seconds

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastStuffFillingRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastStuffFillingRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastBoilDumplingReq(activityId, potId, dumplingId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastBoilDumplingReq()

	req.activityId = activityId
	req.potId = potId
	req.dumplingId = dumplingId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastBoilDumplingRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastBoilDumplingRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastTakeOutDumplingReq(activityId, potId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastTakeOutDumplingReq()

	req.activityId = activityId
	req.potId = potId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastTakeOutDumplingRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastTakeOutDumplingRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastGainDumplingReq(activityId, bowlId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastGainDumplingReq()

	req.activityId = activityId
	req.bowlId = bowlId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastGainDumplingRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastGainDumplingRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastFeedReq(activityId, raceId, dumplingInfoList)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastFeedReq()

	req.activityId = activityId
	req.raceId = raceId

	local dumplingInfo_pb = CommonStructDef_pb.PM_PairInt()

	for _, info in ipairs(dumplingInfoList) do
		for idx = 1, info.num do
			dumplingInfo_pb.left = info.dumplingId
			dumplingInfo_pb.right = info.quality

			local vv = req.dumplingIdToQuality:add()

			vv:ParseFromString(dumplingInfo_pb:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastFeedRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastFeedRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastGainDamageProgressReq(activityId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastGainDamageProgressReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastGainDamageProgressRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastGainDamageProgressRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastGainIntimacyProgressReq(activityId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastGainIntimacyProgressReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastGainIntimacyProgressRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastGainIntimacyProgressRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastBossClgReq(activityId, form, isTrial)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastBossClgReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.isTrial = isTrial

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastBossClgRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastBossClgRes(msg)
	end
end

function DumplingFeastAgent:handlePM_DumplingFeastNotifyBossClgRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastNotifyBossClgRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastRankViewReq(activityId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastRankViewRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastRankViewRes(msg)
	end
end

function DumplingFeastAgent:sendPM_DumplingFeastOneClickMakeDumplingReq(activityId, num, dumplingId)
	local req = DumplingFeastExtension_pb.PM_DumplingFeastOneClickMakeDumplingReq()

	req.activityId = activityId
	req.num = num
	req.dumplingId = dumplingId

	self:sendMsg(req)
end

function DumplingFeastAgent:handlePM_DumplingFeastOneClickMakeDumplingRes(status, msg)
	if status == 0 then
		DumplingFeastController.instance:handlePM_DumplingFeastOneClickMakeDumplingRes(msg)
	end
end

DumplingFeastAgent.instance = DumplingFeastAgent.New()

return DumplingFeastAgent
