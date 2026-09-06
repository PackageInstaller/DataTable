-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_block.lua

module("logicconfig.config.t_free_scuffle_block", package.seeall)

local title = {
	packagePrizePlan = 6,
	blockId = 2,
	zoneId = 3,
	unlockCostCoin = 5,
	activityId = 1,
	decs = 4
}
local dataList = {
	{
		489001,
		1,
		1,
		"梦之岛",
		"",
		1
	},
	{
		489001,
		2,
		1,
		"梦之岛",
		"10000",
		1
	},
	{
		489001,
		3,
		2,
		"奥奇城",
		"100000",
		1
	},
	{
		489001,
		4,
		2,
		"奥奇城",
		"1000000",
		1
	},
	{
		489001,
		5,
		3,
		"沙之国",
		"10000000",
		1
	},
	{
		489001,
		6,
		3,
		"沙之国",
		"50000000",
		1
	},
	{
		489002,
		1,
		1,
		"梦之岛",
		"",
		2
	},
	{
		489002,
		2,
		1,
		"梦之岛",
		"10000",
		2
	},
	{
		489002,
		3,
		2,
		"奥奇城",
		"100000",
		2
	},
	{
		489002,
		4,
		2,
		"奥奇城",
		"1000000",
		2
	},
	{
		489002,
		5,
		3,
		"沙之国",
		"10000000",
		2
	},
	{
		489002,
		6,
		3,
		"沙之国",
		"50000000",
		2
	},
	{
		489003,
		1,
		1,
		"梦之岛",
		"",
		3
	},
	{
		489003,
		2,
		1,
		"梦之岛",
		"10000",
		3
	},
	{
		489003,
		3,
		2,
		"奥奇城",
		"100000",
		3
	},
	{
		489003,
		4,
		2,
		"奥奇城",
		"1000000",
		3
	},
	{
		489003,
		5,
		3,
		"沙之国",
		"10000000",
		3
	},
	{
		489003,
		6,
		3,
		"沙之国",
		"50000000",
		3
	}
}
local t_free_scuffle_block = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[489002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[489003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_free_scuffle_block.dataList = dataList

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

return t_free_scuffle_block
