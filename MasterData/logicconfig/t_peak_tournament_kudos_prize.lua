-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_kudos_prize.lua

module("logicconfig.config.t_peak_tournament_kudos_prize", package.seeall)

local title = {
	id = 2,
	kudosPlan = 1,
	rank = 3,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"4:93007:1"
	},
	{
		1,
		2,
		2,
		"4:93008:1"
	},
	{
		1,
		3,
		3,
		"4:93009:1"
	},
	{
		1,
		4,
		4,
		"4:93010:1"
	},
	{
		1,
		5,
		8,
		"4:93011:1"
	},
	{
		1,
		6,
		16,
		"4:93012:1"
	},
	{
		1,
		7,
		32,
		"4:93013:1"
	},
	{
		1,
		8,
		64,
		"4:93014:1"
	},
	{
		1,
		9,
		128,
		"4:93015:1"
	},
	{
		2,
		1,
		1,
		"4:93007:1"
	},
	{
		2,
		2,
		2,
		"4:93008:1"
	},
	{
		2,
		3,
		3,
		"4:93009:1"
	},
	{
		2,
		4,
		4,
		"4:93010:1"
	},
	{
		2,
		5,
		8,
		"4:93011:1"
	},
	{
		2,
		6,
		16,
		"4:93012:1"
	},
	{
		2,
		7,
		32,
		"4:93013:1"
	}
}
local t_peak_tournament_kudos_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_peak_tournament_kudos_prize.dataList = dataList

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

return t_peak_tournament_kudos_prize
