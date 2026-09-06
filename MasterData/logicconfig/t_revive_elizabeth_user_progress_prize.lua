-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_user_progress_prize.lua

module("logicconfig.config.t_revive_elizabeth_user_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	img = 6,
	progress = 3,
	activityId = 1,
	flowerId = 5
}
local dataList = {
	{
		416001,
		1,
		1000,
		"4:400002:10",
		0,
		"gal_y_41_1"
	},
	{
		416001,
		2,
		2000,
		"8:1:500000",
		0,
		""
	},
	{
		416001,
		3,
		3000,
		"4:400002:10",
		1,
		""
	},
	{
		416001,
		4,
		4000,
		"4:90316:1",
		0,
		""
	},
	{
		416001,
		5,
		5000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		6,
		6000,
		"4:30006:50",
		2,
		""
	},
	{
		416001,
		7,
		7000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		8,
		8000,
		"4:90316:1",
		0,
		""
	},
	{
		416001,
		9,
		9000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		10,
		10000,
		"4:510369:1",
		3,
		""
	},
	{
		416001,
		11,
		12000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		12,
		14000,
		"4:90316:1",
		0,
		""
	},
	{
		416001,
		13,
		16000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		14,
		18000,
		"8:1:500000",
		4,
		""
	},
	{
		416001,
		15,
		20000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		16,
		22000,
		"4:90316:1",
		0,
		""
	},
	{
		416001,
		17,
		24000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		18,
		26000,
		"4:30006:50",
		5,
		""
	},
	{
		416001,
		19,
		28000,
		"4:400002:10",
		0,
		""
	},
	{
		416001,
		20,
		30000,
		"4:510369:1",
		0,
		"gal_y_41_2"
	}
}
local t_revive_elizabeth_user_progress_prize = {
	[416001] = {
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
}

t_revive_elizabeth_user_progress_prize.dataList = dataList

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

return t_revive_elizabeth_user_progress_prize
