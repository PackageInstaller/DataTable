-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_collect_prize_plan.lua

module("logicconfig.config.t_jigsaw_collect_prize_plan", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	planId = 1,
	pieceReq = 3
}
local dataList = {
	{
		1,
		1,
		4,
		"4:35:9"
	},
	{
		1,
		2,
		6,
		"8:1:9999"
	},
	{
		1,
		3,
		8,
		"4:3:9"
	},
	{
		1,
		4,
		12,
		"4:502:9"
	},
	{
		1,
		5,
		16,
		"4:30002:9"
	},
	{
		1,
		6,
		20,
		"104:2:99"
	},
	{
		1,
		7,
		24,
		"4:35:9"
	},
	{
		1,
		8,
		28,
		"8:1:9999"
	},
	{
		1,
		9,
		30,
		"4:35:9"
	},
	{
		1,
		10,
		32,
		"8:1:99999"
	},
	{
		2,
		1,
		4,
		"4:35:9"
	},
	{
		2,
		2,
		6,
		"8:1:9999"
	},
	{
		2,
		3,
		8,
		"4:3:9"
	},
	{
		2,
		4,
		12,
		"4:502:9"
	},
	{
		2,
		5,
		16,
		"4:30002:9"
	},
	{
		2,
		6,
		20,
		"104:2:99"
	},
	{
		2,
		7,
		24,
		"4:35:9"
	},
	{
		2,
		8,
		28,
		"8:1:9999"
	},
	{
		2,
		9,
		30,
		"4:35:9"
	},
	{
		2,
		10,
		32,
		"8:1:99999"
	}
}
local t_jigsaw_collect_prize_plan = {
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
	{
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

t_jigsaw_collect_prize_plan.dataList = dataList

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

return t_jigsaw_collect_prize_plan
