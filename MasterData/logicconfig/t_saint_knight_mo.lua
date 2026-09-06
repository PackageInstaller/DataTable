-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_mo.lua

module("logicconfig.config.t_saint_knight_mo", package.seeall)

local title = {
	progress = 4,
	activityId = 1,
	prize = 5,
	monthCardId = 3,
	showItemId = 2
}
local dataList = {
	{
		179001,
		"4:80337:1#7:212007108:0:1#7:212007208:0:1",
		6,
		2,
		"100:12007:1:1#8:1:1500000#4:80337:1#4:90291:2"
	},
	{
		179002,
		"",
		6,
		2,
		"4:90315:1"
	},
	{
		179003,
		"",
		6,
		2,
		"4:90315:1"
	},
	{
		179004,
		"",
		6,
		2,
		"4:211:100"
	},
	{
		179005,
		"",
		6,
		2,
		"4:233:100"
	},
	{
		179006,
		"",
		9,
		2,
		"4:510364:1"
	},
	{
		179007,
		"",
		9,
		2,
		"100:11026:1:1"
	},
	{
		179008,
		"",
		12,
		1,
		"17:1503301:-1:1"
	},
	{
		179009,
		"",
		9,
		2,
		"4:288:100"
	},
	{
		179010,
		"",
		9,
		2,
		"4:288:100"
	},
	{
		179011,
		"",
		9,
		2,
		"4:398:100"
	},
	{
		179012,
		"",
		9,
		2,
		"4:398:100"
	},
	{
		179013,
		"",
		9,
		2,
		"4:510637:100"
	}
}
local t_saint_knight_mo = {
	[179001] = dataList[1],
	[179002] = dataList[2],
	[179003] = dataList[3],
	[179004] = dataList[4],
	[179005] = dataList[5],
	[179006] = dataList[6],
	[179007] = dataList[7],
	[179008] = dataList[8],
	[179009] = dataList[9],
	[179010] = dataList[10],
	[179011] = dataList[11],
	[179012] = dataList[12],
	[179013] = dataList[13]
}

t_saint_knight_mo.dataList = dataList

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

return t_saint_knight_mo
