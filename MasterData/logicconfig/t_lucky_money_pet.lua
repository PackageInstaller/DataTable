-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_money_pet.lua

module("logicconfig.config.t_lucky_money_pet", package.seeall)

local title = {
	id = 2,
	activityId = 1,
	skinId = 3
}
local dataList = {
	{
		438001,
		1,
		18021
	},
	{
		438001,
		2,
		18001
	},
	{
		438001,
		3,
		12027
	},
	{
		438001,
		4,
		13022
	},
	{
		438001,
		5,
		13021
	},
	{
		438001,
		6,
		11026
	}
}
local t_lucky_money_pet = {
	[438001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_lucky_money_pet.dataList = dataList

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

return t_lucky_money_pet
