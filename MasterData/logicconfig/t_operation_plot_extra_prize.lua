-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_plot_extra_prize.lua

module("logicconfig.config.t_operation_plot_extra_prize", package.seeall)

local title = {
	star3 = 6,
	star2 = 5,
	star5 = 8,
	star0 = 3,
	extPrizetId = 1,
	star6 = 9,
	star1 = 4,
	raceId = 2,
	star4 = 7
}
local dataList = {
	{
		1,
		10324,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		1,
		10143,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		1,
		10142,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		2,
		10145,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		2,
		10147,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		2,
		10323,
		500,
		1000,
		1500,
		2000,
		2500,
		3000,
		3500
	},
	{
		3,
		10101,
		2500,
		2500,
		2500,
		2500,
		2500,
		2500,
		2500
	}
}
local t_operation_plot_extra_prize = {
	{
		[10324] = dataList[1],
		[10143] = dataList[2],
		[10142] = dataList[3]
	},
	{
		[10145] = dataList[4],
		[10147] = dataList[5],
		[10323] = dataList[6]
	},
	{
		[10101] = dataList[7]
	}
}

t_operation_plot_extra_prize.dataList = dataList

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

return t_operation_plot_extra_prize
