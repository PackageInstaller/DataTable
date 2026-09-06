-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/agent/NumberGameAgent.lua

module("logic.extensions.numberbomb.agent.NumberGameAgent", package.seeall)

local NumberGameAgent = class("NumberGameAgent", BaseAgent)

function NumberGameAgent:sendPM_NGGetActInfoReq(actId)
	local req = NumberGameExtension_pb.PM_NGGetActInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGetActInfoRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendGameBaseInfo(msg)
	end
end

function NumberGameAgent:sendPM_NGGetGameRecordReq(actId)
	local req = NumberGameExtension_pb.PM_NGGetGameRecordReq()

	req.actId = actId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGetGameRecordRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scGameAnnalList(msg.gameRecords)
	end
end

function NumberGameAgent:sendPM_NGGainScorePrizeReq(actId, prizeId)
	local req = NumberGameExtension_pb.PM_NGGainScorePrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGainScorePrizeRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scGameSocrePrize()
	end
end

function NumberGameAgent:sendPM_NGGetRankInfoReq(actId)
	local req = NumberGameExtension_pb.PM_NGGetRankInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGetRankInfoRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scGameRankList(msg)
	end
end

function NumberGameAgent:sendPM_NGBeginMatchReq(actId)
	local req = NumberGameExtension_pb.PM_NGBeginMatchReq()

	req.actId = actId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGBeginMatchRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendBeginMatchGame()
	end
end

function NumberGameAgent:sendPM_NGCancelMatchReq()
	local req = NumberGameExtension_pb.PM_NGCancelMatchReq()

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGCancelMatchRes(status, msg)
	NumberGameController.instance:scSendCancelMatchGame(status)
end

function NumberGameAgent:sendPM_NGGuessNumberReq(number)
	local req = NumberGameExtension_pb.PM_NGGuessNumberReq()

	req.number = number

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGuessNumberRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function NumberGameAgent:sendPM_NGLeaveGameReq()
	local req = NumberGameExtension_pb.PM_NGLeaveGameReq()

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGLeaveGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function NumberGameAgent:sendPM_NGSendChatMsgReq(chatMsgId)
	local req = NumberGameExtension_pb.PM_NGSendChatMsgReq()

	req.chatMsgId = chatMsgId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGSendChatMsgRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scGameChatMsg(msg)
	end
end

function NumberGameAgent:sendPM_NGGainProgressPrizeReq(actId, prizeId)
	local req = NumberGameExtension_pb.PM_NGGainProgressPrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function NumberGameAgent:handlePM_NGGainProgressPrizeRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendNGGainProgressPrize()
	end
end

function NumberGameAgent:handlePM_NGNotifyGameStartRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendGameStart(msg)
	end
end

function NumberGameAgent:handlePM_NGNotifyGameOperationRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendGameOperation(msg)
	end
end

function NumberGameAgent:handlePM_NGNotifyGameEndRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendNumberGameOver(msg)
	end
end

function NumberGameAgent:handlePM_NGNotifyMatchFailRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendMatchGameFail()
	end
end

function NumberGameAgent:handlePM_NGNotifyOtherOperationRes(status, msg)
	if status == 0 then
		NumberGameController.instance:scSendGameChatAndLeave(msg)
	end
end

NumberGameAgent.instance = NumberGameAgent.New()

return NumberGameAgent
