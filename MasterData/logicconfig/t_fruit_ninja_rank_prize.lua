-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_rank_prize.lua

module("logicconfig.config.t_fruit_ninja_rank_prize", package.seeall)

local title = {
	rankId = 2,
	prize = 5,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		475001,
		1,
		{
			1,
			10
		},
		"1~10名",
		"13:413:1#104:2:1000#8:1:1000000"
	},
	{
		475001,
		2,
		{
			11,
			50
		},
		"11~50名",
		"13:413:1#104:2:800#8:1:800000"
	},
	{
		475001,
		3,
		{
			51,
			100
		},
		"51~100名",
		"13:413:1#104:2:600#8:1:600000"
	},
	{
		475001,
		4,
		{
			101,
			500
		},
		"101~500名",
		"13:413:1#104:2:400#8:1:400000"
	},
	{
		475001,
		5,
		{
			501,
			1000
		},
		"501~1000名",
		"13:413:1#104:2:200#8:1:200000"
	}
}
local t_fruit_ninja_rank_prize = {
	[475001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_fruit_ninja_rank_prize.dataList = dataList

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

return t_fruit_ninja_rank_prize
