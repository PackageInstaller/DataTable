-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_competition_form_check.lua

module("logicconfig.config.t_annual_competition_form_check", package.seeall)

local title = {
	id = 1,
	career = 2
}
local dataList = {
	{
		1,
		"英雄"
	},
	{
		2,
		"召唤师"
	},
	{
		3,
		"肉盾"
	},
	{
		4,
		"利爪|魔法"
	}
}
local t_annual_competition_form_check = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_annual_competition_form_check.dataList = dataList

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

return t_annual_competition_form_check
