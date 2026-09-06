-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_explore_speed.lua

module("logicconfig.config.t_ling_wen_explore_speed", package.seeall)

local title = {
	planId = 1,
	speed = 2
}
local dataList = {
	{
		1,
		0.4
	},
	{
		2,
		0.7
	},
	{
		3,
		1.1
	}
}
local t_ling_wen_explore_speed = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_ling_wen_explore_speed.dataList = dataList

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

return t_ling_wen_explore_speed
