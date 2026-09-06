-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_progress.lua

module("logicconfig.config.t_camp_battle_progress", package.seeall)

local title = {
	id = 1,
	time = 2,
	desc = 3
}
local dataList = {
	{
		1,
		"2022-09-02 05:00:00",
		"阵营选择"
	},
	{
		2,
		"2022-09-03 05:00:00",
		"阵营鼓舞"
	},
	{
		3,
		"2022-09-09 05:00:00",
		"阵营比拼"
	},
	{
		4,
		"2022-09-15 05:00:00",
		"瓜分大奖"
	},
	{
		5,
		"2022-09-16 05:00:00",
		"阵营选择"
	},
	{
		6,
		"2022-09-17 05:00:00",
		"阵营鼓舞"
	},
	{
		7,
		"2022-09-23 05:00:00",
		"阵营比拼"
	},
	{
		8,
		"2022-09-30 05:00:00",
		"瓜分大奖"
	}
}
local t_camp_battle_progress = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_camp_battle_progress.dataList = dataList

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

return t_camp_battle_progress
