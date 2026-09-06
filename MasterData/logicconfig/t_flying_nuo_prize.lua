-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flying_nuo_prize.lua

module("logicconfig.config.t_flying_nuo_prize", package.seeall)

local title = {
	prize = 3,
	leftScore = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"10:17001:100"
	},
	{
		1,
		25,
		"10:17001:200"
	},
	{
		1,
		50,
		"10:17001:300"
	},
	{
		1,
		75,
		"10:17001:400"
	},
	{
		1,
		100,
		"10:17001:500"
	},
	{
		1,
		125,
		"10:17001:600"
	},
	{
		1,
		150,
		"10:17001:700"
	},
	{
		1,
		200,
		"10:17001:800"
	},
	{
		1,
		250,
		"10:17001:900"
	},
	{
		1,
		300,
		"10:17001:1000"
	}
}
local t_flying_nuo_prize = {
	{
		dataList[1],
		[25] = dataList[2],
		[50] = dataList[3],
		[75] = dataList[4],
		[100] = dataList[5],
		[125] = dataList[6],
		[150] = dataList[7],
		[200] = dataList[8],
		[250] = dataList[9],
		[300] = dataList[10]
	}
}

t_flying_nuo_prize.dataList = dataList

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

return t_flying_nuo_prize
