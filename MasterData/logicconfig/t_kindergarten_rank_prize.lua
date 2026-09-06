-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_rank_prize.lua

module("logicconfig.config.t_kindergarten_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		353001,
		1,
		{
			1,
			1
		},
		"1名",
		"14:262:1#2:165:1#104:2:1000#8:1:2000000"
	},
	{
		353001,
		2,
		{
			2,
			10
		},
		"2~10名",
		"14:262:1#2:165:1#104:2:800#8:1:1600000"
	},
	{
		353001,
		3,
		{
			11,
			50
		},
		"11~50名",
		"14:262:1#2:165:1#104:2:600#8:1:1200000"
	},
	{
		353001,
		4,
		{
			51,
			100
		},
		"51~100名",
		"14:262:1#2:165:1#104:2:400#8:1:1000000"
	},
	{
		353001,
		5,
		{
			101,
			500
		},
		"101~500名",
		"14:262:1#2:165:1#104:2:300#8:1:800000"
	},
	{
		353001,
		6,
		{
			501,
			1000
		},
		"501~1000名",
		"14:262:1#2:165:1#104:2:200#8:1:600000"
	},
	{
		353001,
		7,
		{
			1001,
			5000
		},
		"1001~5000名",
		"2:165:1#104:2:100#8:1:400000"
	}
}
local t_kindergarten_rank_prize = {
	[353001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_kindergarten_rank_prize.dataList = dataList

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

return t_kindergarten_rank_prize
