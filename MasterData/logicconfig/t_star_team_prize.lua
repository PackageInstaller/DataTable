-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_team_prize.lua

module("logicconfig.config.t_star_team_prize", package.seeall)

local title = {
	id = 1,
	reward = 3,
	teamZdlReq = 2
}
local dataList = {
	{
		1,
		10000,
		"4:40004:1#4:30001:20#8:1:10000"
	},
	{
		2,
		30000,
		"4:40005:1#4:30001:20#8:1:10000"
	},
	{
		3,
		50000,
		"4:31:10#4:30001:20#8:1:10000"
	},
	{
		4,
		70000,
		"4:40006:1#4:30001:40#8:1:20000"
	},
	{
		5,
		100000,
		"4:41004:1#4:501:50#8:1:30000"
	}
}
local t_star_team_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_star_team_prize.dataList = dataList

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

return t_star_team_prize
