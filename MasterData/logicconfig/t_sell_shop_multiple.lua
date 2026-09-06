-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sell_shop_multiple.lua

module("logicconfig.config.t_sell_shop_multiple", package.seeall)

local title = {
	id = 1,
	shopItemId = 2,
	bgImg = 3
}
local dataList = {
	{
		1,
		4505,
		"board_pfhd_05"
	},
	{
		2,
		4506,
		"board_pfhd_05"
	},
	{
		3,
		4507,
		"board_pfhd_05"
	},
	{
		4,
		4508,
		"board_pfhd_05"
	},
	{
		5,
		12038,
		"board_pfhd_05"
	},
	{
		6,
		4015,
		"board_pfhd_05"
	},
	{
		7,
		4016,
		"board_pfhd_05"
	},
	{
		8,
		4501,
		"board_pfhd_05"
	},
	{
		9,
		4502,
		"board_pfhd_05"
	},
	{
		10,
		4501,
		"board_pfhd_05"
	},
	{
		11,
		4502,
		"board_pfhd_05"
	},
	{
		12,
		4509,
		"board_pfhd_05"
	},
	{
		13,
		4510,
		"board_pfhd_05"
	},
	{
		14,
		4511,
		"board_pfhd_05"
	},
	{
		15,
		4512,
		"board_pfhd_05"
	},
	{
		16,
		4513,
		"board_pfhd_05"
	},
	{
		17,
		4514,
		"board_pfhd_05"
	},
	{
		18,
		4515,
		"board_pfhd_05"
	},
	{
		19,
		4516,
		"board_pfhd_05"
	},
	{
		20,
		4519,
		"board_pfhd_05"
	},
	{
		21,
		4520,
		"board_pfhd_05"
	},
	{
		22,
		4521,
		"board_pfhd_05"
	}
}
local t_sell_shop_multiple = {
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
	dataList[21],
	dataList[22]
}

t_sell_shop_multiple.dataList = dataList

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

return t_sell_shop_multiple
