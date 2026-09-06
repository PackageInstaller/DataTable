-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_inflation_money_progress_prize.lua

module("logicconfig.config.t_inflation_money_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		452001,
		1,
		88,
		"10:452001:10"
	},
	{
		452001,
		2,
		188,
		"10:452001:10"
	},
	{
		452001,
		3,
		288,
		"10:452001:10"
	},
	{
		452001,
		4,
		388,
		"10:452001:10"
	},
	{
		452001,
		5,
		688,
		"10:452001:10"
	},
	{
		452001,
		6,
		888,
		"10:452001:10"
	},
	{
		452001,
		7,
		1088,
		"10:452001:20"
	},
	{
		452001,
		8,
		1388,
		"10:452001:20"
	},
	{
		452001,
		9,
		1688,
		"10:452001:20"
	},
	{
		452001,
		10,
		1988,
		"10:452001:20"
	},
	{
		452001,
		11,
		2288,
		"10:452001:20"
	},
	{
		452001,
		12,
		2588,
		"10:452001:20"
	},
	{
		452001,
		13,
		2888,
		"10:452001:20"
	},
	{
		452001,
		14,
		3188,
		"10:452001:20"
	},
	{
		452001,
		15,
		3488,
		"10:452001:30"
	},
	{
		452001,
		16,
		3788,
		"10:452001:20"
	},
	{
		452001,
		17,
		4088,
		"10:452001:30"
	},
	{
		452001,
		18,
		4688,
		"10:452001:50"
	},
	{
		452001,
		19,
		5288,
		"10:452001:50"
	},
	{
		452001,
		20,
		5888,
		"10:452001:60"
	},
	{
		452001,
		21,
		6488,
		"10:452001:70"
	}
}
local t_inflation_money_progress_prize = {
	[452001] = {
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
		dataList[20],
		dataList[21]
	}
}

t_inflation_money_progress_prize.dataList = dataList

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

return t_inflation_money_progress_prize
