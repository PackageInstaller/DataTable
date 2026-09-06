-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_act.lua

module("logicconfig.config.t_throw_shells_act", package.seeall)

local title = {
	buyTimesPlan = 3,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		64001,
		1,
		1
	}
}
local t_throw_shells_act = {
	[64001] = dataList[1]
}

t_throw_shells_act.dataList = dataList

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

return t_throw_shells_act
