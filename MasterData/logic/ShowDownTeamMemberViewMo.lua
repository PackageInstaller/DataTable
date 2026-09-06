-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownTeamMemberViewMo.lua

module("logic.extensions.showdown.data.ShowDownTeamMemberViewMo", package.seeall)

local ShowDownTeamMemberViewMo = class("ShowDownTeamMemberViewMo")

function ShowDownTeamMemberViewMo:ctor()
	self._headInfoList = {}
end

function ShowDownTeamMemberViewMo:onReset()
	table.clear(self._headInfoList)
end

function ShowDownTeamMemberViewMo:updateData(value)
	table.clear(self._headInfoList)

	for _, headInfo in ipairs(value.members) do
		table.insert(self._headInfoList, headInfo)
	end
end

function ShowDownTeamMemberViewMo:getHeadInfoList()
	return self._headInfoList
end

return ShowDownTeamMemberViewMo
