-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_score.lua

module("logicconfig.config.t_glory_battle_score", package.seeall)

local title = {
	winNum = 1,
	score = 2
}
local dataList = {
	{
		0,
		0
	},
	{
		1,
		5
	},
	{
		2,
		10
	},
	{
		3,
		15
	},
	{
		4,
		25
	},
	{
		5,
		30
	},
	{
		6,
		35
	},
	{
		7,
		45
	},
	{
		8,
		50
	},
	{
		9,
		70
	}
}
local t_glory_battle_score = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_glory_battle_score.dataList = dataList

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

return t_glory_battle_score
