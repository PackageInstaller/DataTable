-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/agent/OriginFightAgent.lua

module("logic.extensions.originfight.agent.OriginFightAgent", package.seeall)

local OriginFightAgent = class("OriginFightAgent", BaseAgent)

function OriginFightAgent:sendPM_OriginFightInfoReq(activityId)
	local req = OriginFightExtension_pb.PM_OriginFightInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginFightAgent:handlePM_OriginFightInfoRes(status, msg)
	if status == 0 then
		OriginFightController.instance:handlePM_OriginFightInfoRes(msg)
	end
end

function OriginFightAgent:sendPM_OriginFightGainPrizeReq(activityId)
	local req = OriginFightExtension_pb.PM_OriginFightGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginFightAgent:handlePM_OriginFightGainPrizeRes(status, msg)
	if status == 0 then
		OriginFightController.instance:handlePM_OriginFightGainPrizeRes(msg)
	end
end

function OriginFightAgent:sendPM_OriginFightCommonGodFavorReq(activityId, godFavorId)
	local req = OriginFightExtension_pb.PM_OriginFightCommonGodFavorReq()

	req.activityId = activityId
	req.godFavorId = godFavorId

	self:sendMsg(req)
end

function OriginFightAgent:handlePM_OriginFightCommonGodFavorRes(status, msg)
	if status == 0 then
		OriginFightController.instance:handlePM_OriginFightCommonGodFavorRes(msg)
	end
end

function OriginFightAgent:sendPM_OriginFightCollectTitanReq(activityId)
	local req = OriginFightExtension_pb.PM_OriginFightCollectTitanReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginFightAgent:handlePM_OriginFightCollectTitanRes(status, msg)
	if status == 0 then
		OriginFightController.instance:handlePM_OriginFightCollectTitanRes(msg)
	end
end

function OriginFightAgent:sendPM_OriginFightBattleReq(activityId, form, godFavorId)
	local req = OriginFightExtension_pb.PM_OriginFightBattleReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.godFavorId = godFavorId

	self:sendMsg(req)
end

function OriginFightAgent:handlePM_OriginFightBattleRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginFightAgent:handlePM_OriginFightNotifyBattleRes(status, msg)
	if status == 0 then
		OriginFightController.instance:handlePM_OriginFightNotifyBattleRes(msg)
	end
end

OriginFightAgent.instance = OriginFightAgent.New()

return OriginFightAgent
