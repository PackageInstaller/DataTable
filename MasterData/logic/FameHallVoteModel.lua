-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/model/FameHallVoteModel.lua

module("logic.extensions.famehallvote.model.FameHallVoteModel", package.seeall)

local FameHallVoteModel = class("FameHallVoteModel", BaseModel)

function FameHallVoteModel:onInit()
	self:onReset()
end

function FameHallVoteModel:onReset()
	self._infos = {}
	self._playerInfoMap = {}
end

function FameHallVoteModel:getInfo(activityId)
	return self._infos[activityId]
end

function FameHallVoteModel:getPlayerInfoMap(activityId)
	return self._playerInfoMap[activityId]
end

function FameHallVoteModel:handlePM_FameHallVoteGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._playerInfoMap[msg.activityId] = self._playerInfoMap[msg.activityId] or {}

	local playerInfoMap = self._playerInfoMap[msg.activityId]
	local info = self._infos[msg.activityId]

	info.dailyVotePlayers = info.dailyVotePlayers or {}
	info.gainPrizeIds = info.gainPrizeIds or {}
	info.playerList = info.playerList or {}

	for _, playerInfo in ipairs(info.playerList) do
		playerInfoMap[playerInfo.headInfo.userId] = playerInfo
	end
end

function FameHallVoteModel:handlePM_FameHallVoteRes(msg)
	local info = self._infos[msg.activityId]
	local playerInfoMap = self._playerInfoMap[msg.activityId]

	info.progress = info.progress + 1

	table.insert(info.dailyVotePlayers, msg.voteUserId)

	playerInfoMap[msg.voteUserId].voteCount = playerInfoMap[msg.voteUserId].voteCount + 1
end

function FameHallVoteModel:handlePM_FameHallVoteGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	table.insert(info.gainPrizeIds, msg.prizeId)
end

FameHallVoteModel.instance = FameHallVoteModel.New()

return FameHallVoteModel
