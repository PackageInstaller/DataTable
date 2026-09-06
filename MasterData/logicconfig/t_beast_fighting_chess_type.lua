-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_fighting_chess_type.lua

module("logicconfig.config.t_beast_fighting_chess_type", package.seeall)

local title = {
	robotWinScore = 8,
	askTieScore = 7,
	winScore = 4,
	robotLoseScore = 9,
	loseScore = 5,
	typeId = 2,
	desc = 3,
	tieScore = 6,
	dailyTimes = 10,
	activityId = 1
}
local dataList = {
	{
		412001,
		1,
		"斗兽棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412001,
		2,
		"围虎棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412002,
		1,
		"斗兽棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412002,
		2,
		"围虎棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412003,
		1,
		"斗兽棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412003,
		2,
		"围虎棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412004,
		1,
		"斗兽棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	},
	{
		412004,
		2,
		"围虎棋",
		50,
		25,
		0,
		0,
		10,
		0,
		10
	}
}
local t_beast_fighting_chess_type = {
	[412001] = {
		dataList[1],
		dataList[2]
	},
	[412002] = {
		dataList[3],
		dataList[4]
	},
	[412003] = {
		dataList[5],
		dataList[6]
	},
	[412004] = {
		dataList[7],
		dataList[8]
	}
}

t_beast_fighting_chess_type.dataList = dataList

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

return t_beast_fighting_chess_type
