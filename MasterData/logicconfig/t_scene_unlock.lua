-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_unlock.lua

module("logicconfig.config.t_scene_unlock", package.seeall)

local title = {
	triggerType = 3,
	lockTips = 5,
	sceneId = 2,
	unlockTips = 6,
	index = 1,
	triggerParams = 4
}
local dataList = {
	{
		2,
		105,
		"Task",
		"7",
		82007972,
		0
	},
	{
		3,
		111,
		"Task",
		"7",
		82007973,
		0
	},
	{
		4,
		114,
		"Task",
		"7",
		82007974,
		0
	},
	{
		5,
		117,
		"Task",
		"7",
		82007975,
		0
	},
	{
		6,
		118,
		"Task",
		"7",
		82007976,
		0
	},
	{
		7,
		119,
		"Task",
		"7",
		82007977,
		0
	},
	{
		8,
		120,
		"Task",
		"7",
		82007978,
		0
	},
	{
		9,
		121,
		"Task",
		"7",
		82007979,
		0
	},
	{
		10,
		122,
		"Task",
		"7",
		82007980,
		0
	},
	{
		11,
		123,
		"Task",
		"7",
		82007981,
		0
	},
	{
		12,
		124,
		"Task",
		"7",
		82007982,
		0
	},
	{
		13,
		126,
		"Task",
		"7",
		82007982,
		0
	},
	{
		14,
		127,
		"Task",
		"7",
		82007982,
		0
	},
	{
		15,
		128,
		"Task",
		"7",
		82007983,
		0
	},
	{
		16,
		129,
		"Task",
		"7",
		82007984,
		0
	}
}
local t_scene_unlock = {
	[2] = dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[6] = dataList[5],
	[7] = dataList[6],
	[8] = dataList[7],
	[9] = dataList[8],
	[10] = dataList[9],
	[11] = dataList[10],
	[12] = dataList[11],
	[13] = dataList[12],
	[14] = dataList[13],
	[15] = dataList[14],
	[16] = dataList[15]
}

t_scene_unlock.dataList = dataList

local multiLanguageCells = {
	unlockTips = true,
	lockTips = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_scene_unlock
