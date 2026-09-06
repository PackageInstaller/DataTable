-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dress_discount_collect.lua

module("logicconfig.config.t_dress_discount_collect", package.seeall)

local title = {
	param = 4,
	jumpto = 6,
	hide = 7,
	type = 3,
	id = 2,
	prize = 5,
	activityId = 1
}
local dataList = {
	{
		159006,
		1,
		100,
		17010,
		"8:1:1000",
		"func#545#2",
		true
	},
	{
		159006,
		2,
		100,
		17010,
		"1:400033:-1:1",
		"func#5077",
		false
	},
	{
		159006,
		3,
		100,
		17010,
		"8:1:1000",
		"func#545#1",
		true
	}
}
local t_dress_discount_collect = {
	[159006] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dress_discount_collect.dataList = dataList

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

return t_dress_discount_collect
