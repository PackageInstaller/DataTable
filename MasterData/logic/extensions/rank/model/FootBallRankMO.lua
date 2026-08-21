-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/FootBallRankMO.lua

module("logic.extensions.rank.model.FootBallRankMO", package.seeall)

local M = class("FootBallRankMO")

function M:ctor()
	self.rankId = nil
	self.userId = nil
	self.rank = nil
	self.nickname = nil
	self.portrait = nil
	self.score = nil
	self.win = nil
	self.draw = nil
	self.fail = nil
end

function M:updateData(rankId, data)
	self.rankId = rankId
	self.userId = data.userId
	self.rank = data.rank
	self.nickname = data.nickname
	self.portrait = data.portrait
	self.score = data.score
	self.win = data.win
	self.draw = data.draw
	self.fail = data.fail
end

return M
