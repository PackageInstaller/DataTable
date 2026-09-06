-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_dragon_activity.lua

module("logicconfig.config.t_divine_king_dragon_activity", package.seeall)

local title = {
	actId = 1,
	comPlanId = 3,
	redPointId = 2
}
local dataList = {
	{
		314001,
		0,
		1
	},
	{
		314002,
		0,
		1
	}
}
local t_divine_king_dragon_activity = {
	[314001] = dataList[1],
	[314002] = dataList[2]
}

t_divine_king_dragon_activity.dataList = dataList

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

return t_divine_king_dragon_activity
