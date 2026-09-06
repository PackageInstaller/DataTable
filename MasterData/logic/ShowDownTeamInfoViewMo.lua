-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownTeamInfoViewMo.lua

module("logic.extensions.showdown.data.ShowDownTeamInfoViewMo", package.seeall)

local ShowDownTeamInfoViewMo = class("ShowDownTeamInfoViewMo")

function ShowDownTeamInfoViewMo:ctor()
	self._teamId = 0
	self._teamName = ""
	self._teamLogo = 0
end

function ShowDownTeamInfoViewMo:onReset()
	self._teamId = 0
	self._teamName = ""
	self._teamLogo = 0
end

function ShowDownTeamInfoViewMo:updateData(value)
	self._teamId = value.teamId
	self._teamName = value.teamName
	self._teamLogo = value.teamLogo
end

function ShowDownTeamInfoViewMo:getTeamId()
	return self._teamId
end

function ShowDownTeamInfoViewMo:getTeamName()
	return self._teamName
end

function ShowDownTeamInfoViewMo:getTeamLogo()
	return self._teamLogo
end

return ShowDownTeamInfoViewMo
