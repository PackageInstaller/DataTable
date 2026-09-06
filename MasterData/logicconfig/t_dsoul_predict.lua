-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dsoul_predict.lua

module("logicconfig.config.t_dsoul_predict", package.seeall)

local title = {
	itemId = 3,
	name = 4,
	raceId = 6,
	groupId = 2,
	activityId = 1,
	path = 5
}
local dataList = {
	{
		428001,
		1,
		1,
		"帝释天",
		"board_longhunyuzhi_13",
		10142
	},
	{
		428001,
		1,
		2,
		"龙炎",
		"board_longhunyuzhi_14",
		10143
	},
	{
		428001,
		1,
		3,
		"阿瑞斯",
		"board_longhunyuzhi_15",
		10144
	},
	{
		428001,
		1,
		4,
		"修尔",
		"board_longhunyuzhi_12",
		10146
	},
	{
		428001,
		2,
		1,
		"离阳龙脉",
		"board_longhunyuzhi_11",
		16010
	},
	{
		428001,
		2,
		2,
		"凋亡龙脉",
		"board_longhunyuzhi_09",
		18001
	},
	{
		428001,
		2,
		3,
		"解神龙脉",
		"board_longhunyuzhi_10",
		16026
	}
}
local t_dsoul_predict = {
	[428001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7]
		}
	}
}

t_dsoul_predict.dataList = dataList

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

return t_dsoul_predict
