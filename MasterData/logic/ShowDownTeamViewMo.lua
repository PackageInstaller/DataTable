-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownTeamViewMo.lua

module("logic.extensions.showdown.data.ShowDownTeamViewMo", package.seeall)

local ShowDownTeamViewMo = class("ShowDownTeamViewMo")

function ShowDownTeamViewMo:ctor()
	self._teamSimpleViewMo = ShowDownTeamSimpleViewMo.New()
	self._teamMemberViewMo = ShowDownTeamMemberViewMo.New()
	self._memberHeadInfoList = {}
	self._result = nil
	self._myScore = 0
	self._winCount = 0
	self._loseCount = 0
end

function ShowDownTeamViewMo:onReset()
	self._teamSimpleViewMo:onReset()
	self._teamMemberViewMo:onReset()
	table.clear(self._memberHeadInfoList)

	self._result = nil
	self._myScore = 0
	self._winCount = 0
	self._loseCount = 0
end

function ShowDownTeamViewMo:updateData(value)
	self._teamSimpleViewMo:updateData(value.teamBaseView)
	self._teamMemberViewMo:updateData(value.teamMemberView)
	table.clear(self._memberHeadInfoList)

	local leaderHeadInfo = value.teamBaseView.leaderHeadInfo

	self._memberHeadInfoList[1] = leaderHeadInfo

	for i, headInfo in ipairs(value.teamMemberView.members) do
		if checknumber(leaderHeadInfo.userId) ~= checknumber(headInfo.userId) then
			table.insert(self._memberHeadInfoList, headInfo)
		end
	end

	local result = value.result

	self._result = value:HasField("result") and result or nil
	self._myScore = result.score
	self._winCount = result.winCount
	self._loseCount = result.loseCount
end

function ShowDownTeamViewMo:getTeamSimpleViewMo()
	return self._teamSimpleViewMo
end

function ShowDownTeamViewMo:getTeamMemberViewMo()
	return self._teamMemberViewMo
end

function ShowDownTeamViewMo:getResult()
	return self._result
end

function ShowDownTeamViewMo:getWinCount()
	return self._winCount
end

function ShowDownTeamViewMo:getLoseCount()
	return self._loseCount
end

function ShowDownTeamViewMo:getMyScore()
	return self._myScore
end

function ShowDownTeamViewMo:getMyRank()
	return self._myRank
end

function ShowDownTeamViewMo:getMemberHeadInfoList()
	return self._memberHeadInfoList
end

return ShowDownTeamViewMo
