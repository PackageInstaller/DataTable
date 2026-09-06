-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_wishing_lantern.lua

module("logicconfig.config.t_new_year_pray_wishing_lantern", package.seeall)

local title = {
	lanternId = 1,
	animName = 5,
	bubbleId = 4,
	choiceId = 2,
	iconPath = 3
}
local dataList = {
	{
		1,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		2,
		"talk_nanguo"
	},
	{
		2,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		3,
		"talk_idle"
	},
	{
		3,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		4,
		"talk_gaoxing"
	},
	{
		4,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		5,
		"talk_idle"
	},
	{
		5,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		6,
		"talk_nanguo"
	},
	{
		6,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		7,
		"talk_gaoxing"
	},
	{
		7,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		8,
		"talk_gaoxing"
	},
	{
		8,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		9,
		"talk_nanguo"
	},
	{
		9,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		10,
		"talk_idle"
	},
	{
		10,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		2,
		"talk_nanguo"
	},
	{
		11,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		3,
		"talk_idle"
	},
	{
		12,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		4,
		"talk_gaoxing"
	},
	{
		13,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		5,
		"talk_idle"
	},
	{
		14,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		6,
		"talk_nanguo"
	},
	{
		15,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		7,
		"talk_gaoxing"
	},
	{
		16,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		8,
		"talk_gaoxing"
	},
	{
		17,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		9,
		"talk_nanguo"
	},
	{
		18,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		10,
		"talk_idle"
	},
	{
		19,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		2,
		"talk_nanguo"
	},
	{
		20,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		3,
		"talk_idle"
	},
	{
		21,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		4,
		"talk_gaoxing"
	},
	{
		22,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		5,
		"talk_idle"
	},
	{
		23,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		6,
		"talk_nanguo"
	},
	{
		24,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		7,
		"talk_gaoxing"
	},
	{
		25,
		3,
		"ui/bigbg/newyearpray/board_qiyuandenglong_02",
		8,
		"talk_gaoxing"
	},
	{
		26,
		1,
		"ui/bigbg/newyearpray/board_qiyuandenglong_03",
		9,
		"talk_nanguo"
	},
	{
		27,
		2,
		"ui/bigbg/newyearpray/board_qiyuandenglong_04",
		10,
		"talk_idle"
	}
}
local t_new_year_pray_wishing_lantern = {
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
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27]
}

t_new_year_pray_wishing_lantern.dataList = dataList

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

return t_new_year_pray_wishing_lantern
