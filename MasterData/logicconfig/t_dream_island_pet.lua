-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_island_pet.lua

module("logicconfig.config.t_dream_island_pet", package.seeall)

local title = {
	dayNum = 2,
	rawPos = 5,
	raceId = 3,
	activityId = 1,
	des = 4
}
local dataList = {
	{
		33001,
		1,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		2,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		3,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		4,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		5,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		6,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	},
	{
		33001,
		7,
		10342,
		"你要和我一起去追赶太阳吗？这可不是玩笑，我一定会比它还快！",
		{
			-73,
			-835,
			-1.5
		}
	}
}
local t_dream_island_pet = {
	[33001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_dream_island_pet.dataList = dataList

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

return t_dream_island_pet
