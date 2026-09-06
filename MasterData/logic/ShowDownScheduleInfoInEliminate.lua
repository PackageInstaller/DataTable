-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownScheduleInfoInEliminate.lua

module("logic.extensions.showdown.data.ShowDownScheduleInfoInEliminate", package.seeall)

local ShowDownScheduleInfoInEliminate = class("ShowDownScheduleInfoInEliminate")

function ShowDownScheduleInfoInEliminate:ctor()
	self._battleRecordList = {}
	self._winCount = 0
	self._loseCount = 0
	self._myScore = 0
	self._myRank = 0
	self._teamViewMo = ShowDownTeamViewMo.New()
	self._stepMatchViewMoList = {}
end

function ShowDownScheduleInfoInEliminate:onReset()
	table.clear(self._battleRecordList)

	self._winCount = 0
	self._loseCount = 0
	self._myScore = 0
	self._myRank = 0

	self._teamViewMo:onReset()
end

function ShowDownScheduleInfoInEliminate:updateData(value)
	local myTeamInfo = value.myTeamInfo
	local groupMatchScheduel = value.groupMatchScheduel

	if myTeamInfo then
		local myInfo = myTeamInfo.myInfo

		for i, v in ipairs(myInfo.records) do
			if self._battleRecordList[i] == nil then
				self._battleRecordList[i] = ShowDownBattleRecord.New()
			end

			self._battleRecordList[i]:updateData(v)
		end

		for i = #myInfo.records + 1, #self._battleRecordList do
			self._battleRecordList[i] = nil
		end

		table.sort(self._battleRecordList, function(a, b)
			return a:getRecordTimeStamp() > b:getRecordTimeStamp()
		end)

		self._winCount = myInfo.winLoseMark.left
		self._loseCount = myInfo.winLoseMark.right
		self._myScore = myInfo.myScore
		self._myRank = myInfo.myRank
	else
		table.clear(self._battleRecordList)

		self._winCount = 0
		self._loseCount = 0
		self._myScore = 0
		self._myRank = 0
	end

	if groupMatchScheduel then
		local teamView = groupMatchScheduel.teamView
		local stepMatchList = groupMatchScheduel.stepMatchList

		self._teamViewMo:updateData(teamView)

		for i, v in ipairs(stepMatchList) do
			if self._stepMatchViewMoList[i] == nil then
				self._stepMatchViewMoList[i] = ShowDownStepMatchViewMo.New()
			end

			self._stepMatchViewMoList[i]:updateData(v)
		end

		for i = #stepMatchList + 1, #self._stepMatchViewMoList do
			self._stepMatchViewMoList[i] = nil
		end
	else
		self._teamViewMo:onReset()
		table.clear(self._stepMatchViewMoList)
	end
end

function ShowDownScheduleInfoInEliminate:getBattleRecordList()
	return self._battleRecordList
end

function ShowDownScheduleInfoInEliminate:getWinCount()
	return self._winCount
end

function ShowDownScheduleInfoInEliminate:getLoseCount()
	return self._loseCount
end

function ShowDownScheduleInfoInEliminate:getMyScore()
	return self._myScore
end

function ShowDownScheduleInfoInEliminate:getMyRank()
	return self._myRank
end

function ShowDownScheduleInfoInEliminate:getTeamViewMo()
	return self._teamViewMo
end

function ShowDownScheduleInfoInEliminate:getTeamSimpleViewMo()
	return self._teamViewMo:getTeamSimpleViewMo()
end

function ShowDownScheduleInfoInEliminate:getTeamMemberViewMo()
	return self._teamViewMo:getTeamMemberViewMo()
end

function ShowDownScheduleInfoInEliminate:getStepMatchViewMoList()
	return self._stepMatchViewMoList
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfScore()
	return self._teamViewMo:getMyScore()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfRank()
	return self._teamViewMo:getMyRank()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfWinCount()
	return self._teamViewMo:getWinCount()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfLoseCount()
	return self._teamViewMo:getLoseCount()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfTeamId()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamId()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfTeamName()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamName()
end

function ShowDownScheduleInfoInEliminate:getMyTeamOfTeamLogo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamLogo()
end

function ShowDownScheduleInfoInEliminate:getMyTeamHeatValue()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getHeatValue()
end

function ShowDownScheduleInfoInEliminate:getMyTeamMemberCount()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getMemberCount()
end

function ShowDownScheduleInfoInEliminate:getMyTeamLeaderHeadInfo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getLeaderHeadInfo()
end

function ShowDownScheduleInfoInEliminate:isLeaderMe()
	local leaderHeadInfo = self:getMyTeamLeaderHeadInfo()
	local leaderUserId = checknumber(leaderHeadInfo and leaderHeadInfo.userId)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	return leaderUserId == myUserId
end

function ShowDownScheduleInfoInEliminate:getGroupId()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getGroupId()
end

function ShowDownScheduleInfoInEliminate:getMemberHeadInfoList()
	return self:getTeamViewMo():getMemberHeadInfoList()
end

return ShowDownScheduleInfoInEliminate
