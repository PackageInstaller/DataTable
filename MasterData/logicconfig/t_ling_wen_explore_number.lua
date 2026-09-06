-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_explore_number.lua

module("logicconfig.config.t_ling_wen_explore_number", package.seeall)

local title = {
	num4 = 5,
	num6 = 7,
	num3 = 4,
	num5 = 6,
	num1 = 2,
	planId = 1,
	num2 = 3
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
}
local t_ling_wen_explore_number = {
	dataList[1]
}

t_ling_wen_explore_number.dataList = dataList

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

return t_ling_wen_explore_number
