-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter2_boss_kill.lua

module("logicconfig.config.t_luyngarde_chapter2_boss_kill", package.seeall)

local title = {
	prize = 3,
	title = 4,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		466001,
		1,
		"10:466003:10000",
		"第一天"
	},
	{
		466001,
		2,
		"10:466003:7500",
		"第二天"
	},
	{
		466001,
		3,
		"10:466003:5000",
		"第三天"
	},
	{
		466001,
		4,
		"10:466003:4000",
		"第四天"
	},
	{
		466001,
		5,
		"10:466003:3000",
		"第五天"
	},
	{
		466001,
		6,
		"10:466003:2000",
		"第六天"
	}
}
local t_luyngarde_chapter2_boss_kill = {
	[466001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_luyngarde_chapter2_boss_kill.dataList = dataList

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

return t_luyngarde_chapter2_boss_kill
