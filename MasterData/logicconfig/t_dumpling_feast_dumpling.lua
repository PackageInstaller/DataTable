-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_dumpling.lua

module("logicconfig.config.t_dumpling_feast_dumpling", package.seeall)

local title = {
	stuffingPath = 7,
	name = 4,
	dumplingId = 2,
	iconPath = 6,
	stuffFillingNeedItem = 3,
	itemPath = 5,
	activityId = 1
}
local dataList = {
	{
		562001,
		1,
		"10:562001:1",
		"芝麻",
		"dumplingfeast/board_tyyh_dj_14",
		"dumplingfeast/board_tyyh_dj_11",
		"dumplingfeast/board_tyyh_dj_08"
	},
	{
		562001,
		2,
		"10:562002:1",
		"花生",
		"dumplingfeast/board_tyyh_dj_15",
		"dumplingfeast/board_tyyh_dj_12",
		"dumplingfeast/board_tyyh_dj_09"
	},
	{
		562001,
		3,
		"10:562003:1",
		"豆沙",
		"dumplingfeast/board_tyyh_dj_16",
		"dumplingfeast/board_tyyh_dj_13",
		"dumplingfeast/board_tyyh_dj_10"
	}
}
local t_dumpling_feast_dumpling = {
	[562001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dumpling_feast_dumpling.dataList = dataList

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

return t_dumpling_feast_dumpling
