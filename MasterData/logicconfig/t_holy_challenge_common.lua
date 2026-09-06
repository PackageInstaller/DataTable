-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_challenge_common.lua

module("logicconfig.config.t_holy_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_ENERGY",
		"200"
	},
	{
		"FINAL_PRIZE",
		"100:10027:1:1#62:1:1"
	},
	{
		"PRIZE_ENERGY_REQ",
		"3000"
	}
}
local t_holy_challenge_common = {
	DAILY_ENERGY = dataList[1],
	FINAL_PRIZE = dataList[2],
	PRIZE_ENERGY_REQ = dataList[3]
}

t_holy_challenge_common.dataList = dataList

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

return t_holy_challenge_common
