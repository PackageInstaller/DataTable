-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_first_pass_rank_prize.lua

module("logicconfig.config.t_first_pass_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	rankPrizePlanId = 1,
	rankRange = 3
}
local dataList = {
	{
		1,
		1,
		{
			1,
			1
		},
		"1名",
		"104:2:1000#8:1:1000000"
	},
	{
		1,
		2,
		{
			2,
			3
		},
		"2~3名",
		"104:2:800#8:1:800000"
	},
	{
		1,
		3,
		{
			4,
			10
		},
		"4~10名",
		"104:2:600#8:1:600000"
	},
	{
		1,
		4,
		{
			11,
			50
		},
		"11~50名",
		"104:2:400#8:1:500000"
	},
	{
		1,
		5,
		{
			51,
			100
		},
		"51~100名",
		"104:2:300#8:1:400000"
	}
}
local t_first_pass_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_first_pass_rank_prize.dataList = dataList

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

return t_first_pass_rank_prize
