-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_friend_bargain_reduce.lua

module("logicconfig.config.t_friend_bargain_reduce", package.seeall)

local title = {
	reduceId = 2,
	reducePlanId = 1,
	reduceRange = 4,
	status = 3
}
local dataList = {
	{
		1,
		1,
		1,
		{
			100,
			100
		}
	},
	{
		1,
		2,
		2,
		{
			200,
			200
		}
	},
	{
		1,
		3,
		3,
		{
			30,
			60
		}
	}
}
local t_friend_bargain_reduce = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_friend_bargain_reduce.dataList = dataList

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

return t_friend_bargain_reduce
