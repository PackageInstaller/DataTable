-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/agent/DrawAndGuessAgent.lua

module("logic.extensions.drawandguess.agent.DrawAndGuessAgent", package.seeall)

local DrawAndGuessAgent = class("DrawAndGuessAgent", BaseAgent)

function DrawAndGuessAgent:sendPM_DrawAndGuessInfoReq(activityId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessInfoRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessInfoRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessMatchReq(activityId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessMatchRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessMatchRes, status)
end

function DrawAndGuessAgent:sendPM_DrawAndGuessCancelMatchReq(activityId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessCancelMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessCancelMatchRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessLeaveGameReq(activityId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessLeaveGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessLeaveGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessLeaveGameRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessSelectQuestionReq(activityId, questionId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessSelectQuestionReq()

	req.activityId = activityId
	req.questionId = questionId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessSelectQuestionRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessSelectQuestionRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessDrawReq(activityId, nodes)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessDrawReq()

	req.activityId = activityId

	for i, v in ipairs(nodes) do
		req.brush.nodes:append(v)
	end

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessDrawRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessDrawRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessAnswerReq(activityId, answer)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessAnswerReq()

	req.activityId = activityId
	req.answer = answer

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessAnswerRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessAnswerRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessChatReq(activityId, emojiId, talkId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessChatReq()

	req.activityId = activityId
	req.emojiId = emojiId
	req.talkId = talkId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessChatRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessChatRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessGainPrizeReq(activityId, prizeId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessGainPrizeRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessGainPrizeRes)
	end
end

function DrawAndGuessAgent:sendPM_DrawAndGuessRankReq(activityId)
	local req = DrawAndGuessExtension_pb.PM_DrawAndGuessRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DrawAndGuessAgent:handlePM_DrawAndGuessRankRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessRankRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessMatchOverTimeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessMatchOverTimeRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessMatchFailRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessMatchFailRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessGameStartRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onGameStartRes(msg)
		DrawandguessController.instance:onGameStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessGameStartRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessDrawStartRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onDrawStartRes(msg)
		DrawandguessController.instance:onDrawStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessDrawStartRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessSyncDrawRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessSyncDrawRes, msg)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessAnswerResultRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onAnswerResultRes(msg)

		if msg.right then
			GlobalDispatcher:dispatch(GlobalNotify.DrawAndGuessAnswerRight, msg.userId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessAnswerResultRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessSelectQuestionStartRes(status, msg)
	if status == 0 then
		DrawandguessModel.instance:onSelectQuestionStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessSelectQuestionStartRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessGameEndRes(status, msg)
	if status == 0 then
		DrawandguessController.instance:onGameEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessGameEndRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessChatRes(status, msg)
	if status == 0 then
		DrawandguessController.instance:onChatRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessChatRes)
	end
end

function DrawAndGuessAgent:handlePM_NotifyDrawAndGuessErrorRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDrawAndGuessErrorRes)
	end
end

DrawAndGuessAgent.instance = DrawAndGuessAgent.New()

return DrawAndGuessAgent
