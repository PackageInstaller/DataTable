-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_data_ids.lua

module("logicconfig.config.t_recap2021_data_ids", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		1
	},
	{
		2
	},
	{
		3
	},
	{
		7
	},
	{
		8
	},
	{
		9
	},
	{
		10
	},
	{
		11
	},
	{
		12
	},
	{
		14
	},
	{
		15
	},
	{
		16
	},
	{
		17
	},
	{
		18
	},
	{
		19
	},
	{
		20
	},
	{
		25
	},
	{
		26
	},
	{
		27
	},
	{
		4
	},
	{
		5
	},
	{
		6
	},
	{
		13
	},
	{
		21
	},
	{
		22
	},
	{
		23
	},
	{
		24
	},
	{
		28
	},
	{
		29
	},
	{
		30
	}
}
local t_recap2021_data_ids = {
	dataList[1],
	dataList[2],
	dataList[3],
	[7] = dataList[4],
	[8] = dataList[5],
	[9] = dataList[6],
	[10] = dataList[7],
	[11] = dataList[8],
	[12] = dataList[9],
	[14] = dataList[10],
	[15] = dataList[11],
	[16] = dataList[12],
	[17] = dataList[13],
	[18] = dataList[14],
	[19] = dataList[15],
	[20] = dataList[16],
	[25] = dataList[17],
	[26] = dataList[18],
	[27] = dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	[13] = dataList[23],
	[21] = dataList[24],
	[22] = dataList[25],
	[23] = dataList[26],
	[24] = dataList[27],
	[28] = dataList[28],
	[29] = dataList[29],
	[30] = dataList[30]
}

t_recap2021_data_ids.dataList = dataList

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

return t_recap2021_data_ids
