-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elf_king_path_params.lua

module("logicconfig.config.t_elf_king_path_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FUNCTION_ID",
		"1294"
	},
	{
		"RED_POINT_ID",
		"746"
	},
	{
		"HIDE_DAYS",
		"1"
	},
	{
		"RULE_KEY",
		"elf_king_path_rule"
	}
}
local t_elf_king_path_params = {
	FUNCTION_ID = dataList[1],
	RED_POINT_ID = dataList[2],
	HIDE_DAYS = dataList[3],
	RULE_KEY = dataList[4]
}

t_elf_king_path_params.dataList = dataList

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

return t_elf_king_path_params
