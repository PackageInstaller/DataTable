-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_common.lua

module("logicconfig.config.t_form_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DEFAULT_GROUP_NAME",
		"预设分组1"
	},
	{
		"DEFAULT_TAB_NAME",
		"预设阵容1"
	},
	{
		"GROUP_NUM_LIMIT",
		"10"
	}
}
local t_form_common = {
	DEFAULT_GROUP_NAME = dataList[1],
	DEFAULT_TAB_NAME = dataList[2],
	GROUP_NUM_LIMIT = dataList[3]
}

t_form_common.dataList = dataList

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

return t_form_common
