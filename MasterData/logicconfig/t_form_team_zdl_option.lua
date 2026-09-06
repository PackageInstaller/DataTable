-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_team_zdl_option.lua

module("logicconfig.config.t_form_team_zdl_option", package.seeall)

local title = {
	id = 1,
	zdl = 2
}
local dataList = {
	{
		1,
		10000
	},
	{
		2,
		100000
	},
	{
		3,
		200000
	},
	{
		4,
		400000
	},
	{
		5,
		600000
	},
	{
		6,
		800000
	}
}
local t_form_team_zdl_option = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_form_team_zdl_option.dataList = dataList

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

return t_form_team_zdl_option
