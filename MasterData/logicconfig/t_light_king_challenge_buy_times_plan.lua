-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_buy_times_plan.lua

module("logicconfig.config.t_light_king_challenge_buy_times_plan", package.seeall)

local title = {
	buyTimesPlanId = 1,
	consume = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:170:20"
	},
	{
		1,
		2,
		"105:170:20"
	},
	{
		1,
		3,
		"105:170:20"
	},
	{
		1,
		4,
		"105:170:20"
	},
	{
		1,
		5,
		"105:170:20"
	},
	{
		1,
		6,
		"105:170:20"
	},
	{
		1,
		7,
		"105:170:20"
	},
	{
		1,
		8,
		"105:170:20"
	},
	{
		1,
		9,
		"105:170:20"
	},
	{
		1,
		10,
		"105:170:20"
	},
	{
		3,
		1,
		"105:171:20"
	},
	{
		3,
		2,
		"105:171:20"
	},
	{
		3,
		3,
		"105:171:20"
	},
	{
		3,
		4,
		"105:171:20"
	},
	{
		3,
		5,
		"105:171:20"
	},
	{
		3,
		6,
		"105:171:20"
	},
	{
		3,
		7,
		"105:171:20"
	},
	{
		3,
		8,
		"105:171:20"
	},
	{
		3,
		9,
		"105:171:20"
	},
	{
		3,
		10,
		"105:171:20"
	}
}
local t_light_king_challenge_buy_times_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[3] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_light_king_challenge_buy_times_plan.dataList = dataList

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

return t_light_king_challenge_buy_times_plan
