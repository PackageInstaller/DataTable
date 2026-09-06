-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/agent/SummerTreasureSnatchAgent.lua

module("logic.extensions.summertreasuresnatch.agent.SummerTreasureSnatchAgent", package.seeall)

local SummerTreasureSnatchAgent = class("SummerTreasureSnatchAgent", BaseAgent)

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchInfoReq(activityId)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchInfoRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchInfoRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchPvpMatchReq(activityId)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchPvpMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchPvpMatchRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchPvpMatchRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchPvpFightReq(activityId, formList)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchPvpFightReq()

	req.activityId = activityId

	if formList then
		for _, v in ipairs(formList) do
			req.form:add():ParseFromString(v:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchPvpFightRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchPvpFightRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchBossClgReq(activityId, bossId, form, buffId, isTrial)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchBossClgReq()

	req.activityId = activityId
	req.bossId = bossId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.buffId = buffId
	req.isTrial = isTrial

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchBossClgRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchBossClgRes(msg)
	end
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchNotifyBossClgRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchNotifyBossClgRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchBuyItemReq(activityId, itemId)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchBuyItemReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchBuyItemRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchBuyItemRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchPresetFormationReq(activityId, formList)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchPresetFormationReq()

	req.activityId = activityId

	if formList then
		for _, v in ipairs(formList) do
			req.form:add():ParseFromString(v:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchPresetFormationRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchPresetFormationRes(msg)
	end
end

function SummerTreasureSnatchAgent:sendPM_SummerTreasureSnatchRankViewReq(activityId, isTotalRank)
	local req = SummerTreasureSnatchExtension_pb.PM_SummerTreasureSnatchRankViewReq()

	req.activityId = activityId
	req.isTotalRank = isTotalRank

	self:sendMsg(req)
end

function SummerTreasureSnatchAgent:handlePM_SummerTreasureSnatchRankViewRes(status, msg)
	if status == 0 then
		SummerTreasureSnatchController.instance:handlePM_SummerTreasureSnatchRankViewRes(msg)
	end
end

SummerTreasureSnatchAgent.instance = SummerTreasureSnatchAgent.New()

return SummerTreasureSnatchAgent
