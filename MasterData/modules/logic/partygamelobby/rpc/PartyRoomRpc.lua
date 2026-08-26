-- chunkname: @modules/logic/partygamelobby/rpc/PartyRoomRpc.lua

module("modules.logic.partygamelobby.rpc.PartyRoomRpc", package.seeall)

local PartyRoomRpc = class("PartyRoomRpc", BaseRpc)

function PartyRoomRpc:sendCheckPartyRoomInfoRequest(roomId, callback, callbackObj)
	local req = PartyRoomModule_pb.CheckPartyRoomInfoRequest()

	req.roomId = roomId

	return self:sendMsg(req, callback, callbackObj)
end

function PartyRoomRpc:onReceiveCheckPartyRoomInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.onReceiveCheckPartyRoomInfoReply, msg)
end

function PartyRoomRpc:simpleJoinPartyRoomReq(roomId)
	PartyGameRoomModel.instance:pingServerList()
	self.sendCheckPartyRoomInfoRequest(self, roomId, self._onSimpleJoinPartyRoomReqCb, self)
end

function PartyRoomRpc:_onSimpleJoinPartyRoomReqCb(_, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId

	self:sendJoinPartyRoomRequest(PartyGameRoomModel.getResVersion(), roomId)
end

function PartyRoomRpc:simpleCreatePartyRoomReq()
	PartyGameRoomModel.instance:pingServerList()
	PartyRoomRpc.instance:sendCreatePartyRoomRequest(PartyGameRoomModel.getResVersion())
end

function PartyRoomRpc:sendCreatePartyRoomRequest(version, area)
	local req = PartyRoomModule_pb.CreatePartyRoomRequest()

	req.version = version
	req.area = area or PartyGameRoomModel.instance:getFastestAreaId()

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveCreatePartyRoomReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId
	local version = msg.version

	PartyGameRoomModel.instance:createRoom(roomId, version)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.CreatePartyRoom)
end

function PartyRoomRpc:sendGetPartyRoomInfoRequest(callback, callbackObj)
	local req = PartyRoomModule_pb.GetPartyRoomInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PartyRoomRpc:onReceiveGetPartyRoomInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId
	local playerInfos = msg.playerInfos
	local matchStatus = msg.matchStatus

	if msg:HasField("matchInfo") then
		if not msg.matchInfo then
			local matchInfo
			local matchTime = msg.matchTime

			PartyGameRoomModel.instance:setRoomId(roomId)
			PartyGameRoomModel.instance:setMatchTime(matchTime)
			PartyMatchRpc.instance:setMatchStatus(matchStatus)
			PartyGameRoomModel.instance:setPlayerInfos(playerInfos)
			PartyGameRoomModel.instance:setMatchInfo(matchInfo)
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.CustomGetPartyRoomInfo, matchInfo)
		end
	end
end

function PartyRoomRpc:sendClearAndRefreshPartyRoomInfoRequest(callback, callbackObj)
	local req = PartyRoomModule_pb.ClearAndRefreshPartyRoomInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PartyRoomRpc:onReceiveClearAndRefreshPartyRoomInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId
	local playerInfos = msg.playerInfos
	local matchStatus = msg.matchStatus

	if msg:HasField("matchInfo") then
		if not msg.matchInfo then
			local matchInfo
			local matchTime = msg.matchTime

			PartyGameRoomModel.instance:setMatchTime(matchTime)
			PartyMatchRpc.instance:setMatchStatus(matchStatus)
			PartyGameRoomModel.instance:setRoomId(roomId)
			PartyGameRoomModel.instance:setPlayerInfos(playerInfos)
			PartyGameRoomModel.instance:setMatchInfo(matchInfo)
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.CustomGetPartyRoomInfo, matchInfo)
		end
	end
end

function PartyRoomRpc:sendUpdatePartyClientVersionRequest(roomId, version)
	local req = PartyRoomModule_pb.UpdatePartyClientVersionRequest()

	req.roomId = roomId
	req.version = version

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveUpdatePartyClientVersionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:sendClearSuccessMatchInfoRequest()
	local req = PartyRoomModule_pb.ClearSuccessMatchInfoRequest()

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveClearSuccessMatchInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:setMatchInfo(nil)
end

function PartyRoomRpc:sendJoinPartyRoomRequest(version, roomId, area)
	local req = PartyRoomModule_pb.JoinPartyRoomRequest()

	req.version = version
	req.roomId = roomId
	req.area = area or PartyGameRoomModel.instance:getFastestAreaId()

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveJoinPartyRoomReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = msg.roomId
	local playerInfos = msg.playerInfos

	PartyGameRoomModel.instance:setRoomId(roomId)
	PartyGameRoomModel.instance:setPlayerInfos(playerInfos)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.JoinPartyRoom)
end

function PartyRoomRpc:sendChangePartyRoomStatusRequest(userId, roomId, status)
	local req = PartyRoomModule_pb.ChangePartyRoomStatusRequest()

	req.roomId = roomId
	req.status = status

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveChangePartyRoomStatusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local status = msg.status
	local myUserId = PlayerModel.instance:getMyUserId()

	PartyGameRoomModel.instance:changePlayerStatus(myUserId, status)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ChangePartyRoomStatus)
end

function PartyRoomRpc:sendExitPartyRoomRequest(userId, roomId)
	local req = PartyRoomModule_pb.ExitPartyRoomRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveExitPartyRoomReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:clearRoom()
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ExitPartyRoom)
end

function PartyRoomRpc:sendChangeRoomOwnerRequest(userId, roomId, newOwnerUserId)
	local req = PartyRoomModule_pb.ChangeRoomOwnerRequest()

	req.roomId = roomId
	req.newOwnerUserId = newOwnerUserId

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveChangeRoomOwnerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local newOwnerUserId = msg.newOwnerUserId

	PartyGameRoomModel.instance:ChangeRoomOwner(newOwnerUserId)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ChangeRoomOwner)
end

function PartyRoomRpc:sendKickOutPlayerRequest(userId, roomId, kickOutUserId)
	local req = PartyRoomModule_pb.KickOutPlayerRequest()

	req.roomId = roomId
	req.kickOutUserId = kickOutUserId

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveKickOutPlayerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local kickOutUserId = msg.kickOutUserId

	PartyGameRoomModel.instance:KickOutPlayer(kickOutUserId)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.KickOutPlayer)
end

function PartyRoomRpc:sendGetInviteListRequest(userId, roomId)
	local req = PartyRoomModule_pb.GetInviteListRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveGetInviteListReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local friendInfos = msg.friendInfos

	PartyGameRoomModel.instance:setFriendInfos(friendInfos)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.GetInviteList)
end

function PartyRoomRpc:sendResetPartyInviteStateRequest()
	local req = PartyRoomModule_pb.ResetPartyInviteStateRequest()

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveResetPartyInviteStateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:sendInviteFriendRequest(userId, roomId, friendUserId)
	local req = PartyRoomModule_pb.InviteFriendRequest()

	req.roomId = roomId
	req.friendUserId = friendUserId

	self:sendMsg(req)
	PartyGameStatHelper.instance:partyGameInvite(StatEnum.PartyGameEnum.SendInvite, friendUserId, roomId)
end

function PartyRoomRpc:onReceiveInviteFriendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local friendInfo = msg.friendInfo

	PartyGameRoomModel.instance:updateFriendInfo(friendInfo)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.InviteFriend)
end

function PartyRoomRpc:sendRefuseInviteRequest(userId, roomId, refuseUserId, refuseType)
	local req = PartyRoomModule_pb.RefuseInviteRequest()

	req.roomId = roomId
	req.refuseUserId = refuseUserId
	req.refuseType = refuseType or PartyGameLobbyEnum.RefuseType.Passive

	self:sendMsg(req)
	PartyGameStatHelper.instance:partyGameInvite(StatEnum.PartyGameEnum.RefuseInvite, refuseUserId, roomId)
end

function PartyRoomRpc:onReceiveRefuseInviteReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:sendPartyRoomInteractRequest(userId, roomId, interactUserIds, emoj)
	local req = PartyRoomModule_pb.PartyRoomInteractRequest()

	req.roomId = roomId

	for i, id in ipairs(interactUserIds) do
		table.insert(req.interactUserIds, id)
	end

	req.interaction.emoj = emoj

	self:sendMsg(req)
end

function PartyRoomRpc:onReceivePartyRoomInteractReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:sendPartyRoomPosSyncRequest(roomId, interactUserIds, x, y)
	local req = PartyRoomModule_pb.PartyRoomPosSyncRequest()

	req.roomId = roomId

	for i, id in ipairs(interactUserIds) do
		table.insert(req.interactUserIds, id)
	end

	req.partyRoomPos.x = x
	req.partyRoomPos.y = y

	self:sendMsg(req)
end

function PartyRoomRpc:onReceivePartyRoomPosSyncReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:sendUploadPartyClothInfoRequest(roomId)
	local req = PartyRoomModule_pb.UploadPartyClothInfoRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function PartyRoomRpc:onReceiveUploadPartyClothInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PartyRoomRpc:onReceiveGetUploadPartyClothInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local fromUserId = msg.fromUserId
	local wearClothIds = msg.wearClothIds

	PartyGameRoomModel.instance:changePlayerWearClothIds(fromUserId, wearClothIds)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ChangePlayerWearClothIds, fromUserId)
end

function PartyRoomRpc:onReceiveGetInteractionPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local fromUserId = msg.fromUserId
	local roomId = msg.roomId
	local interaction = msg.interaction

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.GetInteractionPush, {
		fromUserId = fromUserId,
		roomId = roomId,
		interaction = interaction
	})
end

function PartyRoomRpc:onReceiveGetPosSyncPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local fromUserId = msg.fromUserId
	local roomId = msg.roomId
	local pos = msg.pos

	PartyGameRoomModel.instance:updatePlayerPos(fromUserId, pos.x, pos.y)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.GetPosPush, {
		fromUserId = fromUserId,
		roomId = roomId,
		interaction = pos
	})
end

function PartyRoomRpc:onReceiveGetKickedOutPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PartyGameRoomModel.instance:clearRoom()
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.KickedOutPush)
	GameFacade.showToast(ToastEnum.ParyGameLeaveTip)
end

function PartyRoomRpc:onReceiveGetPartyInvitePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local fromUserId = msg.fromUserId
	local roomId = msg.roomId

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.PartyInvitePush, {
		fromUserId = fromUserId,
		roomId = roomId
	})
end

function PartyRoomRpc:onReceiveGetPartyInviteRefusePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local fromUserId = msg.fromUserId
	local roomId = msg.roomId
	local refuseType = msg.refuseType

	PartyGameRoomModel.instance:addRefuseInfo(roomId, fromUserId, refuseType)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.PartyInviteRefusePush)
end

function PartyRoomRpc:onReceivePartyRoomInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local playerInfos = msg.playerInfos

	PartyGameRoomModel.instance:setPlayerInfos(playerInfos, true)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.PartyRoomInfoPush)
end

PartyRoomRpc.instance = PartyRoomRpc.New()

return PartyRoomRpc
