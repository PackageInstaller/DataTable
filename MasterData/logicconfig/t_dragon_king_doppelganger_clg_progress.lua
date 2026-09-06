-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_doppelganger_clg_progress.lua

module("logicconfig.config.t_dragon_king_doppelganger_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		315001,
		1,
		10,
		"8:1:375000"
	},
	{
		315001,
		2,
		20,
		"4:400002:25"
	},
	{
		315001,
		3,
		30,
		"8:1:375000"
	},
	{
		315001,
		4,
		40,
		"4:40008:1"
	},
	{
		315001,
		5,
		50,
		"8:1:375000"
	},
	{
		315001,
		6,
		60,
		"4:400002:25"
	},
	{
		315001,
		7,
		70,
		"8:1:375000"
	},
	{
		315001,
		8,
		80,
		"4:40008:1"
	},
	{
		315001,
		9,
		90,
		"8:1:375000"
	},
	{
		315001,
		10,
		100,
		"4:400002:25"
	},
	{
		315001,
		11,
		110,
		"8:1:375000"
	},
	{
		315001,
		12,
		120,
		"4:40008:1"
	},
	{
		315001,
		13,
		130,
		"8:1:375000"
	},
	{
		315001,
		14,
		140,
		"4:400002:25"
	},
	{
		315001,
		15,
		150,
		"8:1:375000"
	},
	{
		315001,
		16,
		160,
		"4:40008:1"
	}
}
local t_dragon_king_doppelganger_clg_progress = {
	[315001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_dragon_king_doppelganger_clg_progress.dataList = dataList

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

return t_dragon_king_doppelganger_clg_progress
