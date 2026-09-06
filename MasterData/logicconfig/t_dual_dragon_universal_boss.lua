-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_dragon_universal_boss.lua

module("logicconfig.config.t_dual_dragon_universal_boss", package.seeall)

local title = {
	creepsMasterId = 2,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		258001,
		101,
		10326
	},
	{
		258001,
		102,
		10313
	},
	{
		258001,
		103,
		10324
	},
	{
		258001,
		104,
		10027
	},
	{
		258001,
		105,
		10127
	},
	{
		258001,
		106,
		16003
	},
	{
		258001,
		107,
		16004
	},
	{
		258001,
		108,
		17002
	},
	{
		258001,
		109,
		10320
	},
	{
		258001,
		110,
		10325
	},
	{
		258002,
		101,
		10326
	},
	{
		258002,
		102,
		10313
	},
	{
		258002,
		103,
		10324
	},
	{
		258002,
		104,
		10027
	},
	{
		258002,
		105,
		10127
	},
	{
		258002,
		106,
		16003
	},
	{
		258002,
		107,
		16004
	},
	{
		258002,
		108,
		17002
	},
	{
		258002,
		109,
		10320
	},
	{
		258002,
		110,
		10325
	}
}
local t_dual_dragon_universal_boss = {
	[258001] = {
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4],
		[105] = dataList[5],
		[106] = dataList[6],
		[107] = dataList[7],
		[108] = dataList[8],
		[109] = dataList[9],
		[110] = dataList[10]
	},
	[258002] = {
		[101] = dataList[11],
		[102] = dataList[12],
		[103] = dataList[13],
		[104] = dataList[14],
		[105] = dataList[15],
		[106] = dataList[16],
		[107] = dataList[17],
		[108] = dataList[18],
		[109] = dataList[19],
		[110] = dataList[20]
	}
}

t_dual_dragon_universal_boss.dataList = dataList

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

return t_dual_dragon_universal_boss
