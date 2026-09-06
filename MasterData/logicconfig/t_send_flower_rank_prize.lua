-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_flower_rank_prize.lua

module("logicconfig.config.t_send_flower_rank_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	rank = 3,
	type = 1
}
local dataList = {
	{
		"send",
		1,
		1,
		"2:38:1"
	},
	{
		"send",
		2,
		2,
		"2:38:1"
	},
	{
		"send",
		3,
		3,
		"2:38:1"
	},
	{
		"send",
		4,
		5,
		"4:106:2"
	},
	{
		"send",
		5,
		10,
		"4:106:1"
	},
	{
		"send",
		6,
		20,
		"4:105:5"
	},
	{
		"charm",
		1,
		1,
		"14:29:1"
	},
	{
		"charm",
		2,
		2,
		"14:28:1"
	},
	{
		"charm",
		3,
		3,
		"14:28:1"
	},
	{
		"charm",
		4,
		5,
		"14:28:1"
	},
	{
		"charm",
		5,
		10,
		"14:27:1"
	},
	{
		"charm",
		6,
		20,
		"14:27:1"
	}
}
local t_send_flower_rank_prize = {
	send = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	charm = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_send_flower_rank_prize.dataList = dataList

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

return t_send_flower_rank_prize
