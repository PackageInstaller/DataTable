-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_game_recover_cost.lua

module("logicconfig.config.t_pin_game_recover_cost", package.seeall)

local title = {
	cost = 3,
	actId = 1,
	times = 2
}
local dataList = {
	{
		325001,
		1,
		"105:6094:5"
	},
	{
		325001,
		2,
		"105:6094:5"
	},
	{
		325001,
		3,
		"105:6094:5"
	},
	{
		325002,
		1,
		"105:6094:5"
	},
	{
		325002,
		2,
		"105:6094:5"
	},
	{
		325002,
		3,
		"105:6094:5"
	},
	{
		325003,
		1,
		"105:6094:5"
	},
	{
		325003,
		2,
		"105:6094:5"
	},
	{
		325003,
		3,
		"105:6094:5"
	},
	{
		325004,
		1,
		"105:6094:5"
	},
	{
		325004,
		2,
		"105:6094:5"
	},
	{
		325004,
		3,
		"105:6094:5"
	}
}
local t_pin_game_recover_cost = {
	[325001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[325002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[325003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[325004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_pin_game_recover_cost.dataList = dataList

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

return t_pin_game_recover_cost
