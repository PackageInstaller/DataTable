-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_rank.lua

module("logicconfig.config.t_richman_rank", package.seeall)

local title = {
	rankPlanId = 1,
	prize = 3,
	rightTop = 2
}
local dataList = {
	{
		1,
		1,
		"104:2:1000#8:1:1000000"
	},
	{
		1,
		10,
		"104:2:800#8:1:800000"
	},
	{
		1,
		100,
		"104:2:500#8:1:500000"
	},
	{
		1,
		300,
		"104:2:300#8:1:300000"
	},
	{
		1,
		500,
		"104:2:200#8:1:200000"
	},
	{
		1,
		1000,
		"104:2:100#8:1:100000"
	}
}
local t_richman_rank = {
	{
		dataList[1],
		[10] = dataList[2],
		[100] = dataList[3],
		[300] = dataList[4],
		[500] = dataList[5],
		[1000] = dataList[6]
	}
}

t_richman_rank.dataList = dataList

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

return t_richman_rank
