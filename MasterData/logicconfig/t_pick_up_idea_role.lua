-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pick_up_idea_role.lua

module("logicconfig.config.t_pick_up_idea_role", package.seeall)

local title = {
	activityItemId = 3,
	skinId = 5,
	jumpTo = 4,
	roleId = 2,
	activityId = 1
}
local dataList = {
	{
		338001,
		1,
		338001,
		"func#1027",
		1402201
	},
	{
		338001,
		2,
		338002,
		"func#1022",
		1402301
	},
	{
		338001,
		3,
		338003,
		"func#766",
		1701502
	},
	{
		338001,
		4,
		338004,
		"func#342",
		1502402
	}
}
local t_pick_up_idea_role = {
	[338001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_pick_up_idea_role.dataList = dataList

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

return t_pick_up_idea_role
