-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/model/FootballModel.lua

module("logic.extensions.football.model.FootballModel", package.seeall)

local M = class("FootballModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._player1Info = nil
	self._teams = nil
	self._teamScores = {}
	self._userSettles = {}
	self._isRestart = false
	self._isScoreUpdated = false
end

function M:initFootballData(info)
	self._player1Info = info
end

function M:getPlayer1Info()
	return self._player1Info
end

function M:setMatchingResult(teams)
	for i, v in ipairs(teams) do
		if v.members[1].userId ~= self._player1Info.userId then
			self._player2Info = v.members[1]
		end
	end

	self._teams = teams
	self._teamScores = {}
	self._userSettles = {}
end

function M:getPlayer2Info()
	return self._player2Info
end

function M:getTeams()
	return self._teams
end

function M:getTeamScore(teamId)
	return self._teamScores[teamId] or 0
end

function M:getUserSettle(userId)
	return self._userSettles[userId]
end

function M:setRestart(isRestart)
	self._isRestart = isRestart
end

function M:getRestart()
	return self._isRestart
end

function M:getAndResetScoreUpdated()
	local result = self._isScoreUpdated

	self._isScoreUpdated = false

	return result
end

function M:handleBingoPush(pointNOList)
	self._isScoreUpdated = true

	for _, pointNO in ipairs(pointNOList) do
		self._teamScores[pointNO.teamId] = pointNO.total
	end
end

function M:handleSettleResultPush(settleNOList)
	for _, settleNO in ipairs(settleNOList) do
		self._userSettles[settleNO.userId] = settleNO
	end
end

M.instance = M.New()

return M
