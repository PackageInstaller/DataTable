-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_preheat_prize.lua

module("logicconfig.config.t_anniversary_preheat_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		141001,
		1,
		50000,
		"104:2:50"
	},
	{
		141001,
		2,
		150000,
		"104:2:50"
	},
	{
		141001,
		3,
		300000,
		"104:2:50"
	},
	{
		141001,
		4,
		500000,
		"104:2:50"
	},
	{
		141001,
		5,
		800000,
		"104:2:100"
	}
}
local t_anniversary_preheat_prize = {
	[141001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_anniversary_preheat_prize.dataList = dataList

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

return t_anniversary_preheat_prize
