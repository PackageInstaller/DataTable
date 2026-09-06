-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_egg_plan.lua

module("logicconfig.config.t_bury_pit_egg_plan", package.seeall)

local title = {
	score = 2,
	weight = 3,
	planId = 1
}
local dataList = {
	{
		1,
		200,
		10
	},
	{
		1,
		300,
		50
	},
	{
		1,
		400,
		100
	}
}
local t_bury_pit_egg_plan = {
	{
		[200] = dataList[1],
		[300] = dataList[2],
		[400] = dataList[3]
	}
}

t_bury_pit_egg_plan.dataList = dataList

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

return t_bury_pit_egg_plan
