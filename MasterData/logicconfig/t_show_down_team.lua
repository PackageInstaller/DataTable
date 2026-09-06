-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_team.lua

module("logicconfig.config.t_show_down_team", package.seeall)

local title = {
	teamIconPlanId = 3,
	defaultTeamIcon = 4,
	teamNameLimit = 5,
	sendMsgCd = 6,
	showInviteCount = 7,
	teamMemberCount = 8,
	activityId = 1,
	defaultTeamName = 2
}
local dataList = {
	{
		360001,
		"第{rank}战队",
		1,
		1,
		5,
		10,
		10,
		5
	},
	{
		360002,
		"第{rank}战队",
		1,
		1,
		5,
		10,
		10,
		5
	},
	{
		360003,
		"第{rank}战队",
		1,
		1,
		5,
		10,
		10,
		5
	},
	{
		360004,
		"第{rank}战队",
		1,
		1,
		5,
		10,
		10,
		5
	},
	{
		360005,
		"第{rank}战队",
		1,
		1,
		5,
		10,
		10,
		5
	}
}
local t_show_down_team = {
	[360001] = dataList[1],
	[360002] = dataList[2],
	[360003] = dataList[3],
	[360004] = dataList[4],
	[360005] = dataList[5]
}

t_show_down_team.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_show_down_team
