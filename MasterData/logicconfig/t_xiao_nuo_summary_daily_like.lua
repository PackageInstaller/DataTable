-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_daily_like.lua

module("logicconfig.config.t_xiao_nuo_summary_daily_like", package.seeall)

local title = {
	id = 3,
	activityId = 1,
	tab = 2,
	prize = 4
}
local dataList = {
	{
		96003,
		7,
		1,
		"8:1:5000"
	},
	{
		96003,
		7,
		2,
		"8:1:5000"
	},
	{
		96003,
		7,
		3,
		"8:1:5000"
	},
	{
		96003,
		7,
		4,
		"8:1:5000"
	},
	{
		96004,
		7,
		1,
		"8:1:5000"
	},
	{
		96004,
		7,
		2,
		"8:1:5000"
	},
	{
		96004,
		7,
		3,
		"8:1:5000"
	},
	{
		96004,
		7,
		4,
		"8:1:5000"
	},
	{
		96004,
		7,
		5,
		"8:1:5000"
	},
	{
		96004,
		7,
		6,
		"8:1:5000"
	},
	{
		96004,
		7,
		7,
		"8:1:5000"
	},
	{
		96004,
		7,
		8,
		"8:1:5000"
	},
	{
		96006,
		6,
		1,
		"8:1:5000"
	},
	{
		96006,
		6,
		2,
		"8:1:5000"
	},
	{
		96006,
		6,
		3,
		"8:1:5000"
	},
	{
		96006,
		6,
		4,
		"8:1:5000"
	},
	{
		96006,
		6,
		5,
		"8:1:5000"
	},
	{
		96013,
		3,
		1,
		"8:1:5000"
	},
	{
		96013,
		3,
		2,
		"8:1:5000"
	},
	{
		96013,
		3,
		3,
		"8:1:5000"
	},
	{
		96013,
		3,
		4,
		"8:1:5000"
	},
	{
		96013,
		3,
		5,
		"8:1:5000"
	},
	{
		96013,
		3,
		6,
		"8:1:5000"
	},
	{
		96013,
		3,
		7,
		"8:1:5000"
	},
	{
		96013,
		3,
		8,
		"8:1:5000"
	},
	{
		96013,
		3,
		9,
		"8:1:5000"
	},
	{
		96013,
		3,
		10,
		"8:1:5000"
	},
	{
		96013,
		3,
		11,
		"8:1:5000"
	},
	{
		96026,
		5,
		1,
		"8:1:5000"
	},
	{
		96026,
		5,
		2,
		"8:1:5000"
	},
	{
		96026,
		5,
		3,
		"8:1:5000"
	},
	{
		96026,
		5,
		4,
		"8:1:5000"
	}
}
local t_xiao_nuo_summary_daily_like = {
	[96003] = {
		[7] = {
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		}
	},
	[96004] = {
		[7] = {
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[96006] = {
		[6] = {
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17]
		}
	},
	[96013] = {
		[3] = {
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28]
		}
	},
	[96026] = {
		[5] = {
			dataList[29],
			dataList[30],
			dataList[31],
			dataList[32]
		}
	}
}

t_xiao_nuo_summary_daily_like.dataList = dataList

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

return t_xiao_nuo_summary_daily_like
