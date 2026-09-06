-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_role_relationship_box.lua

module("logicconfig.config.t_role_relationship_box", package.seeall)

local title = {
	showType = 6,
	boxId = 2,
	boxSize = 5,
	headPos = 3,
	boxPlanId = 1,
	title = 4
}
local dataList = {
	{
		1,
		1,
		{
			827,
			-640
		},
		"叛乱方",
		{
			616,
			590
		},
		2
	},
	{
		1,
		2,
		{
			-210,
			2
		},
		"和平方",
		{
			758,
			511
		},
		1
	},
	{
		1,
		3,
		{
			-110,
			-640
		},
		"激进方",
		{
			1030,
			618
		},
		3
	},
	{
		1,
		4,
		{
			420,
			465
		},
		"中立方",
		{
			656,
			225
		},
		1
	}
}
local t_role_relationship_box = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_role_relationship_box.dataList = dataList

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

return t_role_relationship_box
