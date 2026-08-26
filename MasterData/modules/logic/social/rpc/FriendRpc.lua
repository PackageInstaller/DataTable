-- chunkname: @modules/logic/social/rpc/FriendRpc.lua

module("modules.logic.social.rpc.FriendRpc", package.seeall)

local FriendRpc = class("FriendRpc", BaseRpc)

function FriendRpc:sendGetFriendInfoListRequest(callback, callbackObj)
	local req = FriendModule_pb.GetFriendInfoListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function FriendRpc:onReceiveGetFriendInfoListReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:updateFriendList(msg.info)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function FriendRpc:sendRemoveFriendRequest(userId)
	local req = FriendModule_pb.RemoveFriendRequest()

	req.friendId = userId

	return self:sendMsg(req)
end

function FriendRpc:onReceiveRemoveFriendReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:removeFriendByUserId(msg.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function FriendRpc:changeDesc(friendId, desc)
	local req = FriendModule_pb.FriendDescChangeRequest()

	req.friendId = friendId
	req.desc = desc

	return self:sendMsg(req)
end

function FriendRpc:onReceiveFriendDescChangeReply(resultCode, msg)
	if resultCode == 0 then
		local friendMo = SocialModel.instance:getPlayerMO(msg.friendId)

		if not friendMo then
			return
		end

		GameFacade.showToast(ToastEnum.FriendDescChange)

		friendMo.desc = msg.desc

		SocialController.instance:dispatchEvent(SocialEvent.FriendDescChange, msg.friendId)
	end
end

function FriendRpc:onReceiveFriendChangePush(resultCode, msg)
	if resultCode == 0 then
		if msg.isAdd then
			local userIds = {}

			table.insert(userIds, msg.friendId)

			local noPlayerMo = SocialModel.instance:addFriendsByUserIds(userIds)

			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownFriend)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChangedSpecial, noPlayerMo)
		else
			SocialModel.instance:removeFriendByUserId(msg.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		end
	end
end

function FriendRpc:sendGetApplyListRequest()
	local req = FriendModule_pb.GetApplyListRequest()

	return self:sendMsg(req)
end

function FriendRpc:onReceiveGetApplyListReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:updateRequestList(msg.info)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function FriendRpc:sendGetRecommendRequest(callback, callbackObj)
	local req = FriendModule_pb.GetRecommendedFriendsRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function FriendRpc:onReceiveGetRecommendedFriendsReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup
		SocialModel.instance.leftSendRecommendReqDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateRecommendList(msg.info)
		SocialController.instance:dispatchEvent(SocialEvent.RecommendChanged)
	end
end

function FriendRpc:sendHandleApplyRequest(friendUserId, isAgree)
	local req = FriendModule_pb.HandleApplyRequest()

	req.friendId = friendUserId
	req.isAgree = isAgree

	return self:sendMsg(req)
end

function FriendRpc:onReceiveHandleApplyReply(resultCode, msg)
	if resultCode == 0 then
		if msg.friendId and msg.friendId ~= 0 and msg.friendId ~= "0" and not string.nilorempty(msg.friendId) then
			SocialModel.instance:removeRequestByUserId(msg.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		end

		if not string.nilorempty(msg.messsage) then
			GameFacade.showToast(ToastEnum.IconId, msg.messsage)
		end
	end
end

function FriendRpc:sendAgreeAllRequest()
	local req = FriendModule_pb.AgreeAllRequest()

	return self:sendMsg(req)
end

function FriendRpc:onReceiveAgreeAllReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:updateRequestList(msg.applyList)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)

		if msg.resultCode and #msg.resultCode > 0 then
			local tipsResultCode = msg.resultCode[1]

			if tipsResultCode < 0 then
				local tipsCfg = lua_toast.configDict[tipsResultCode]

				if not tipsCfg then
					logError("FriendRpc:onReceiveAgreeAllReply 没有为业务错误码：" .. tipsResultCode .. " 配置提示语！！《P飘字表》- export_飘字表")

					return
				end

				GameFacade.showToast(tipsResultCode)
			end
		end
	end
end

function FriendRpc:sendRejectAllRequest()
	local req = FriendModule_pb.RejectAllRequest()

	return self:sendMsg(req)
end

function FriendRpc:onReceiveRejectAllReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:clearRequestList()
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function FriendRpc:sendApplyRequest(userId, callback, callbackObj)
	local req = FriendModule_pb.ApplyRequest()

	req.friendId = userId

	return self:sendMsg(req, callback, callbackObj)
end

function FriendRpc:onReceiveApplyReply(resultCode, msg)
	if resultCode == 0 then
		if not string.nilorempty(msg.messsage) then
			GameFacade.showToast(ToastEnum.IconId, msg.messsage)
		end

		if msg.friendId and msg.friendId ~= 0 and msg.friendId ~= "0" and not string.nilorempty(msg.friendId) then
			GameFacade.showToast(ToastEnum.OnReceiveApplyFriend)
			SocialModel.instance:removeBlackListByUserId(msg.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function FriendRpc:sendSearchRequest(searchValue, callback, callbackObj)
	local req = FriendModule_pb.SearchRequest()

	req.value = searchValue

	return self:sendMsg(req, callback, callbackObj)
end

function FriendRpc:onReceiveSearchReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateSearchList(msg.info)
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
	end
end

function FriendRpc:sendGetBlacklistRequest()
	local req = FriendModule_pb.GetBlacklistRequest()

	return self:sendMsg(req)
end

function FriendRpc:onReceiveGetBlacklistReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:updateBlackList(msg.info)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function FriendRpc:sendAddBlacklistRequest(userId)
	local req = FriendModule_pb.AddBlacklistRequest()

	req.friendId = userId

	return self:sendMsg(req)
end

function FriendRpc:onReceiveAddBlacklistReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:addBlackListByUserId(msg.friendId)
		SocialModel.instance:removeRequestByUserId(msg.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function FriendRpc:sendRemoveBlacklistRequest(friendUserId)
	local req = FriendModule_pb.RemoveBlacklistRequest()

	req.friendId = friendUserId

	return self:sendMsg(req)
end

function FriendRpc:onReceiveRemoveBlacklistReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:removeBlackListByUserId(msg.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function FriendRpc:onReceiveBlacklistChangePush(resultCode, msg)
	if resultCode == 0 then
		if msg.change > 0 then
			SocialModel.instance:addBlackListByUserId(msg.userId)
			SocialModel.instance:removeRequestByUserId(msg.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownBlackList)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		elseif msg.change < 0 then
			SocialModel.instance:removeBlackListByUserId(msg.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function FriendRpc:sendLoadFriendInfosRequest(callback, callbackObj)
	local req = FriendModule_pb.LoadFriendInfosRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function FriendRpc:onReceiveLoadFriendInfosReply(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:updateSocialInfosList(msg.friendIds, msg.blackListIds)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

FriendRpc.instance = FriendRpc.New()

return FriendRpc
