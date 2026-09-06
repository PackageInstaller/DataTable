-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_excellent_class_base_new.lua

module("logicconfig.config.t_excellent_class_base_new", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"VIEW_TABLE_NAME",
		"潜能,守护,体力"
	},
	{
		"TIME_SEVEN-DAY",
		"12"
	},
	{
		"TIME_TWENTYONE-DAY",
		"28"
	}
}
local t_excellent_class_base_new = {
	VIEW_TABLE_NAME = dataList[1],
	["TIME_SEVEN-DAY"] = dataList[2],
	["TIME_TWENTYONE-DAY"] = dataList[3]
}

t_excellent_class_base_new.dataList = dataList

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

return t_excellent_class_base_new
