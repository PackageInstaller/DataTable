-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge_second.lua

module("logicconfig.config.t_miya_challenge_second", package.seeall)

local title = {
	secondPlanId = 1,
	stageId = 2,
	stageDesc = 5,
	creepsMasterId = 3,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		101,
		"8:1:111111",
		"来打我啊"
	},
	{
		1,
		2,
		102,
		"8:1:111111",
		"来打我啊"
	}
}
local t_miya_challenge_second = {
	{
		dataList[1],
		dataList[2]
	}
}

t_miya_challenge_second.dataList = dataList

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

return t_miya_challenge_second
