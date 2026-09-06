-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_progress_prize.lua

module("logicconfig.config.t_tian_man_wang_challenge_progress_prize", package.seeall)

local title = {
	prizeId = 1,
	prize = 3,
	hpPercent = 2
}
local dataList = {
	{
		1,
		100,
		"4:12:120"
	},
	{
		2,
		70,
		"4:13:120"
	},
	{
		3,
		40,
		"4:120001:30"
	},
	{
		4,
		0,
		"100:10099:1:1#4:84016:1#62:56:1"
	}
}
local t_tian_man_wang_challenge_progress_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_tian_man_wang_challenge_progress_prize.dataList = dataList

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

return t_tian_man_wang_challenge_progress_prize
