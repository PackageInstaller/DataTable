-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/agent/FriendAgent.lua

module("logic.extensions.friend.agent.FriendAgent", package.seeall)

local M = class("FriendAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetUserListRequest(relationType)
	local msg = FriendExtension_pb.GetUserListRequest()

	msg.type = relationType

	self:sendMsg(msg)
end

function M:handleGetUserListReply(status, msg)
	if status == 0 then
		FriendModel.instance:refreshUserListByAgent(msg.type, msg.user)
		GlobalDispatcher:dispatchEvent(FriendEnum.Relation2Event[msg.type])
	end
end

function M:handleUserListUpdatePush(status, msg)
	if status == 0 then
		FriendModel.instance:refreshUserListByAgent(msg.type, msg.user)
		GlobalDispatcher:dispatchEvent(FriendEnum.Relation2Event[msg.type])
	end
end

function M:sendApplyFriendRequest(userId)
	local msg = FriendExtension_pb.ApplyFriendRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleApplyFriendReply(status, msg)
	if status == 0 then
		FriendController.instance:handleApplyFriendReplyMsg(tonumber(msg.userId))
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_APPLY_SUCCESS)
	else
		MsgBoardController.instance:_handleResultCodeMsg(nil, nil, status)
	end
end

function M:sendAgreeApplyRequest(userIdList)
	local msg = FriendExtension_pb.AgreeApplyRequest()

	for _, userId in ipairs(userIdList) do
		table.insert(msg.userId, userId)
	end

	self:sendMsg(msg)
end

function M:handleAgreeApplyReply(status, msg)
	if status == 0 then
		FriendController.instance:handleAgreeApplyReplyMsg(msg.result)
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_AGREE_APPLY_SUCCESS)
	else
		MsgBoardController.instance:_handleResultCodeMsg(nil, nil, status)
	end
end

function M:sendRefuseApplyRequest(userIdList)
	local msg = FriendExtension_pb.RefuseApplyRequest()

	for _, userId in ipairs(userIdList) do
		table.insert(msg.userId, userId)
	end

	self:sendMsg(msg)
end

function M:handleRefuseApplyReply(status, msg)
	if status == 0 then
		FriendController.instance:handleRefuseApplyReplyMsg(msg.userId)
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_REFUSE_APPLY_SUCCESS)
	end
end

function M:sendRemoveFriendRequest(userId)
	local msg = FriendExtension_pb.RemoveFriendRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleRemoveFriendReply(status, msg)
	if status == 0 then
		FriendController.instance:handleRemoveFriendReplyMsg(tonumber(msg.userId))
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_REMOVE_SUCCESS)
	end
end

function M:sendChangeAliasRequest(userId, alias)
	local msg = FriendExtension_pb.ChangeAliasRequest()

	msg.userId = userId

	if not string.nilorempty(alias) then
		msg.alias = alias
	end

	self:sendMsg(msg)
end

function M:handleChangeAliasReply(status, msg)
	if status == 0 then
		FriendController.instance:handleChangeAliasReplyMsg(tonumber(msg.userId), msg.alias)
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_SET_ALIAS_SUCCESS)
	end
end

function M:sendBlockUserRequest(userId)
	local msg = FriendExtension_pb.BlockUserRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleBlockUserReply(status, msg)
	if status == 0 then
		FriendController.instance:handleBlockUserReplyMsg(tonumber(msg.userId))
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_BLOCK_SUCCESS)
	else
		MsgBoardController.instance:_handleResultCodeMsg(nil, nil, status)
	end
end

function M:sendUnBlockUserRequest(userId)
	local msg = FriendExtension_pb.UnBlockUserRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleUnBlockUserReply(status, msg)
	if status == 0 then
		FriendController.instance:handleUnBlockUserReplyMsg(tonumber(msg.userId))
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_UNBLOCK_SUCCESS)
	end
end

function M:sendReportUserRequest()
	local msg = FriendExtension_pb.ReportUserRequest()

	self:sendMsg(msg)
end

function M:handleReportUserReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendSearchUserRequest(keyword, pageIndex)
	local msg = FriendExtension_pb.SearchUserRequest()

	msg.keyword = keyword
	msg.pageIndex = pageIndex

	self:sendMsg(msg)
end

function M:handleSearchUserReply(status, msg)
	if status == 0 then
		FriendModel.instance:addSearchResult(msg.user)
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_SEARCH_RESULT, true)
	end
end

M.instance = M.New()

return M
