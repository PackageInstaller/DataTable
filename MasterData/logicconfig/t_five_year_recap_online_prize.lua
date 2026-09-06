-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_online_prize.lua

module("logicconfig.config.t_five_year_recap_online_prize", package.seeall)

local title = {
	prize = 3,
	pieceId = 2,
	activityId = 1
}
local dataList = {
	{
		586001,
		1,
		"4:90268:1"
	},
	{
		586001,
		2,
		"14:501:1"
	},
	{
		586001,
		3,
		"4:36:10"
	},
	{
		586001,
		4,
		"13:549:1"
	},
	{
		586001,
		5,
		"4:147:1"
	},
	{
		586001,
		6,
		"4:30006:20"
	},
	{
		586001,
		7,
		"4:400002:50"
	},
	{
		586001,
		8,
		"4:30006:20"
	},
	{
		586001,
		9,
		"4:400002:50"
	},
	{
		586001,
		10,
		"4:30006:20"
	},
	{
		586001,
		11,
		"4:400002:25"
	},
	{
		586001,
		12,
		"4:30006:20"
	},
	{
		586001,
		13,
		"4:400002:50"
	},
	{
		586001,
		14,
		"4:30006:20"
	},
	{
		586001,
		15,
		"4:400002:25"
	}
}
local t_five_year_recap_online_prize = {
	[586001] = {
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
		dataList[15]
	}
}

t_five_year_recap_online_prize.dataList = dataList

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

return t_five_year_recap_online_prize
