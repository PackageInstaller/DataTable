-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_name_rules.lua

module("logicconfig.config.t_name_rules", package.seeall)

local title = {
	id = 1,
	index = 2
}
local dataList = {
	{
		1,
		"1#2#3"
	},
	{
		2,
		"4#5#6"
	},
	{
		3,
		"7#8#9"
	}
}
local t_name_rules = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_name_rules.dataList = dataList

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

return t_name_rules
