-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/agent/RankAgent.lua

module("logic.extensions.rank.agent.RankAgent", package.seeall)

local M = class("RankAgent", BaseAgent)

function M:sendGetRankListRequest(rankId, startIndex, endIndex)
	self._rankId = rankId
	self._startIndex = startIndex
	self._endIndex = endIndex

	local req = RankExtension_pb.GetRankListRequest()

	req.rankId = rankId
	req.startIndex = startIndex
	req.endIndex = endIndex

	self:sendMsg(req)
end

function M:handleGetRankListReply(status, msg)
	if status == 0 then
		RankNetModel.instance:updateRankInfo(self._rankId, msg.entry, msg.myEntry)
		GlobalDispatcher:dispatchEvent(EventType.RANK_INFO_UPDATE, self._rankId)
	end
end

function M:sendGetRankInfoRequest()
	local req = RankExtension_pb.GetRankInfoRequest()

	self:sendMsg(req)
end

function M:handleGetRankInfoReply(status, msg)
	if status == 0 then
		RankNetModel.instance:updateValidRankData(msg.validRanks)
		GlobalDispatcher:dispatchEvent(EventType.GET_VALID_RANK, msg.validRanks)
	end
end

function M:sendGetDungeonTeamRequest(rankId, userId)
	local req = RankExtension_pb.GetDungeonTeamRequest()

	req.rankId = rankId
	req.userId = userId

	self:sendMsg(req)
end

function M:handleGetDungeonTeamReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.GET_RANK_CHARACTER_DETAIL, msg.team)
	end
end

function M:_getValidRankInfo()
	local msg = {}

	msg.validRanks = {
		10001,
		10002,
		10003,
		10011,
		10005,
		10006
	}

	return msg
end

function M:_getRankInfo(rankId, startIndex, endIndex)
	local msg = {}

	msg.entry = {}

	local rankType = RankConfig.instance:getRankType(rankId)

	for i = startIndex, endIndex do
		local mo = self._typeToFunc[rankType](i)

		table.insert(msg.entry, mo)
	end

	msg.myEntry = self._typeToFunc[rankType](200)

	return msg
end

function M._getCollectionMo(rank)
	local mo = {}

	mo.collect = {}
	mo.userId = rank
	mo.rank = rank
	mo.portrait = 100013
	mo.nickname = tostring(rank)
	mo.collect.ratio = 0.43

	return mo
end

function M._getDungeonMo(rank)
	local mo = {}

	mo.dungeon = {}
	mo.dungeon.heros = {}
	mo.userId = rank
	mo.rank = rank
	mo.portrait = 100013
	mo.nickname = tostring(rank)
	mo.dungeon.dungeonId = 110314
	mo.dungeon.round = 5
	mo.dungeon.step = 40

	local heroCount = rank % 10

	for i = 1, heroCount do
		mo.dungeon.heros[i] = {
			lv = 23,
			code = 2000002
		}
	end

	return mo
end

function M._getPlayerLvMo(rank)
	local mo = {}

	mo.level = {}
	mo.userId = rank
	mo.rank = rank
	mo.portrait = 100013
	mo.nickname = tostring(rank)
	mo.level.level = 15

	return mo
end

function M._getAirStudioMo(rank)
	local mo = {}

	mo.airRodeo = {}
	mo.userId = rank
	mo.rank = rank
	mo.portrait = 100013
	mo.nickname = tostring(rank)
	mo.airRodeo.lv = 3
	mo.airRodeo.score = 500

	return mo
end

M._typeToFunc = {
	[CommEnum.RankEnum.Collection] = M._getCollectionMo,
	[CommEnum.RankEnum.Level] = M._getPlayerLvMo,
	[CommEnum.RankEnum.ClimbTower] = M._getDungeonMo,
	[CommEnum.RankEnum.AirWorkShop] = M._getAirStudioMo,
	[CommEnum.RankEnum.MainLine] = M._getDungeonMo
}
M.instance = M.New()

return M
