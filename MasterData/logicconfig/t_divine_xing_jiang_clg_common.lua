-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_common.lua

module("logicconfig.config.t_divine_xing_jiang_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"参数名",
		"值"
	},
	{
		"ACTIVITY_ID",
		"359001"
	},
	{
		"FREE_GAME_NUM",
		"3"
	},
	{
		"GAME_TIME",
		"80"
	},
	{
		"CREATE_TIME_INTERVAL",
		"[2,13]"
	},
	{
		"CREATE_NUM",
		"[1,1]"
	},
	{
		"DROP_ITEM_SPEED",
		"[10,60]"
	},
	{
		"ROTATION_DEGREE_SEC",
		"180"
	},
	{
		"MAX_DROP_ITEM_NUM",
		"10"
	},
	{
		"MAX_HP",
		"3"
	},
	{
		"HORIZONTAL_POLE_MIN_DISTANCE",
		"20"
	},
	{
		"HORIZONTAL_POLE_HEIGHT",
		"50"
	},
	{
		"MOVE_SPEED",
		"65"
	}
}
local t_divine_xing_jiang_clg_common = {
	参数名 = dataList[1],
	ACTIVITY_ID = dataList[2],
	FREE_GAME_NUM = dataList[3],
	GAME_TIME = dataList[4],
	CREATE_TIME_INTERVAL = dataList[5],
	CREATE_NUM = dataList[6],
	DROP_ITEM_SPEED = dataList[7],
	ROTATION_DEGREE_SEC = dataList[8],
	MAX_DROP_ITEM_NUM = dataList[9],
	MAX_HP = dataList[10],
	HORIZONTAL_POLE_MIN_DISTANCE = dataList[11],
	HORIZONTAL_POLE_HEIGHT = dataList[12],
	MOVE_SPEED = dataList[13]
}

t_divine_xing_jiang_clg_common.dataList = dataList

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

return t_divine_xing_jiang_clg_common
