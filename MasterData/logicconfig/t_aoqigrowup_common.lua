-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqigrowup_common.lua

module("logicconfig.config.t_aoqigrowup_common", package.seeall)

local title = {
	id = 1,
	info = 2
}
local dataList = {
	{
		"OLD_VIDEO",
		""
	},
	{
		"NEW_VIDEO",
		""
	},
	{
		"NONE_SELECT_TYPE",
		"请先选择一种身份"
	},
	{
		"FIRST_DIALOG",
		"201#202"
	},
	{
		"END_DIALOG",
		"801#802"
	}
}
local t_aoqigrowup_common = {
	OLD_VIDEO = dataList[1],
	NEW_VIDEO = dataList[2],
	NONE_SELECT_TYPE = dataList[3],
	FIRST_DIALOG = dataList[4],
	END_DIALOG = dataList[5]
}

t_aoqigrowup_common.dataList = dataList

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

return t_aoqigrowup_common
