-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_immortal_movement_note.lua

module("logicconfig.config.t_immortal_movement_note", package.seeall)

local title = {
	color = 3,
	activityId = 1,
	noteId = 2
}
local dataList = {
	{
		484001,
		1,
		"红"
	},
	{
		484001,
		2,
		"黄"
	},
	{
		484001,
		3,
		"蓝"
	},
	{
		484001,
		4,
		"绿"
	},
	{
		484001,
		5,
		"青"
	},
	{
		484001,
		6,
		"紫"
	},
	{
		484001,
		7,
		"白"
	}
}
local t_immortal_movement_note = {
	[484001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_immortal_movement_note.dataList = dataList

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

return t_immortal_movement_note
