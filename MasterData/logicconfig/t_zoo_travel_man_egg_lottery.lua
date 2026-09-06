-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_travel_man_egg_lottery.lua

module("logicconfig.config.t_zoo_travel_man_egg_lottery", package.seeall)

local title = {
	genePlanId = 2,
	level = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		2
	},
	{
		3,
		2
	},
	{
		4,
		3
	},
	{
		5,
		3
	},
	{
		6,
		3
	},
	{
		7,
		3
	},
	{
		8,
		3
	}
}
local t_zoo_travel_man_egg_lottery = {
	{
		dataList[1]
	},
	{
		[2] = dataList[2]
	},
	{
		[2] = dataList[3]
	},
	{
		[3] = dataList[4]
	},
	{
		[3] = dataList[5]
	},
	{
		[3] = dataList[6]
	},
	{
		[3] = dataList[7]
	},
	{
		[3] = dataList[8]
	}
}

t_zoo_travel_man_egg_lottery.dataList = dataList

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

return t_zoo_travel_man_egg_lottery
