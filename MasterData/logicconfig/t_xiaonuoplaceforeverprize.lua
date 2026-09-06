-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiaonuoplaceforeverprize.lua

module("logicconfig.config.t_xiaonuoplaceforeverprize", package.seeall)

local title = {
	id = 2,
	target = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		119001,
		1,
		"3000000",
		"100:12001:1:1"
	}
}
local t_xiaonuoplaceforeverprize = {
	[119001] = {
		dataList[1]
	}
}

t_xiaonuoplaceforeverprize.dataList = dataList

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

return t_xiaonuoplaceforeverprize
