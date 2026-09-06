-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_redraw_cost.lua

module("logicconfig.config.t_divine_jieshen_clg_redraw_cost", package.seeall)

local title = {
	redrawPlanId = 1,
	cost = 3,
	redrawTimes = 2
}
local dataList = {
	{
		1,
		1,
		"105:6099:200"
	},
	{
		1,
		2,
		"105:6099:200"
	},
	{
		1,
		3,
		"105:6099:200"
	},
	{
		1,
		4,
		"105:6099:200"
	},
	{
		1,
		5,
		"105:6099:200"
	}
}
local t_divine_jieshen_clg_redraw_cost = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_jieshen_clg_redraw_cost.dataList = dataList

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

return t_divine_jieshen_clg_redraw_cost
