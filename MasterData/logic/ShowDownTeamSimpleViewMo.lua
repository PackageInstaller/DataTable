-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownTeamSimpleViewMo.lua

module("logic.extensions.showdown.data.ShowDownTeamSimpleViewMo", package.seeall)

local ShowDownTeamSimpleViewMo = class("ShowDownTeamSimpleViewMo")

function ShowDownTeamSimpleViewMo:ctor()
	self._teamInfoViewMo = ShowDownTeamInfoViewMo.New()
	self._heatValue = 0
	self._memberCount = 0
	self._leaderHeadInfo = nil
	self._groupId = 0
end

function ShowDownTeamSimpleViewMo:onReset()
	self._teamInfoViewMo:onReset()

	self._heatValue = 0
	self._memberCount = 0
	self._leaderHeadInfo = nil
	self._groupId = 0
end

function ShowDownTeamSimpleViewMo:updateData(value)
	self._teamInfoViewMo:updateData(value.teamInfo)

	self._heatValue = value.heatValue
	self._memberCount = value.memberCount
	self._leaderHeadInfo = value.leaderHeadInfo
	self._groupId = value.groupId
end

function ShowDownTeamSimpleViewMo:getTeamInfoViewMo()
	return self._teamInfoViewMo
end

function ShowDownTeamSimpleViewMo:getTeamId()
	return self._teamInfoViewMo:getTeamId()
end

function ShowDownTeamSimpleViewMo:getTeamName()
	return self._teamInfoViewMo:getTeamName()
end

function ShowDownTeamSimpleViewMo:getTeamLogo()
	return self._teamInfoViewMo:getTeamLogo()
end

function ShowDownTeamSimpleViewMo:getHeatValue()
	return self._heatValue
end

function ShowDownTeamSimpleViewMo:getMemberCount()
	return self._memberCount
end

function ShowDownTeamSimpleViewMo:getLeaderHeadInfo()
	return self._leaderHeadInfo
end

function ShowDownTeamSimpleViewMo:getGroupId()
	return self._groupId
end

return ShowDownTeamSimpleViewMo
