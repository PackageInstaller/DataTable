-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_force_slide_tab.lua

module("logicconfig.config.t_force_slide_tab", package.seeall)

local title = {
	id = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		148001,
		1,
		"修复速率 %s"
	},
	{
		148001,
		2,
		"崩塌速率 %s"
	},
	{
		148001,
		3,
		"全服共有%d人，获得神祇·龙炎"
	},
	{
		148001,
		4,
		"全服共拯救了%d只虚弱的精灵"
	},
	{
		148001,
		5,
		"全服共修复了%d层力量神柱"
	},
	{
		148001,
		6,
		"全服共压制了%d只暴走精灵"
	}
}
local t_force_slide_tab = {
	[148001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_force_slide_tab.dataList = dataList

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

return t_force_slide_tab
