-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_answer.lua

module("logicconfig.config.t_canton_opera_road_answer", package.seeall)

local title = {
	enterLimit = 2,
	prize = 3,
	planId = 1
}
local dataList = {
	{
		1,
		"66:5:50",
		"10:189001:8"
	}
}
local t_canton_opera_road_answer = {
	dataList[1]
}

t_canton_opera_road_answer.dataList = dataList

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

return t_canton_opera_road_answer
