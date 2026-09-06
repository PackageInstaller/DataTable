-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation.lua

module("logicconfig.config.t_formation", package.seeall)

local title = {
	posList = 4,
	name = 2,
	properties = 5,
	cellDetail = 3,
	id = 1
}
local dataList = {
	{
		1,
		"格挡阵",
		"2,4,5,6,8",
		{
			2,
			4,
			5,
			6,
			8
		},
		"格挡率+10%"
	},
	{
		2,
		"物攻阵",
		"1,4,5,8,9",
		{
			1,
			4,
			5,
			8,
			9
		},
		"物攻率+10%"
	},
	{
		3,
		"物防阵",
		"1,3,4,6,8",
		{
			1,
			3,
			4,
			6,
			8
		},
		"物防率+10%"
	},
	{
		4,
		"超攻阵",
		"1,2,3,5,8",
		{
			1,
			2,
			3,
			5,
			8
		},
		"超攻率+10%"
	},
	{
		5,
		"暴击阵",
		"2,3,4,6,7",
		{
			2,
			3,
			4,
			6,
			7
		},
		"暴击率+10%"
	},
	{
		6,
		"闪避阵",
		"2,4,6,7,9",
		{
			2,
			4,
			6,
			7,
			9
		},
		"闪避率+10%"
	},
	{
		7,
		"命中阵",
		"1,3,5,7,9",
		{
			1,
			3,
			5,
			7,
			9
		},
		"命中率+10%"
	},
	{
		8,
		"魔攻阵",
		"1,4,5,6,9",
		{
			1,
			4,
			5,
			6,
			9
		},
		"魔攻率+10%"
	},
	{
		9,
		"智慧阵",
		"3,4,5,7,9",
		{
			3,
			4,
			5,
			7,
			9
		},
		"暴击率+5%#闪避率+5%"
	},
	{
		10,
		"超级阵",
		"1,2,3,4,5,6,7,8,9",
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		},
		""
	}
}
local t_formation = {
	dataList[1],
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

t_formation.dataList = dataList

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

return t_formation
