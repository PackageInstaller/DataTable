-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_directup_helicopter.lua

module("logicconfig.config.t_directup_helicopter", package.seeall)

local title = {
	id = 2,
	targetId = 3,
	activityId = 1
}
local dataList = {
	{
		60001,
		1,
		1
	},
	{
		60001,
		2,
		2
	},
	{
		60002,
		1,
		4
	},
	{
		60002,
		2,
		5
	},
	{
		60003,
		1,
		6
	},
	{
		60003,
		2,
		7
	},
	{
		60004,
		1,
		8
	},
	{
		60004,
		2,
		9
	},
	{
		60005,
		1,
		10
	},
	{
		60005,
		2,
		11
	},
	{
		60006,
		1,
		12
	},
	{
		60006,
		2,
		13
	},
	{
		60007,
		1,
		14
	},
	{
		60007,
		2,
		15
	},
	{
		60008,
		1,
		16
	},
	{
		60008,
		2,
		17
	}
}
local t_directup_helicopter = {
	[60001] = {
		dataList[1],
		dataList[2]
	},
	[60002] = {
		dataList[3],
		dataList[4]
	},
	[60003] = {
		dataList[5],
		dataList[6]
	},
	[60004] = {
		dataList[7],
		dataList[8]
	},
	[60005] = {
		dataList[9],
		dataList[10]
	},
	[60006] = {
		dataList[11],
		dataList[12]
	},
	[60007] = {
		dataList[13],
		dataList[14]
	},
	[60008] = {
		dataList[15],
		dataList[16]
	}
}

t_directup_helicopter.dataList = dataList

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

return t_directup_helicopter
