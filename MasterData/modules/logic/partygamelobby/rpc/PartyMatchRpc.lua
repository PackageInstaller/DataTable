-- chunkname: @modules/logic/partygamelobby/rpc/PartyMatchRpc.lua

module("modules.logic.partygamelobby.rpc.PartyMatchRpc", package.seeall)

local PartyMatchRpc = class("PartyMatchRpc", BaseRpc)

function PartyMatchRpc:sendPartyServerListRequest(callback, callbackObj)
	local req = PartyMatchModule_pb.PartyServerListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PartyMatchRpc:onReceivePartyServerListReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:onReceivePartyServerListReply(msg)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.onReceivePartyServerListReply, msg)
end

function PartyMatchRpc:simpleSingleStartPartyMatchReq()
	PartyGameRoomModel.instance:pingServerList(self._onPingDoneSingleStartPartyMatch, self)
end

function PartyMatchRpc:_onPingDoneSingleStartPartyMatch()
	self:sendSingleStartPartyMatchRequest(PartyGameRoomModel.getResVersion())
end

function PartyMatchRpc:onReceiveMatchStatusPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local matchStatus = msg.matchStatus
	local matchTime = msg.matchTime

	PartyGameRoomModel.instance:setMatchTime(matchTime)
	self:setMatchStatus(matchStatus)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MatchStatusPush)
end

function PartyMatchRpc:setMatchStatus(matchStatus)
	if matchStatus == 1 then
		PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.StartMatch)
	elseif matchStatus == 0 then
		PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.NoMatch)
	else
		logError("PartyMatchRpc:onReceiveMatchStatusPush error matchStatus:" .. matchStatus)
	end
end

function PartyMatchRpc:onReceiveMatchInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local version = msg.version

	PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.MatchSuccess)
	PartyGameRoomModel.instance:setMatchInfo(msg)

	if version == -1 then
		PartyGameRpc.instance:onReceiveMatchInfoPush(resultCode, msg)
		PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MatchInfoPush)
		logError("PartyMatchRpc:onReceiveMatchInfoPush gm 匹配成功")

		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.PartyGameLobby then
		local resVersion = PartyGameRoomModel.getResVersion()

		if version == resVersion then
			PartyGameRpc.instance:onReceiveMatchInfoPush(resultCode, msg)
		else
			PartyGameLobbyController.instance:setSkipGame(PartyGameLobbyEnum.SkipGame.Verison)
			logNormal(string.format("PartyMatchRpc:onReceiveMatchInfoPush roomVersion:%s resVersion:%s not match", version, resVersion))
		end
	else
		logNormal("不在PartyGameLobby场景，不处理matchInfoPush")
	end

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MatchInfoPush)
	PartyGameStatHelper.instance:partyMatch(StatEnum.PartyGameEnum.MatchSuccess)
end

function PartyMatchRpc:onReceiveMatchFailPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.NoMatch)
	GameFacade.showToast(ToastEnum.ParyGameMatchFail)
end

function PartyMatchRpc:sendSingleStartPartyMatchRequest(version, area)
	local req = PartyMatchModule_pb.SingleStartPartyMatchRequest()

	req.version = version
	req.area = area or PartyGameRoomModel.instance:getFastestAreaId()

	self:sendMsg(req)
end

function PartyMatchRpc:onReceiveSingleStartPartyMatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:onReceiveStartPartyMatchReply(resultCode, msg)
end

function PartyMatchRpc:sendStartPartyMatchRequest(userId, roomId)
	local req = PartyMatchModule_pb.StartPartyMatchRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function PartyMatchRpc:onReceiveStartPartyMatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId
	local waitingStatus = msg.waitingStatus
	local matchTime = msg.matchTime

	PartyGameRoomModel.instance:setMatchTime(matchTime)

	if not PartyGameRoomModel.instance:inGameRoom() then
		PartyGameRoomModel.instance:createRoom(roomId, PartyGameRoomModel.getResVersion())
	end

	if waitingStatus == 0 then
		PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.StartMatch)
	elseif waitingStatus == 1 then
		PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.Matching)
	else
		logError("PartyMatchRpc:onReceiveStartPartyMatchReply error waitingStatus:" .. waitingStatus)
	end

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.StartPartyMatchReply)
	PartyGameStatHelper.instance:partyMatch(StatEnum.PartyGameEnum.StartMatch)
end

function PartyMatchRpc:sendCancelPartyMatchRequest(userId, roomId)
	local req = PartyMatchModule_pb.CancelPartyMatchRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function PartyMatchRpc:onReceiveCancelPartyMatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:setMatchStatus(PartyGameLobbyEnum.MatchStatus.NoMatch)
	PartyGameStatHelper.instance:partyMatch(StatEnum.PartyGameEnum.CancelMatch)
end

function PartyMatchRpc:onReceivePartyNeedLogoutPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local needLogoutUserIds = msg.needLogoutUserIds

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.PartyNeedLogoutPush, needLogoutUserIds)
end

function PartyMatchRpc:sendTriggerPartyResultRequest()
	local req = PartyMatchModule_pb.TriggerPartyResultRequest()

	self:sendMsg(req)
end

function PartyMatchRpc:onReceiveTriggerPartyResultReply(resultCode, msg)
	return
end

PartyMatchRpc.instance = PartyMatchRpc.New()

return PartyMatchRpc
