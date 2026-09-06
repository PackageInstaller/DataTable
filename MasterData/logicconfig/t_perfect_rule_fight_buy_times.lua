-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_perfect_rule_fight_buy_times.lua

module("logicconfig.config.t_perfect_rule_fight_buy_times", package.seeall)

local title = {
	challengeId = 1,
	cost = 3,
	times = 2
}
local dataList = {
	{
		19,
		1,
		"105:186:20"
	},
	{
		19,
		2,
		"105:186:20"
	},
	{
		19,
		3,
		"105:186:50"
	},
	{
		19,
		4,
		"105:186:50"
	},
	{
		19,
		5,
		"105:186:100"
	},
	{
		24,
		1,
		"105:186:20"
	},
	{
		24,
		2,
		"105:186:20"
	},
	{
		24,
		3,
		"105:186:50"
	},
	{
		24,
		4,
		"105:186:50"
	},
	{
		24,
		5,
		"105:186:100"
	},
	{
		46,
		1,
		"105:186:20"
	},
	{
		46,
		2,
		"105:186:20"
	},
	{
		46,
		3,
		"105:186:50"
	},
	{
		46,
		4,
		"105:186:50"
	},
	{
		46,
		5,
		"105:186:100"
	},
	{
		59,
		1,
		"105:186:20"
	},
	{
		59,
		2,
		"105:186:20"
	},
	{
		59,
		3,
		"105:186:50"
	},
	{
		59,
		4,
		"105:186:50"
	},
	{
		59,
		5,
		"105:186:100"
	},
	{
		111,
		1,
		"105:186:100"
	},
	{
		151,
		1,
		"105:186:100"
	}
}
local t_perfect_rule_fight_buy_times = {
	[19] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[24] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[46] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[59] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	[111] = {
		dataList[21]
	},
	[151] = {
		dataList[22]
	}
}

t_perfect_rule_fight_buy_times.dataList = dataList

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

return t_perfect_rule_fight_buy_times
