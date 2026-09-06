-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_youth_strengthen.lua

module("logicconfig.config.t_dream_youth_strengthen", package.seeall)

local title = {
	needScore = 5,
	countMax = 6,
	weekTimes = 7,
	strengthenType = 2,
	preRaceId = 3,
	prize = 4,
	strengthenPlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		"100:14005:1:1",
		1600,
		1,
		0
	},
	{
		1,
		2,
		14005,
		"",
		400,
		1,
		0
	},
	{
		1,
		3,
		14005,
		"4:84005:1",
		350,
		6,
		3
	}
}
local t_dream_youth_strengthen = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dream_youth_strengthen.dataList = dataList

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

return t_dream_youth_strengthen
