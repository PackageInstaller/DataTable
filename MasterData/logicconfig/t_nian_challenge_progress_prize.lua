-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_challenge_progress_prize.lua

module("logicconfig.config.t_nian_challenge_progress_prize", package.seeall)

local title = {
	stageId = 2,
	prizeId = 1,
	prize = 3,
	prizeShow = 4
}
local dataList = {
	{
		1,
		5,
		"8:1:200000",
		"8:1:200000"
	},
	{
		2,
		10,
		"104:2:388",
		"104:2:388"
	},
	{
		3,
		15,
		"4:25:20",
		"4:25:20"
	},
	{
		4,
		20,
		"4:36:10",
		"4:36:10"
	},
	{
		5,
		25,
		"4:30003:20",
		"4:30003:20"
	},
	{
		6,
		30,
		"100:11000:100:1#4:90103:1",
		"1004:1122:1"
	}
}
local t_nian_challenge_progress_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_nian_challenge_progress_prize.dataList = dataList

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

return t_nian_challenge_progress_prize
