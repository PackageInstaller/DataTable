-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_boss_buy_times_define.lua

module("logicconfig.config.t_world_boss_buy_times_define", package.seeall)

local title = {
	cost = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:141:50"
	},
	{
		2,
		"105:141:50"
	},
	{
		3,
		"105:141:100"
	},
	{
		4,
		"105:141:100"
	},
	{
		5,
		"105:141:100"
	},
	{
		6,
		"105:141:150"
	},
	{
		7,
		"105:141:150"
	},
	{
		8,
		"105:141:150"
	},
	{
		9,
		"105:141:200"
	},
	{
		10,
		"105:141:200"
	},
	{
		11,
		"105:141:200"
	},
	{
		12,
		"105:141:200"
	},
	{
		13,
		"105:141:250"
	},
	{
		14,
		"105:141:250"
	},
	{
		15,
		"105:141:250"
	},
	{
		16,
		"105:141:250"
	},
	{
		17,
		"105:141:300"
	},
	{
		18,
		"105:141:300"
	},
	{
		19,
		"105:141:300"
	},
	{
		20,
		"105:141:300"
	}
}
local t_world_boss_buy_times_define = {
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

t_world_boss_buy_times_define.dataList = dataList

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

return t_world_boss_buy_times_define
