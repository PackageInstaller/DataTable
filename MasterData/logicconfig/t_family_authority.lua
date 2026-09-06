-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_authority.lua

module("logicconfig.config.t_family_authority", package.seeall)

local title = {
	member2 = 4,
	member3 = 5,
	authority = 1,
	member0 = 2,
	member4 = 6,
	member1 = 3
}
local dataList = {
	{
		"APPOINT_DISMISS_0",
		1,
		0,
		0,
		0,
		0
	},
	{
		"APPOINT_DISMISS_1",
		1,
		0,
		0,
		0,
		0
	},
	{
		"APPOINT_DISMISS_2",
		1,
		1,
		0,
		0,
		0
	},
	{
		"APPOINT_DISMISS_3",
		1,
		1,
		1,
		0,
		0
	},
	{
		"APPOINT_DISMISS_4",
		1,
		1,
		1,
		0,
		0
	},
	{
		"ALLOW_APPLY",
		1,
		1,
		1,
		0,
		0
	},
	{
		"KICK_MEMBER",
		1,
		1,
		1,
		0,
		0
	},
	{
		"DISMISS_FAMILY",
		1,
		0,
		0,
		0,
		0
	},
	{
		"MODIFY_INFO",
		1,
		1,
		0,
		0,
		0
	},
	{
		"MODIFY_DECLARATION",
		1,
		1,
		0,
		0,
		0
	},
	{
		"BEGIN_BOSS",
		1,
		1,
		0,
		0,
		0
	},
	{
		"JOIN_TEAM_PLAY_WAR_ZONE",
		1,
		1,
		0,
		0,
		0
	},
	{
		"MANAGE",
		1,
		1,
		0,
		0,
		0
	}
}
local t_family_authority = {
	APPOINT_DISMISS_0 = dataList[1],
	APPOINT_DISMISS_1 = dataList[2],
	APPOINT_DISMISS_2 = dataList[3],
	APPOINT_DISMISS_3 = dataList[4],
	APPOINT_DISMISS_4 = dataList[5],
	ALLOW_APPLY = dataList[6],
	KICK_MEMBER = dataList[7],
	DISMISS_FAMILY = dataList[8],
	MODIFY_INFO = dataList[9],
	MODIFY_DECLARATION = dataList[10],
	BEGIN_BOSS = dataList[11],
	JOIN_TEAM_PLAY_WAR_ZONE = dataList[12],
	MANAGE = dataList[13]
}

t_family_authority.dataList = dataList

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

return t_family_authority
