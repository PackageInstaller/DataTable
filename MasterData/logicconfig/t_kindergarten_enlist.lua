-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_enlist.lua

module("logicconfig.config.t_kindergarten_enlist", package.seeall)

local title = {
	cost = 4,
	studentPlanId = 3,
	activityId = 1,
	enlistId = 2
}
local dataList = {
	{
		353001,
		1,
		1,
		"10:353003:1"
	},
	{
		353001,
		2,
		2,
		"10:353004:1"
	}
}
local t_kindergarten_enlist = {
	[353001] = {
		dataList[1],
		dataList[2]
	}
}

t_kindergarten_enlist.dataList = dataList

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

return t_kindergarten_enlist
