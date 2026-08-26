-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/rpc/Activity225Rpc.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.rpc.Activity225Rpc", package.seeall)

local Activity225Rpc = class("Activity225Rpc", BaseRpc)

function Activity225Rpc:onInit()
	return
end

function Activity225Rpc:reInit()
	return
end

function Activity225Rpc:sendGetAct225InfoRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.GetAct225InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveGetAct225InfoReply(resultCode, msg)
	if resultCode == 0 then
		ChatRoomModel.instance:setAct225Info(msg)
		ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnInfoUpdate)
	end
end

function Activity225Rpc:sendAct225EnterChatRoomRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.Act225EnterChatRoomRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225EnterChatRoomReply(resultCode, msg)
	if resultCode == 0 then
		ChatRoomModel.instance:onEnterChatRoomReply(msg)
	end
end

function Activity225Rpc:sendAct225LeaveChatRoomRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.Act225LeaveChatRoomRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225LeaveChatRoomReply(resultCode, msg)
	if resultCode == 0 then
		ChatRoomModel.instance:setRoomUid("0")
	end
end

function Activity225Rpc:sendAct225ChatRequest(activityId, emojiId, callback, callbackObj)
	local req = Activity225Module_pb.Act225ChatRequest()

	req.activityId = activityId
	req.emojiId = emojiId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225ChatReply(resultCode, msg)
	if resultCode == 0 then
		local infoData = {}

		infoData.activityId = ChatRoomModel.instance:getCurActivityId()
		infoData.uid = ChatRoomModel.instance:getRoomUid()
		infoData.emojiId = msg.emojiId
		infoData.sendUserId = PlayerModel.instance:getMyUserId()

		ChatRoomController.instance:dispatchEvent(ChatRoomEvent.ShowChatEmoji, infoData)
	end
end

function Activity225Rpc:onReceiveAct225ChatPush(resultCode, msg)
	if resultCode == 0 then
		ChatRoomController.instance:dispatchEvent(ChatRoomEvent.ShowChatEmoji, msg)
	end
end

function Activity225Rpc:sendAct225MoveRequest(activityId, x, y, callback, callbackObj)
	local req = Activity225Module_pb.Act225MoveRequest()

	req.activityId = activityId
	req.x = x
	req.y = y

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225MoveReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity225Rpc:onReceiveAct225ChatRoomPush(resultCode, msg)
	if resultCode == 0 then
		ChatRoomModel.instance:onChatRoomInfoPush(msg)
		ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnChatRoomUserInfoChange)
	end
end

function Activity225Rpc:sendAct225RedEnvelopeRainStartRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.Act225RedEnvelopeRainStartRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225RedEnvelopeRainStartReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Activity225Rpc:sendAct225RedEnvelopeRainSettleRequest(activityId, num, callback, callbackObj)
	local req = Activity225Module_pb.Act225RedEnvelopeRainSettleRequest()

	req.activityId = activityId
	req.redEnvelopeNum = num

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225RedEnvelopeRainSettleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ChatRoomModel.instance:setLastRainId(msg.lastRedEnvelopeRainId)
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnLucyRainBack)
end

function Activity225Rpc:sendAct225QAndARequest(activityId, option, callback, callbackObj)
	local req = Activity225Module_pb.Act225QAndARequest()

	req.activityId = activityId
	req.option = option

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225QAndAReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ChatRoomModel.instance:setCurQuestionId(msg.questionId)
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnQAndABack, msg.option)
end

function Activity225Rpc:sendAct225RockPaperScissorsRequest(activityId, result, callback, callbackObj)
	local req = Activity225Module_pb.Act225RockPaperScissorsRequest()

	req.activityId = activityId
	req.result = result

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225RockPaperScissorsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ChatRoomFingerGameModel.instance:setCurDayFingerGameCount(msg.rockPaperScissorsDailyCount)
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnFingerGameBack)
end

function Activity225Rpc:sendAct225BonusSceneRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.Act225BonusSceneRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225BonusSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Activity225Rpc:sendAct225ApplyFriendRequest(activityId, callback, callbackObj)
	local req = Activity225Module_pb.Act225ApplyFriendRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity225Rpc:onReceiveAct225ApplyFriendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

Activity225Rpc.instance = Activity225Rpc.New()

return Activity225Rpc
