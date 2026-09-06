-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_camp_rank_prize.lua

module("logicconfig.config.t_element_spark_camp_rank_prize", package.seeall)

local title = {
	prize = 5,
	commanderPrize = 6,
	id = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		311001,
		1,
		{
			1,
			1
		},
		"第1名",
		"2:136:1#10:311001:20000#104:2:1000#8:1:1000000",
		"2:138:1#4:510243:5"
	},
	{
		311001,
		2,
		{
			2,
			2
		},
		"第2名",
		"2:136:1#10:311001:15000#104:2:800#8:1:800000",
		"2:138:1#4:510243:4"
	},
	{
		311001,
		3,
		{
			3,
			3
		},
		"第3名",
		"2:136:1#10:311001:10000#104:2:600#8:1:600000",
		"2:138:1#4:510243:3"
	},
	{
		311001,
		4,
		{
			4,
			4
		},
		"第4名",
		"2:136:1#10:311001:5000#104:2:400#8:1:400000",
		"2:138:1#4:510243:2"
	},
	{
		311002,
		1,
		{
			1,
			1
		},
		"第1名",
		"2:136:1#10:311001:20000#104:2:1000#8:1:1000000",
		"2:138:1#4:510243:5"
	},
	{
		311002,
		2,
		{
			2,
			2
		},
		"第2名",
		"2:136:1#10:311001:15000#104:2:800#8:1:800000",
		"2:138:1#4:510243:4"
	},
	{
		311002,
		3,
		{
			3,
			3
		},
		"第3名",
		"2:136:1#10:311001:10000#104:2:600#8:1:600000",
		"2:138:1#4:510243:3"
	},
	{
		311002,
		4,
		{
			4,
			4
		},
		"第4名",
		"2:136:1#10:311001:5000#104:2:400#8:1:400000",
		"2:138:1#4:510243:2"
	}
}
local t_element_spark_camp_rank_prize = {
	[311001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[311002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_element_spark_camp_rank_prize.dataList = dataList

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

return t_element_spark_camp_rank_prize
