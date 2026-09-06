-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_summon_command.lua

module("logicconfig.config.t_family_summon_command", package.seeall)

local title = {
	progressPrizePlanId = 3,
	activityId = 1,
	materialKey = 5,
	rankEndTime = 4,
	rankPrizePlanId = 2
}
local dataList = {
	{
		149001,
		1,
		1,
		"2022-05-06T05:00:00",
		"10:149001"
	}
}
local t_family_summon_command = {
	[149001] = dataList[1]
}

t_family_summon_command.dataList = dataList

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

return t_family_summon_command
