-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_activity.lua

module("logicconfig.config.t_family_activity", package.seeall)

local title = {
	titleStr = 7,
	name = 2,
	id = 1,
	jumpTo = 6,
	redpointId = 4,
	params = 8,
	grpIndex = 5,
	sort = 3
}
local dataList = {
	{
		1,
		"家族围剿",
		2,
		0,
		3,
		"func#252",
		"次  数",
		""
	},
	{
		2,
		"家族任务",
		3,
		246,
		4,
		"ui#familytask",
		"",
		""
	},
	{
		3,
		"家族捐献",
		4,
		0,
		0,
		"ui#familycontribution",
		"次  数",
		""
	},
	{
		4,
		"家族Boss",
		5,
		33,
		1,
		"ui#familybossview",
		"",
		""
	},
	{
		5,
		"家族护送",
		6,
		-226,
		2,
		"",
		"次  数",
		""
	},
	{
		6,
		"家族之战",
		1,
		0,
		5,
		"",
		"次  数",
		""
	}
}
local t_family_activity = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_family_activity.dataList = dataList

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

return t_family_activity
