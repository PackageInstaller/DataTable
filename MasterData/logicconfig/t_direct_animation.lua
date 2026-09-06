-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_animation.lua

module("logicconfig.config.t_direct_animation", package.seeall)

local title = {
	activityId = 1,
	animPath = 2
}
local dataList = {
	{
		75001,
		"storyconfig/animations/tong_dengchang.txt"
	},
	{
		75002,
		"storyconfig/animations/qianli_dengchang.txt"
	},
	{
		75003,
		"storyconfig/animations/xinian_dengchang.txt"
	},
	{
		86001,
		"storyconfig/animations/longnv_dengchang.txt"
	},
	{
		75004,
		"storyconfig/animations/yadianna_dengchang.txt"
	},
	{
		86002,
		"storyconfig/animations/xinxiya_dengchang.txt"
	}
}
local t_direct_animation = {
	[75001] = dataList[1],
	[75002] = dataList[2],
	[75003] = dataList[3],
	[86001] = dataList[4],
	[75004] = dataList[5],
	[86002] = dataList[6]
}

t_direct_animation.dataList = dataList

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

return t_direct_animation
