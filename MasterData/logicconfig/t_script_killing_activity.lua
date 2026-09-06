-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_activity.lua

module("logicconfig.config.t_script_killing_activity", package.seeall)

local title = {
	activityId = 1,
	actionPoints = 2
}
local dataList = {
	{
		365001,
		200
	},
	{
		365002,
		200
	},
	{
		365003,
		200
	}
}
local t_script_killing_activity = {
	[365001] = dataList[1],
	[365002] = dataList[2],
	[365003] = dataList[3]
}

t_script_killing_activity.dataList = dataList

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

return t_script_killing_activity
