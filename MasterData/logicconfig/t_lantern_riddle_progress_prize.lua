-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_riddle_progress_prize.lua

module("logicconfig.config.t_lantern_riddle_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		441001,
		1,
		1,
		"8:1:500000"
	},
	{
		441001,
		2,
		2,
		"4:400002:100"
	},
	{
		441001,
		3,
		3,
		"4:510022:5"
	},
	{
		441001,
		4,
		4,
		"4:30006:100"
	},
	{
		441001,
		5,
		5,
		"4:12102:10"
	},
	{
		441001,
		6,
		6,
		"4:11002:30000"
	},
	{
		441001,
		7,
		7,
		"4:36:10"
	}
}
local t_lantern_riddle_progress_prize = {
	[441001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_lantern_riddle_progress_prize.dataList = dataList

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

return t_lantern_riddle_progress_prize
