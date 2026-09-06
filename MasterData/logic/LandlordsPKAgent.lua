-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/agent/LandlordsPKAgent.lua

module("logic.extensions.landlords.agent.LandlordsPKAgent", package.seeall)

local LandlordsPKAgent = class("LandlordsPKAgent", BaseAgent)

function LandlordsPKAgent:sendPM_LandlordsPKInfoReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKInfoRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKInfoRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKGetDailySuppluGainReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKGetDailySuppluGainReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKGetDailySuppluGainRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKGetDailySuppluGainRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKGetOnlineTimeSupplyGainInfoReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKGetOnlineTimeSupplyGainInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKGetOnlineTimeSupplyGainReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKGetOnlineTimeSupplyGainReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKGetOnlineTimeSupplyGainRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKGetOnlineTimeSupplyGainRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKRankViewReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKRankViewRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKRankViewRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKGetBattleRecordReq(activityId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKGetBattleRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKGetBattleRecordRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKGetBattleRecordRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKGetBattleVideoReq(battleIds)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKGetBattleVideoReq()

	for i, battleId in ipairs(battleIds) do
		req.battleId:append(battleId)
	end

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKGetBattleVideoRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKGetBattleVideoRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKMatchReq(activityId, thresholdId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKMatchReq()

	req.activityId = activityId
	req.thresholdId = thresholdId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKMatchRes(status, msg)
	FightAgainstLandlordsController.instance:handlePM_LandlordsPKMatchRes(status, msg)
end

function LandlordsPKAgent:sendPM_LandlordsPKCancelMatchReq()
	local req = LandlordsPKExtension_pb.PM_LandlordsPKCancelMatchReq()

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKCancelMatchRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKCancelMatchRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKLandlordReq(ack)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKLandlordReq()

	req.ack = ack

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKLandlordRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKLandlordRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKFormSetReq(form)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKFormSetReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKFormSetRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKFormSetRes(msg)
	end
end

function LandlordsPKAgent:sendPM_LandlordsPKChatReq(chatId)
	local req = LandlordsPKExtension_pb.PM_LandlordsPKChatReq()

	req.chatId = chatId

	self:sendMsg(req)
end

function LandlordsPKAgent:handlePM_LandlordsPKChatRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKChatRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyDealCardRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyDealCardRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyLandlordsAckRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyLandlordsAckRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyLandlordsCofirmRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyLandlordsCofirmRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyLandlordsFormSetRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyLandlordsFormSetRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyLandlordsFormShowRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyLandlordsFormShowRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyBattleResultRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyBattleResultRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyMatchingOverTimeRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyMatchFailRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyMatchFailRes(msg)
	end
end

function LandlordsPKAgent:handlePM_LandlordsPKNotifyChatRes(status, msg)
	if status == 0 then
		FightAgainstLandlordsController.instance:handlePM_LandlordsPKNotifyChatRes(msg)
	end
end

LandlordsPKAgent.instance = LandlordsPKAgent.New()

return LandlordsPKAgent
