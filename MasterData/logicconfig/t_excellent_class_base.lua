-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_excellent_class_base.lua

module("logicconfig.config.t_excellent_class_base", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"VIEW_TABLE_NAME",
		"等级,装备,星神"
	}
}
local t_excellent_class_base = {
	VIEW_TABLE_NAME = dataList[1]
}

t_excellent_class_base.dataList = dataList

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

return t_excellent_class_base
