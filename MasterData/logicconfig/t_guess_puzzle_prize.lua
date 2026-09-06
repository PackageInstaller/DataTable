-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_puzzle_prize.lua

module("logicconfig.config.t_guess_puzzle_prize", package.seeall)

local title = {
	tips = 4,
	prize = 3,
	sentenceId = 2,
	activityId = 1
}
local dataList = {
	{
		431001,
		1,
		"4:36:5",
		"六艺具体是哪些呢？填到这里来吧~"
	},
	{
		431001,
		2,
		"4:7008:50",
		"镇守山底的强力火系圣龙在平行时空的另一个形态"
	},
	{
		431001,
		3,
		"4:30006:25",
		"现任神裁一把手"
	},
	{
		431001,
		4,
		"4:36:5",
		"性格善良的草系圣龙在平行时空的另一个形态"
	},
	{
		431001,
		5,
		"4:30006:25",
		"全句由宋代王之道的《朝中措》演变而来"
	},
	{
		431001,
		6,
		"4:7008:50",
		"出自唐代白居易《琵琶行》，形容琵琶女弹奏的曲子美妙动听"
	},
	{
		431001,
		7,
		"4:30006:25",
		"好奇心旺盛的草系圣龙在平行时空的另一个形态"
	},
	{
		431001,
		8,
		"8:1:1000000",
		"出自宋代诗人范成大的《南柯子·七夕》，描绘了七夕节夜晚的宁静美景"
	},
	{
		431001,
		9,
		"4:30006:25",
		"沉醉在枫叶如火中，一杆长戟、一壶清酒行走天下的三色通灵师"
	}
}
local t_guess_puzzle_prize = {
	[431001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_guess_puzzle_prize.dataList = dataList

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

return t_guess_puzzle_prize
