-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkStatMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkStatMO", package.seeall)

local M = class("AirWorkStatMO")

function M:ctor()
	self._playCount = 0
	self._likeCount = 0
	self._commentCount = 0
	self._passRate = 0
	self._point = 0
	self._tagIdList = false
	self._createTime = 0
end

function M:initByAgent(StatNO)
	self._playCount = StatNO.playCount
	self._likeCount = StatNO.likeCount
	self._commentCount = StatNO.commentCount
	self._passRate = StatNO.passRate
	self._point = StatNO.point
	self._tagIdList = {}

	for i, v in ipairs(StatNO.tagId) do
		table.insert(self._tagIdList, v)
	end

	self._createTime = StatNO.createTime
end

function M:getPlayCount()
	return self._playCount
end

function M:getLikeCount()
	return self._likeCount
end

function M:getCommentCount()
	return self._commentCount
end

function M:getPassRate()
	return self._passRate
end

function M:getPoint()
	return self._point
end

function M:getTags()
	return self._tagIdList or {}
end

function M:getCreateTime()
	return self._createTime
end

return M
