-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_role_relationship_box_ship.lua

module("logicconfig.config.t_role_relationship_box_ship", package.seeall)

local title = {
	showType = 5,
	endPos = 4,
	startPos = 3,
	showArrow = 6,
	shipId = 2,
	boxShipPlanId = 1,
	txtShipTab = 7
}
local dataList = {
	{
		1,
		1,
		{
			1,
			2
		},
		{
			-602,
			-129
		},
		4,
		false,
		"亲人"
	},
	{
		1,
		2,
		{
			1,
			3
		},
		{
			-6,
			-301
		},
		4,
		false,
		"好友"
	}
}
local t_role_relationship_box_ship = {
	{
		dataList[1],
		dataList[2]
	}
}

t_role_relationship_box_ship.dataList = dataList

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

return t_role_relationship_box_ship
