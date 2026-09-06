-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_rank.lua

module("logicconfig.config.t_holy_light_rank", package.seeall)

local title = {
	activityId = 1,
	prize = 3,
	rank = 2
}
local dataList = {
	{
		254001,
		1,
		"104:2:2000#4:147:1"
	},
	{
		254001,
		10,
		"104:2:1600#4:109:1"
	},
	{
		254001,
		50,
		"104:2:1200#4:108:1"
	},
	{
		254001,
		100,
		"104:2:1000#4:108:1"
	},
	{
		254001,
		200,
		"104:2:800#4:107:1"
	},
	{
		254002,
		1,
		"104:2:2000#4:147:1"
	},
	{
		254002,
		10,
		"104:2:1600#4:109:1"
	},
	{
		254002,
		50,
		"104:2:1200#4:108:1"
	},
	{
		254002,
		100,
		"104:2:1000#4:108:1"
	},
	{
		254002,
		200,
		"104:2:800#4:107:1"
	},
	{
		254003,
		1,
		"104:2:2000#4:147:1"
	},
	{
		254003,
		10,
		"104:2:1600#4:109:1"
	},
	{
		254003,
		50,
		"104:2:1200#4:108:1"
	},
	{
		254003,
		100,
		"104:2:1000#4:108:1"
	},
	{
		254003,
		200,
		"104:2:800#4:107:1"
	},
	{
		254004,
		1,
		"104:2:2000#4:147:1"
	},
	{
		254004,
		10,
		"104:2:1600#4:109:1"
	},
	{
		254004,
		50,
		"104:2:1200#4:108:1"
	},
	{
		254004,
		100,
		"104:2:1000#4:108:1"
	},
	{
		254004,
		200,
		"104:2:800#4:107:1"
	}
}
local t_holy_light_rank = {
	[254001] = {
		dataList[1],
		[10] = dataList[2],
		[50] = dataList[3],
		[100] = dataList[4],
		[200] = dataList[5]
	},
	[254002] = {
		dataList[6],
		[10] = dataList[7],
		[50] = dataList[8],
		[100] = dataList[9],
		[200] = dataList[10]
	},
	[254003] = {
		dataList[11],
		[10] = dataList[12],
		[50] = dataList[13],
		[100] = dataList[14],
		[200] = dataList[15]
	},
	[254004] = {
		dataList[16],
		[10] = dataList[17],
		[50] = dataList[18],
		[100] = dataList[19],
		[200] = dataList[20]
	}
}

t_holy_light_rank.dataList = dataList

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

return t_holy_light_rank
