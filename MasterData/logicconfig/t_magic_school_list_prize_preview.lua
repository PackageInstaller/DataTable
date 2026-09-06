-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_list_prize_preview.lua

module("logicconfig.config.t_magic_school_list_prize_preview", package.seeall)

local title = {
	activityId = 1,
	prize = 3,
	listId = 2
}
local dataList = {
	{
		514001,
		1,
		"104:2:100"
	},
	{
		514001,
		2,
		"4:36:5"
	},
	{
		514001,
		3,
		""
	},
	{
		514001,
		4,
		"10:17168:100"
	}
}
local t_magic_school_list_prize_preview = {
	[514001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_magic_school_list_prize_preview.dataList = dataList

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

return t_magic_school_list_prize_preview
