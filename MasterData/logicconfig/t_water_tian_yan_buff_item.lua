-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_tian_yan_buff_item.lua

module("logicconfig.config.t_water_tian_yan_buff_item", package.seeall)

local title = {
	buffItemId = 2,
	activityId = 1,
	type = 3
}
local dataList = {
	{
		305001,
		1,
		1
	},
	{
		305001,
		2,
		1
	},
	{
		305001,
		3,
		1
	},
	{
		305001,
		4,
		1
	},
	{
		305001,
		5,
		1
	},
	{
		305001,
		6,
		2
	},
	{
		305001,
		7,
		2
	},
	{
		305001,
		8,
		2
	},
	{
		305001,
		9,
		2
	},
	{
		305001,
		10,
		2
	},
	{
		305002,
		1,
		1
	},
	{
		305002,
		2,
		1
	},
	{
		305002,
		3,
		1
	},
	{
		305002,
		4,
		1
	},
	{
		305002,
		5,
		1
	},
	{
		305002,
		6,
		1
	},
	{
		305002,
		7,
		2
	},
	{
		305002,
		8,
		2
	},
	{
		305002,
		9,
		2
	},
	{
		305002,
		10,
		2
	},
	{
		305002,
		11,
		2
	},
	{
		305002,
		12,
		2
	},
	{
		305003,
		1,
		1
	},
	{
		305003,
		2,
		1
	},
	{
		305003,
		3,
		1
	},
	{
		305003,
		4,
		1
	},
	{
		305003,
		5,
		2
	},
	{
		305003,
		6,
		2
	},
	{
		305003,
		7,
		2
	},
	{
		305003,
		8,
		2
	}
}
local t_water_tian_yan_buff_item = {
	[305001] = {
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
	},
	[305002] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	},
	[305003] = {
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_water_tian_yan_buff_item.dataList = dataList

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

return t_water_tian_yan_buff_item
