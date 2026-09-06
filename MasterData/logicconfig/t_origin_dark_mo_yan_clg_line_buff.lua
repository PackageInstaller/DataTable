-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mo_yan_clg_line_buff.lua

module("logicconfig.config.t_origin_dark_mo_yan_clg_line_buff", package.seeall)

local title = {
	lineType = 3,
	stageId = 2,
	enemyBuffDesc = 5,
	num = 4,
	activityId = 1
}
local dataList = {
	{
		625001,
		1,
		0,
		0,
		82057903
	},
	{
		625001,
		1,
		0,
		1,
		82057904
	},
	{
		625001,
		1,
		0,
		2,
		82057905
	},
	{
		625001,
		1,
		0,
		3,
		82057906
	},
	{
		625001,
		1,
		0,
		4,
		82057907
	},
	{
		625001,
		1,
		1,
		0,
		82057903
	},
	{
		625001,
		1,
		1,
		1,
		82057991
	},
	{
		625001,
		1,
		1,
		2,
		82057992
	},
	{
		625001,
		1,
		1,
		3,
		82057991
	},
	{
		625001,
		1,
		1,
		4,
		82057992
	},
	{
		625001,
		2,
		0,
		0,
		82057903
	},
	{
		625001,
		2,
		0,
		1,
		82057904
	},
	{
		625001,
		2,
		0,
		2,
		82057905
	},
	{
		625001,
		2,
		0,
		3,
		82057906
	},
	{
		625001,
		2,
		0,
		4,
		82057907
	},
	{
		625001,
		2,
		1,
		0,
		82057903
	},
	{
		625001,
		2,
		1,
		1,
		82057991
	},
	{
		625001,
		2,
		1,
		2,
		82057992
	},
	{
		625001,
		2,
		1,
		3,
		82057991
	},
	{
		625001,
		2,
		1,
		4,
		82057992
	},
	{
		625001,
		3,
		0,
		0,
		82057903
	},
	{
		625001,
		3,
		0,
		1,
		82057904
	},
	{
		625001,
		3,
		0,
		2,
		82057905
	},
	{
		625001,
		3,
		0,
		3,
		82057906
	},
	{
		625001,
		3,
		0,
		4,
		82057907
	},
	{
		625001,
		3,
		1,
		0,
		82057903
	},
	{
		625001,
		3,
		1,
		1,
		82057991
	},
	{
		625001,
		3,
		1,
		2,
		82057992
	},
	{
		625001,
		3,
		1,
		3,
		82057991
	},
	{
		625001,
		3,
		1,
		4,
		82057992
	}
}
local t_origin_dark_mo_yan_clg_line_buff = {
	[625001] = {
		{
			[0] = {
				[0] = dataList[1],
				dataList[2],
				dataList[3],
				dataList[4],
				dataList[5]
			},
			{
				[0] = dataList[6],
				dataList[7],
				dataList[8],
				dataList[9],
				dataList[10]
			}
		},
		{
			[0] = {
				[0] = dataList[11],
				dataList[12],
				dataList[13],
				dataList[14],
				dataList[15]
			},
			{
				[0] = dataList[16],
				dataList[17],
				dataList[18],
				dataList[19],
				dataList[20]
			}
		},
		{
			[0] = {
				[0] = dataList[21],
				dataList[22],
				dataList[23],
				dataList[24],
				dataList[25]
			},
			{
				[0] = dataList[26],
				dataList[27],
				dataList[28],
				dataList[29],
				dataList[30]
			}
		}
	}
}

t_origin_dark_mo_yan_clg_line_buff.dataList = dataList

local multiLanguageCells = {
	enemyBuffDesc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_dark_mo_yan_clg_line_buff
