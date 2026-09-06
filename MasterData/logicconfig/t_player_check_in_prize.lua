-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_player_check_in_prize.lua

module("logicconfig.config.t_player_check_in_prize", package.seeall)

local title = {
	checkInType = 1,
	prize = 2
}
local dataList = {
	{
		1,
		"8:1:100000"
	},
	{
		2,
		"4:25:10"
	},
	{
		3,
		"4:111:10"
	}
}
local t_player_check_in_prize = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_player_check_in_prize.dataList = dataList

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

return t_player_check_in_prize
