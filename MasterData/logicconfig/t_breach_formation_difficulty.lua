-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_formation_difficulty.lua

module("logicconfig.config.t_breach_formation_difficulty", package.seeall)

local title = {
	recommendZdl = 4,
	difficultyId = 1,
	prize = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"普通",
		"4:26:20#4:3:10",
		10000
	},
	{
		2,
		"困难",
		"4:26:20#4:3:10",
		20000
	},
	{
		3,
		"噩梦",
		"4:26:20#4:3:10",
		30000
	}
}
local t_breach_formation_difficulty = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_breach_formation_difficulty.dataList = dataList

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

return t_breach_formation_difficulty
