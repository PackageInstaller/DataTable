-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_sign_in_buff.lua

module("logicconfig.config.t_ultimate_trial_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	signInBuffPlanId = 1,
	iconPath = 4,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"全属性+400%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		2,
		"全属性+500%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		3,
		"全属性+600%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		4,
		"全属性+600%\r\n初始气势+50",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		5,
		"全属性+600%\r\n初始气势+50,暴击+25%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		6,
		"全属性+700%\r\n初始气势+50,暴击+25%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		7,
		"全属性+800%\r\n初始气势+50,暴击+25%",
		"expevents/icon_expedition_xieli01"
	}
}
local t_ultimate_trial_sign_in_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_ultimate_trial_sign_in_buff.dataList = dataList

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

return t_ultimate_trial_sign_in_buff
