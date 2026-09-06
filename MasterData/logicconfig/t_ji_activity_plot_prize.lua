-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_activity_plot_prize.lua

module("logicconfig.config.t_ji_activity_plot_prize", package.seeall)

local title = {
	titleStr = 4,
	prize = 3,
	plotId = 5,
	id = 2,
	activityId = 1
}
local dataList = {
	{
		144001,
		1,
		"4:138:1",
		"生日庆典·前夜",
		4220001
	},
	{
		144001,
		2,
		"4:138:1",
		"出发吧！五王",
		4220002
	},
	{
		144001,
		3,
		"4:138:1",
		"五王的贺礼",
		4220003
	},
	{
		144001,
		4,
		"4:138:1",
		"初心不息",
		4220004
	},
	{
		144001,
		5,
		"4:138:1",
		"诞生！伙伴意志·极",
		4220005
	},
	{
		144002,
		1,
		"4:138:1",
		"生日庆典·前夜",
		4220001
	},
	{
		144002,
		2,
		"4:138:1",
		"出发吧！五王",
		4220002
	},
	{
		144002,
		3,
		"4:138:1",
		"五王的贺礼",
		4220003
	},
	{
		144002,
		4,
		"4:138:1",
		"初心不息",
		4220004
	},
	{
		144002,
		5,
		"4:138:1",
		"诞生！伙伴意志·极",
		4220005
	},
	{
		144003,
		1,
		"4:138:1",
		"生日庆典·前夜",
		4220001
	},
	{
		144003,
		2,
		"4:138:1",
		"出发吧！五王",
		4220002
	},
	{
		144003,
		3,
		"4:138:1",
		"五王的贺礼",
		4220003
	},
	{
		144003,
		4,
		"4:138:1",
		"初心不息",
		4220004
	},
	{
		144003,
		5,
		"4:138:1",
		"诞生！伙伴意志·极",
		4220005
	},
	{
		144004,
		1,
		"4:138:1",
		"生日庆典·前夜",
		4220001
	},
	{
		144004,
		2,
		"4:138:1",
		"出发吧！五王",
		4220002
	},
	{
		144004,
		3,
		"4:138:1",
		"五王的贺礼",
		4220003
	},
	{
		144004,
		4,
		"4:138:1",
		"初心不息",
		4220004
	},
	{
		144004,
		5,
		"4:138:1",
		"诞生！伙伴意志·极",
		4220005
	}
}
local t_ji_activity_plot_prize = {
	[144001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[144002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[144003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[144004] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_ji_activity_plot_prize.dataList = dataList

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

return t_ji_activity_plot_prize
