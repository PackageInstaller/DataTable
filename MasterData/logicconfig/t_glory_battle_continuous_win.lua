-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_continuous_win.lua

module("logicconfig.config.t_glory_battle_continuous_win", package.seeall)

local title = {
	winNum = 1,
	gainHiddenScore = 2
}
local dataList = {
	{
		2,
		0
	},
	{
		3,
		2
	},
	{
		4,
		3
	},
	{
		5,
		5
	},
	{
		6,
		5
	},
	{
		7,
		5
	},
	{
		8,
		10
	},
	{
		9,
		10
	},
	{
		10,
		10
	},
	{
		11,
		20
	}
}
local t_glory_battle_continuous_win = {
	[2] = dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[6] = dataList[5],
	[7] = dataList[6],
	[8] = dataList[7],
	[9] = dataList[8],
	[10] = dataList[9],
	[11] = dataList[10]
}

t_glory_battle_continuous_win.dataList = dataList

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

return t_glory_battle_continuous_win
