-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_common.lua

module("logicconfig.config.t_magic_school_pvp_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_TIME",
		"08:00:00#14:00:00,17:00:00#23:30:00"
	},
	{
		"TEAM_MEMBER_NUM",
		"3"
	},
	{
		"MATCH_TIME",
		"60"
	},
	{
		"SWITCH_PLACE_TIME",
		"60"
	},
	{
		"SWITCH_REQ_WAIT_TIME",
		"5"
	},
	{
		"BATTLE_TIME",
		"20"
	},
	{
		"SELECT_BUFF_TIME",
		"8"
	},
	{
		"CAMP_ID_TO_GROUP_ID",
		"1_65,2_66"
	}
}
local t_magic_school_pvp_common = {
	OPEN_TIME = dataList[1],
	TEAM_MEMBER_NUM = dataList[2],
	MATCH_TIME = dataList[3],
	SWITCH_PLACE_TIME = dataList[4],
	SWITCH_REQ_WAIT_TIME = dataList[5],
	BATTLE_TIME = dataList[6],
	SELECT_BUFF_TIME = dataList[7],
	CAMP_ID_TO_GROUP_ID = dataList[8]
}

t_magic_school_pvp_common.dataList = dataList

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

return t_magic_school_pvp_common
