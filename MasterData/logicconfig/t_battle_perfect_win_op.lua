-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_perfect_win_op.lua

module("logicconfig.config.t_battle_perfect_win_op", package.seeall)

local title = {
	id = 1,
	params = 3,
	type = 2
}
local dataList = {
	{
		1,
		"KillNum",
		"6"
	},
	{
		2,
		"DieCount",
		"1"
	},
	{
		3,
		"DieCount",
		"2"
	},
	{
		4,
		"DieCount",
		"0"
	},
	{
		5,
		"DieCount",
		"6"
	}
}
local t_battle_perfect_win_op = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_battle_perfect_win_op.dataList = dataList

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

return t_battle_perfect_win_op
