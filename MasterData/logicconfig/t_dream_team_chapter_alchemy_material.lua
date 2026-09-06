-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_alchemy_material.lua

module("logicconfig.config.t_dream_team_chapter_alchemy_material", package.seeall)

local title = {
	materialStr = 3,
	materialId = 2,
	activityId = 1
}
local dataList = {
	{
		595001,
		1,
		"1004:1640"
	},
	{
		595001,
		2,
		"1004:1641"
	},
	{
		595001,
		3,
		"1004:1642"
	},
	{
		595001,
		4,
		"1004:1643"
	},
	{
		595001,
		5,
		"1004:1644"
	},
	{
		595001,
		6,
		"1004:1645"
	},
	{
		595001,
		7,
		"1004:1646"
	},
	{
		595001,
		8,
		"1004:1647"
	},
	{
		595001,
		9,
		"1004:1648"
	},
	{
		595001,
		10,
		"1004:1649"
	},
	{
		595001,
		11,
		"1004:1650"
	},
	{
		595001,
		12,
		"1004:1651"
	}
}
local t_dream_team_chapter_alchemy_material = {
	[595001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_dream_team_chapter_alchemy_material.dataList = dataList

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

return t_dream_team_chapter_alchemy_material
