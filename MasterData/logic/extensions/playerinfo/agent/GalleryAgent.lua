-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/agent/GalleryAgent.lua

module("logic.extensions.playerinfo.agent.GalleryAgent", package.seeall)

local M = class("GalleryAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendUnlockPlotMemoryRequest(ids)
	if ids and #ids > 0 then
		local msg = GalleryExtension_pb.UnlockPlotMemoryRequest()

		for _, id in ipairs(ids) do
			table.insert(msg.id, id)
		end

		self:sendMsg(msg)
	end
end

function M:handleUnlockPlotMemoryReply(status, msg)
	if status == 0 then
		local ids = msg.id

		HandbookController.instance:onUnlockPlotMemoryReply(ids)
	elseif enableErrorLog then
		printError("GalleryAgent:handleUnlockPlotMemoryReply(status, playerInfo)", status)
	end
end

function M:sendGetMonsterCommentRequest(monsterId)
	local msg = GalleryExtension_pb.GetMonsterCommentRequest()

	msg.monsterId = monsterId
	self._monsterIdForComment = monsterId

	self:sendMsg(msg)
end

function M:handleGetMonsterCommentReply(status, msg)
	if status == 0 then
		HandbookController.instance:onGetMonsterCommentReply(self._monsterIdForComment, msg)

		self._monsterIdForComment = nil
	elseif enableErrorLog then
		printError("GalleryAgent:handleGetMonsterCommentReply(status, playerInfo)", status)
	end
end

function M:sendCommitMonsterCommentRequest(monsterId, star, tagIds)
	local msg = GalleryExtension_pb.CommitMonsterCommentRequest()

	msg.monsterId = monsterId
	msg.star = star

	if tagIds and #tagIds > 0 then
		for _, tagId in ipairs(tagIds) do
			table.insert(msg.tagId, tagId)
		end
	end

	self._infoCommitMonsterComment = {
		monsterId = monsterId,
		myStar = star,
		myTagIds = tagIds
	}

	self:sendMsg(msg)
end

function M:handleCommitMonsterCommentReply(status, msg)
	if status == 0 then
		HandbookController.instance:onCommitMonsterCommentReply(self._infoCommitMonsterComment)
		self:sendGetMonsterCommentRequest(self._infoCommitMonsterComment.monsterId)

		self._infoCommitMonsterComment = nil
	elseif enableErrorLog then
		printError("GalleryAgent:handleCommitMonsterCommentReply(status, playerInfo)", status)
	end
end

M.instance = M.New()

return M
