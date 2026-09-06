-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_score.lua

module("logicconfig.config.t_idiom_chain_score", package.seeall)

local title = {
	score = 4,
	sec = 3,
	activityId = 1,
	difficultId = 2
}
local dataList = {
	{
		543001,
		1,
		30,
		40
	},
	{
		543001,
		1,
		50,
		30
	},
	{
		543001,
		1,
		70,
		20
	},
	{
		543001,
		1,
		90,
		10
	},
	{
		543001,
		2,
		45,
		60
	},
	{
		543001,
		2,
		70,
		45
	},
	{
		543001,
		2,
		90,
		30
	},
	{
		543001,
		2,
		120,
		15
	},
	{
		543002,
		1,
		45,
		40
	},
	{
		543002,
		1,
		55,
		30
	},
	{
		543002,
		1,
		70,
		20
	},
	{
		543002,
		1,
		90,
		10
	}
}
local t_idiom_chain_score = {
	[543001] = {
		{
			[30] = dataList[1],
			[50] = dataList[2],
			[70] = dataList[3],
			[90] = dataList[4]
		},
		{
			[45] = dataList[5],
			[70] = dataList[6],
			[90] = dataList[7],
			[120] = dataList[8]
		}
	},
	[543002] = {
		{
			[45] = dataList[9],
			[55] = dataList[10],
			[70] = dataList[11],
			[90] = dataList[12]
		}
	}
}

t_idiom_chain_score.dataList = dataList

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

return t_idiom_chain_score
