-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_boss_buy.lua

module("logicconfig.config.t_king_ciyuan_boss_buy", package.seeall)

local title = {
	cost = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:6052:20"
	},
	{
		2,
		"105:6052:20"
	},
	{
		3,
		"105:6052:20"
	},
	{
		4,
		"105:6052:30"
	},
	{
		5,
		"105:6052:30"
	},
	{
		6,
		"105:6052:30"
	},
	{
		7,
		"105:6052:50"
	},
	{
		8,
		"105:6052:50"
	},
	{
		9,
		"105:6052:50"
	},
	{
		10,
		"105:6052:50"
	},
	{
		11,
		"105:6052:50"
	},
	{
		12,
		"105:6052:50"
	},
	{
		13,
		"105:6052:50"
	},
	{
		14,
		"105:6052:50"
	},
	{
		15,
		"105:6052:50"
	},
	{
		16,
		"105:6052:50"
	},
	{
		17,
		"105:6052:50"
	},
	{
		18,
		"105:6052:50"
	},
	{
		19,
		"105:6052:50"
	},
	{
		20,
		"105:6052:50"
	}
}
local t_king_ciyuan_boss_buy = {
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
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_king_ciyuan_boss_buy.dataList = dataList

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

return t_king_ciyuan_boss_buy
