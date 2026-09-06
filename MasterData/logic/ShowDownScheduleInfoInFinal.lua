-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownScheduleInfoInFinal.lua

module("logic.extensions.showdown.data.ShowDownScheduleInfoInFinal", package.seeall)

local ShowDownScheduleInfoInFinal = class("ShowDownScheduleInfoInFinal")

function ShowDownScheduleInfoInFinal:ctor()
	self._teamViewMo = ShowDownTeamViewMo.New()
	self._stepMatchViewMoList = {}
end

function ShowDownScheduleInfoInFinal:onReset()
	self._teamViewMo:onReset()
end

function ShowDownScheduleInfoInFinal:updateData(value)
	local groupMatchScheduel = value.groupMatchScheduel

	self._teamViewMo:updateData(groupMatchScheduel.teamView)

	local stepMatchList = groupMatchScheduel.stepMatchList

	for i, v in ipairs(stepMatchList) do
		local mo = self._stepMatchViewMoList[i]

		if mo == nil then
			self._stepMatchViewMoList[i] = ShowDownStepMatchViewMo.New()
			mo = self._stepMatchViewMoList[i]
		end

		mo:updateData(v)
	end

	for i = #stepMatchList + 1, #self._stepMatchViewMoList do
		self._stepMatchViewMoList[i] = nil
	end
end

function ShowDownScheduleInfoInFinal:getTeamViewMo()
	return self._teamViewMo
end

function ShowDownScheduleInfoInFinal:getTeamSimpleViewMo()
	return self._teamViewMo:getTeamSimpleViewMo()
end

function ShowDownScheduleInfoInFinal:getTeamMemberViewMo()
	return self._teamViewMo:getTeamMemberViewMo()
end

function ShowDownScheduleInfoInFinal:getStepMatchViewMoList()
	return self._stepMatchViewMoList
end

function ShowDownScheduleInfoInFinal:getMyTeamOfScore()
	return self._teamViewMo:getMyScore()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfRank()
	return self._teamViewMo:getMyRank()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfWinCount()
	return self._teamViewMo:getWinCount()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfLoseCount()
	return self._teamViewMo:getLoseCount()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfTeamId()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamId()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfTeamName()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamName()
end

function ShowDownScheduleInfoInFinal:getMyTeamOfTeamLogo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getTeamInfoViewMo():getTeamLogo()
end

function ShowDownScheduleInfoInFinal:getMyTeamHeatValue()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getHeatValue()
end

function ShowDownScheduleInfoInFinal:getMyTeamMemberCount()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getMemberCount()
end

function ShowDownScheduleInfoInFinal:getMyTeamLeaderHeadInfo()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getLeaderHeadInfo()
end

function ShowDownScheduleInfoInFinal:isLeaderMe()
	local leaderHeadInfo = self:getMyTeamLeaderHeadInfo()
	local leaderUserId = checknumber(leaderHeadInfo and leaderHeadInfo.userId)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	return leaderUserId == myUserId
end

function ShowDownScheduleInfoInFinal:getGroupId()
	local teamSimpleViewMo = self:getTeamSimpleViewMo()

	return teamSimpleViewMo:getGroupId()
end

function ShowDownScheduleInfoInFinal:getMemberHeadInfoList()
	return self:getTeamViewMo():getMemberHeadInfoList()
end

return ShowDownScheduleInfoInFinal
