-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_boss_buy_time.lua

module("logicconfig.config.t_king_dragon_boss_buy_time", package.seeall)

local title = {
	buyTimesPlanId = 1,
	cost = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:205:200"
	},
	{
		1,
		2,
		"105:205:200"
	},
	{
		1,
		3,
		"105:205:200"
	},
	{
		2,
		1,
		"105:205:200"
	},
	{
		2,
		2,
		"105:205:200"
	},
	{
		2,
		3,
		"105:205:200"
	}
}
local t_king_dragon_boss_buy_time = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_king_dragon_boss_buy_time.dataList = dataList

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

return t_king_dragon_boss_buy_time
