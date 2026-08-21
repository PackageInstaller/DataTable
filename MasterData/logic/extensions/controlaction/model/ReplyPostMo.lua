-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/ReplyPostMo.lua

module("logic.extensions.controlaction.model.ReplyPostMo", package.seeall)

local M = class("ReplyPostMo", ThemePostMo)

function M:ctor()
	M.super.ctor(self)

	self._floor = 1
	self._isLike = false
end

function M:init(dataNO, id)
	M.super.init(self, dataNO, id)

	self._floor = dataNO.floor
	self._isLike = dataNO.like
end

function M:getReplyPostCo()
	return self._postCo
end

function M:getFloor()
	return self._floor
end

function M:isLike()
	return self._isLike
end

function M:updateLike(isLike)
	self._isLike = isLike

	if isLike then
		self._likeCount = self._likeCount + 1
	else
		self._likeCount = self._likeCount - 1
	end

	printWarn("====like count====", self._likeCount, isLike)
end

return M
