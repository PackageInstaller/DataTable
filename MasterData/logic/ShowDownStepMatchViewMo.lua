-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownStepMatchViewMo.lua

module("logic.extensions.showdown.data.ShowDownStepMatchViewMo", package.seeall)

local ShowDownStepMatchViewMo = class("ShowDownStepMatchViewMo")

function ShowDownStepMatchViewMo:ctor()
	self._stepId = 0
	self._teamViewMo = ShowDownTeamViewMo.New()
	self._result = nil
	self._myScore = 0
	self._winCount = 0
	self._loseCount = 0
end

function ShowDownStepMatchViewMo:onReset()
	self._teamViewMo:onReset()

	self._result = nil
	self._myScore = 0
	self._winCount = 0
	self._loseCount = 0
end

function ShowDownStepMatchViewMo:updateData(value)
	self._stepId = value.stepId

	self._teamViewMo:updateData(value.opponentTeamView)

	local result = value.result

	self._result = value:HasField("result") and result or nil
	self._myScore = result.score
	self._winCount = result.winCount
	self._loseCount = result.loseCount
end

function ShowDownStepMatchViewMo:getStepId()
	return self._stepId
end

function ShowDownStepMatchViewMo:getTeamViewMo()
	return self._teamViewMo
end

function ShowDownStepMatchViewMo:getTeamSimpleViewMo()
	return self._teamViewMo:getTeamSimpleViewMo()
end

function ShowDownStepMatchViewMo:getTeamMemberViewMo()
	return self._teamViewMo:getTeamMemberViewMo()
end

function ShowDownStepMatchViewMo:getResult()
	return self._result
end

function ShowDownStepMatchViewMo:getWinCount()
	return self._winCount
end

function ShowDownStepMatchViewMo:getLoseCount()
	return self._loseCount
end

function ShowDownStepMatchViewMo:getMyScore()
	return self._myScore
end

function ShowDownStepMatchViewMo:getMyRank()
	return self._myRank
end

function ShowDownStepMatchViewMo:getTeamInfoViewMo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo()
end

function ShowDownStepMatchViewMo:getHeatValue()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getHeatValue()
end

function ShowDownStepMatchViewMo:getMemberCount()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getMemberCount()
end

function ShowDownStepMatchViewMo:getLeaderHeadInfo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getLeaderHeadInfo()
end

function ShowDownStepMatchViewMo:getGroupId()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getGroupId()
end

function ShowDownStepMatchViewMo:getTeamId()
	local teamInfoViewMo = self:getTeamInfoViewMo()

	return teamInfoViewMo:getTeamId()
end

function ShowDownStepMatchViewMo:getTeamName()
	local teamInfoViewMo = self:getTeamInfoViewMo()

	return teamInfoViewMo:getTeamName()
end

function ShowDownStepMatchViewMo:getTeamLogo()
	local teamInfoViewMo = self:getTeamInfoViewMo()

	return teamInfoViewMo:getTeamLogo()
end

function ShowDownStepMatchViewMo:getMemberHeadInfoList()
	return self:getTeamViewMo():getMemberHeadInfoList()
end

return ShowDownStepMatchViewMo
