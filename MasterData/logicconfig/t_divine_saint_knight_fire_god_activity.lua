-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_saint_knight_fire_god_activity.lua

module("logicconfig.config.t_divine_saint_knight_fire_god_activity", package.seeall)

local title = {
	nextScoreTime = 3,
	buffAddTimesLimit = 2,
	buffPlanId = 6,
	skinId = 4,
	paramStr = 5,
	activityId = 1
}
local dataList = {
	{
		480001,
		4,
		9999,
		12032,
		"{\"jumpStr1\":\"func#618#12032\",\"jumpStr2\":\"mibao#shengqiyangcheng\",\"jumpStr3\":\"ui#lottery\",\"jumpStr4\":\"func#545#20\"}",
		1
	}
}
local t_divine_saint_knight_fire_god_activity = {
	[480001] = dataList[1]
}

t_divine_saint_knight_fire_god_activity.dataList = dataList

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

return t_divine_saint_knight_fire_god_activity
