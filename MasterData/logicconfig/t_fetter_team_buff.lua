-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fetter_team_buff.lua

module("logicconfig.config.t_fetter_team_buff", package.seeall)

local title = {
	functionId = 1,
	desc = 3,
	valueLimit = 5,
	showValue = 4,
	fetter = 2
}
local dataList = {
	{
		1,
		1,
		"全属性及生命上限+%s%%",
		5,
		30
	},
	{
		1,
		3000,
		"",
		10,
		0
	},
	{
		1,
		8000,
		"",
		15,
		0
	},
	{
		1,
		13000,
		"",
		20,
		0
	},
	{
		1,
		20000,
		"",
		25,
		0
	},
	{
		1,
		30000,
		"",
		30,
		0
	},
	{
		2,
		1,
		"全属性及生命上限+%s%%",
		5,
		30
	},
	{
		2,
		3000,
		"",
		10,
		0
	},
	{
		2,
		8000,
		"",
		15,
		0
	},
	{
		2,
		13000,
		"",
		20,
		0
	},
	{
		2,
		20000,
		"",
		25,
		0
	},
	{
		2,
		30000,
		"",
		30,
		0
	}
}
local t_fetter_team_buff = {
	{
		dataList[1],
		[3000] = dataList[2],
		[8000] = dataList[3],
		[13000] = dataList[4],
		[20000] = dataList[5],
		[30000] = dataList[6]
	},
	{
		dataList[7],
		[3000] = dataList[8],
		[8000] = dataList[9],
		[13000] = dataList[10],
		[20000] = dataList[11],
		[30000] = dataList[12]
	}
}

t_fetter_team_buff.dataList = dataList

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

return t_fetter_team_buff
