-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_kong_union_breach_form.lua

module("logicconfig.config.t_chuang_kong_union_breach_form", package.seeall)

local title = {
	startTime = 3,
	preBreachFormTask = 5,
	endTime = 4,
	planId = 1,
	taskId = 2
}
local dataList = {
	{
		1,
		1,
		"2021-12-31T05:00:00",
		"2022-02-11T05:00:00",
		{}
	},
	{
		1,
		2,
		"2022-01-14T05:00:00",
		"2022-02-11T05:00:00",
		{
			1,
			10
		}
	}
}
local t_chuang_kong_union_breach_form = {
	{
		dataList[1],
		dataList[2]
	}
}

t_chuang_kong_union_breach_form.dataList = dataList

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

return t_chuang_kong_union_breach_form
