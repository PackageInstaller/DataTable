-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/agent/UpholdJusticeAgent.lua

module("logic.extensions.upholdjustice.agent.UpholdJusticeAgent", package.seeall)

local UpholdJusticeAgent = class("UpholdJusticeAgent", BaseAgent)

function UpholdJusticeAgent:sendPM_UpholdJusticeGetInfoReq(activityId)
	local req = UpholdJusticeExtension_pb.PM_UpholdJusticeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UpholdJusticeAgent:handlePM_UpholdJusticeGetInfoRes(status, msg)
	if status == 0 then
		UpholdJusticeController.instance:onGetInfo(msg)
	end
end

function UpholdJusticeAgent:sendPM_UpholdJusticeDonateOrGainReq(activityId, playerType, vale)
	local req = UpholdJusticeExtension_pb.PM_UpholdJusticeDonateOrGainReq()

	req.activityId = activityId
	req.playerType = playerType
	req.vale = vale

	self:sendMsg(req)
end

function UpholdJusticeAgent:handlePM_UpholdJusticeDonateOrGainRes(status, msg)
	if status == 0 then
		UpholdJusticeController.instance:onDonateOrGain(msg)
	elseif status == -99 then
		TipsFacade.instance:openCommonTips("可领取的体力数量不足~")
	end
end

function UpholdJusticeAgent:sendPM_UpholdJusticeRankViewReq(activityId)
	local req = UpholdJusticeExtension_pb.PM_UpholdJusticeRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UpholdJusticeAgent:handlePM_UpholdJusticeRankViewRes(status, msg)
	if status == 0 then
		UpholdJusticeController.instance:onGetRankInfo(msg)
	end
end

UpholdJusticeAgent.instance = UpholdJusticeAgent.New()

return UpholdJusticeAgent
