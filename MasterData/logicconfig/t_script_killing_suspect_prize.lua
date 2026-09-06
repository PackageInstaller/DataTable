-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_suspect_prize.lua

module("logicconfig.config.t_script_killing_suspect_prize", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	hitNum = 2
}
local dataList = {
	{
		365001,
		0,
		"104:2:100#8:1:500000"
	},
	{
		365001,
		1,
		"104:2:400#8:1:1000000"
	},
	{
		365001,
		2,
		"104:2:600#8:1:1500000"
	},
	{
		365001,
		3,
		"104:2:1000#8:1:2000000"
	},
	{
		365002,
		0,
		"104:2:100#8:1:500000"
	},
	{
		365003,
		0,
		"104:2:50#8:1:500000"
	},
	{
		365003,
		1,
		"104:2:100#8:1:1000000"
	},
	{
		365003,
		2,
		"104:2:150#8:1:1500000"
	},
	{
		365003,
		3,
		"104:2:200#8:1:2000000"
	}
}
local t_script_killing_suspect_prize = {
	[365001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[365002] = {
		[0] = dataList[5]
	},
	[365003] = {
		[0] = dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_script_killing_suspect_prize.dataList = dataList

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

return t_script_killing_suspect_prize
