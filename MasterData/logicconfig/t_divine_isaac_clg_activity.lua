-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_activity.lua

module("logicconfig.config.t_divine_isaac_clg_activity", package.seeall)

local title = {
	paramStr = 3,
	activityId = 1,
	redPointId = 2,
	skinId = 4
}
local dataList = {
	{
		491001,
		707,
		"{\"jumpStr1\":\"func#618#16036\",\"jumpStr2\":\"mibao#shenyaomiya5\",\"jumpStr3\":\"ui#lottery\"}",
		16036
	}
}
local t_divine_isaac_clg_activity = {
	[491001] = dataList[1]
}

t_divine_isaac_clg_activity.dataList = dataList

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

return t_divine_isaac_clg_activity
