-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/agent/FriendAgent.lua

module("logic.extensions.friend.agent.FriendAgent", package.seeall)

local FriendAgent = class("FriendAgent", BaseAgent)
local handlers = {}

function FriendAgent:doHandler(handlerType)
	local t = handlers[handlerType]

	if t then
		local handler = t[1]
		local handlerTarget = t[2]

		if handler then
			if handlerTarget then
				handler(handlerTarget)
			else
				handler()
			end
		end
	end
end

function FriendAgent:_callback()
	if self._handle then
		if self._handlerTarget then
			self._handle(self._handlerTarget)
		else
			self._handle()
		end
	end

	self._handle = nil
	self._handlerTarget = nil
end

function FriendAgent:sendGetBuddyInfoReq()
	local req = BuddyExtension_pb.GetBuddyInfoReq()

	self:sendMsg(req)
end

function FriendAgent:handleGetBuddyInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadFriends===back")

	if status == 0 then
		FriendModel.instance:onGetBuddyInfoRes(msg)
	end
end

function FriendAgent:sendGetBuddyRequestInfoReq(notOpen)
	local req = BuddyExtension_pb.GetBuddyRequestInfoReq()

	self:sendMsg(req)
end

function FriendAgent:handleGetBuddyRequestInfoRes(status, msg)
	if status == 0 then
		FriendModel.instance:onGetBuddyRequestInfoRes(msg)
		FriendController.instance:localNotify("FriendApplyUpdate")
	end
end

function FriendAgent:sendRefreshRecommendBuddiesReq(handler, handlerTarget)
	local req = BuddyExtension_pb.RefreshRecommendBuddiesReq()

	self:sendMsg(req)

	handlers.RefreshRecommendBuddies = {
		handler,
		handlerTarget
	}
end

function FriendAgent:handleRefreshRecommendBuddiesRes(status, msg)
	if status == 0 then
		FriendModel.instance:onRefreshRecommendBuddiesRes(msg)
		self:doHandler("RefreshRecommendBuddies")
	end
end

function FriendAgent:sendRequestAddBuddyReq(id)
	local req = BuddyExtension_pb.RequestAddBuddyReq()

	req.buddyId = id

	self:sendMsg(req)
end

function FriendAgent:handleRequestAddBuddyRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("已向对方发送申请，请耐心等待处理"))
		FriendModel.instance:onRequestAddBuddyRes(msg)
	end

	FriendController.instance:localNotify("RefreshRecomend")
end

function FriendAgent:sendHandleBuddyRequestReq(id, isAgree)
	local req = BuddyExtension_pb.HandleBuddyRequestReq()

	req.requestUserId = id
	req.action = isAgree and 1 or 2

	self:sendMsg(req)
end

function FriendAgent:handleHandleBuddyRequestRes(status, msg)
	if status == 0 then
		FriendModel.instance:onHandleBuddyRequestRes(msg)
	end
end

function FriendAgent:sendBatchHandleBuddyRequestReq(ids, isAgree)
	local req = BuddyExtension_pb.BatchHandleBuddyRequestReq()

	for _, id in ipairs(ids) do
		id = tonumber(id)

		table.insert(req.requestUserIds, id)
	end

	req.action = isAgree and 1 or 2

	self:sendMsg(req)
end

function FriendAgent:handleBatchHandleBuddyRequestRes(status, msg)
	if status == 0 then
		FriendModel.instance:onBatchHandleBuddyRequestRes(msg.requestuserIds)
	end
end

function FriendAgent:sendSearchUserReq(text, searchUserId, handler, handlerTarget)
	local req = BuddyExtension_pb.SearchUserReq()

	if not string.nilorempty(text) then
		req.searchInfo = text
	elseif not string.nilorempty(searchUserId) then
		req.searchUserId = searchUserId
	else
		return
	end

	self:sendMsg(req)

	handlers.SearchUser = {
		handler,
		handlerTarget
	}
end

function FriendAgent:handleSearchUserRes(status, msg)
	if status == 0 then
		FriendModel.instance:onSearchUserRes(msg)
		self:doHandler("SearchUser")
	end
end

function FriendAgent:handleNotifyNewBuddyRes(status, msg)
	if status == 0 then
		FriendModel.instance:onHandleNotifyNewBuddyRes(msg)
		FriendController.instance:localNotify("NewBuddyAdd")

		local id = msg.newBuddy.simpleInfo.headInfo.userId

		FriendModel.instance:removeRequest(id)
		FriendModel.instance:RmMyApplyById(id)
		GlobalDispatcher:dispatch(GlobalNotify.FriendAdd, id)
		FloatWordMgr.instance:show(msg.auditor == true and lang("add_friend_success") or string.format(lang("agree_apply"), msg.newBuddy.simpleInfo.headInfo.userName))
		FriendController.instance:localNotify("FriendApplyUpdate")
	end
end

function FriendAgent:sendRemoveBuddyReq(idList)
	local req = BuddyExtension_pb.RemoveBuddyReq()

	for i, v2 in ipairs(idList) do
		req.buddyList:append(v2)
	end

	self:sendMsg(req)
end

function FriendAgent:handleRemoveBuddyRes(status, msg)
	if status == 0 then
		local list = msg.buddyList
		local isDelFriend = false

		for i, id in ipairs(list) do
			local mo = FriendModel.instance:getFriendMo(id)

			if mo:IsFriend() then
				FriendModel.instance:DelFriend(id)

				isDelFriend = true
			elseif mo:IsStranger() then
				FriendModel.instance:RemoveStranger(id)
			elseif mo:IsBlacklist() then
				FriendModel.instance:RemoveBlackList(id)
				FloatWordMgr.instance:show(string.format(lang("remove_blacklist_success"), mo:getValue("name")))
			end
		end

		if isDelFriend then
			FloatWordMgr.instance:show(lang("delete_success"))
			GlobalDispatcher:dispatch(GlobalNotify.FriendRemoveList)
		end
	end
end

function FriendAgent:sendAddBlackListReq(id, callback)
	self._addBlackCall = callback

	local req = BuddyExtension_pb.AddBlackListReq()

	req.buddyId = id

	self:sendMsg(req)
end

function FriendAgent:handleAddBlackListRes(status, msg)
	if status == 0 then
		FriendModel.instance:AddBlackList(msg.buddyId)
		FloatWordMgr.instance:show(lang("add_blacklist_success"))

		if msg.fullPopId ~= nil then
			FriendModel.instance:RemoveBlackList(msg.fullPopId)
		end

		if self._addBlackCall ~= nil then
			self._addBlackCall()
		end
	end
end

function FriendAgent:sendRemoveBlackListReq(id)
	local req = BuddyExtension_pb.RemoveBlackListReq()

	req.buddyId = id

	self:sendMsg(req)
end

function FriendAgent:sendSendHeartsReq(buddyIds_i64_Ary)
	local req = BuddyExtension_pb.SendHeartsReq()

	for i, v3 in ipairs(buddyIds_i64_Ary) do
		req.buddyIds:append(v3)
	end

	self:sendMsg(req)
end

function FriendAgent:handleSendHeartsRes(status, msg)
	if status == 0 then
		local buddyIds = msg.buddyIds

		FriendModel.instance:onSendHeart(buddyIds)
		GlobalDispatcher:dispatch(GlobalNotify.SendOrGainHeart, true, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SendHeart_assistant, status, msg)
end

function FriendAgent:sendGainHeartsReq(buddyIds_i64_Ary)
	local req = BuddyExtension_pb.GainHeartsReq()

	for i, v2 in ipairs(buddyIds_i64_Ary) do
		req.buddyIds:append(v2)
	end

	self:sendMsg(req)
end

function FriendAgent:handleGainHeartsRes(status, msg)
	if status == 0 then
		local buddyids = msg.buddyIds

		FriendModel.instance:onGainHeart(buddyids)
		GlobalDispatcher:dispatch(GlobalNotify.SendOrGainHeart, false, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.GainHeart_assistant, status, msg)
end

function FriendAgent:handleNotifyNewHeartRes(status, msg)
	if status == 0 then
		local buddyid = msg.buddyId
		local mo = FriendModel.instance:getFriendMo(buddyid)

		FriendModel.instance:onNewHeart(buddyid)
		GlobalDispatcher:dispatch(GlobalNotify.GainNewHeart, buddyid)
	end
end

function FriendAgent:sendPopStrangerReq(ids)
	local req = BuddyExtension_pb.PopStrangerReq()

	for _, id in ipairs(ids) do
		table.insert(req, id)
	end

	self:sendMsg(req)
end

function FriendAgent:handlePopStrangerRes(status, msg)
	if status == 0 then
		FriendModel.instance:RemoveStranger(msg.buddyId)
	end
end

function FriendAgent:handleNotifyNewBuddyReqeustRes(status, msg)
	if status == 0 then
		self:sendGetBuddyRequestInfoReq(true)
	end
end

function FriendAgent:handleNotifyBeDelBuddyRes(status, msg)
	if status == 0 then
		FriendModel.instance:DelFriend(msg.delBuddyId)
	end
end

function FriendAgent:handleNotifyBuddyInfoChangedRes(status, msg)
	if status == 0 then
		local friendMo = FriendModel.instance:getFriendMo(msg.buddyId)

		if friendMo ~= nil then
			friendMo:ResetZoneInfo(msg)
		end

		GlobalDispatcher:dispatch(GlobalNotify.FriendStateChange, msg.buddyId)
	end
end

function FriendAgent:handleNotifyNewStrangerRes(status, msg)
	if status == 0 then
		FriendModel.instance:onHandleNotifyNewBuddyRes(msg, true)
	end
end

function FriendAgent:sendGetFetterInfoReq(buddyId)
	local req = BuddyExtension_pb.GetFetterInfoReq()

	req.buddyId = buddyId

	self:sendMsg(req)
end

function FriendAgent:handleGetFetterInfoRes(status, msg)
	if status == 0 then
		FriendController.instance:handleGetBuddyFetterInfo(msg)
	end
end

function FriendAgent:handleNotifyBuddyLoginRes(status, msg)
	if status == 0 then
		FriendController.instance:handleNotifyBuddyLogin(msg)
	end
end

function FriendAgent:handleNotifyFetter(status, msg)
	if status == 0 then
		FriendController.instance:handleUdateBuddyFetter(msg)
	end
end

function FriendAgent:sendGetTeamFetterInfoReq(type, teammateUserId)
	local req = BuddyExtension_pb.GetTeamFetterInfoReq()

	req.type = checkint(type)

	for i, id in ipairs(teammateUserId) do
		req.teammateUserId:append(id)
	end

	self:sendMsg(req)
end

function FriendAgent:handleGetTeamFetterInfoRes(status, msg)
	if status == 0 then
		FormTeamController.instance:handleGetCurFetter(msg)
	end
end

function FriendAgent:sendGetBuddyRelationshipReq(relTypeList)
	local req = BuddyExtension_pb.GetBuddyRelationshipReq()

	for _, relType in ipairs(relTypeList) do
		req.type:append(relType)
	end

	self:sendMsg(req)
end

function FriendAgent:handleGetBuddyRelationshipRes(status, msg)
	if status == 0 then
		FriendController.instance:handleGetBuddyRelationshipRes(msg)
	end
end

FriendAgent.instance = FriendAgent.New()

return FriendAgent
