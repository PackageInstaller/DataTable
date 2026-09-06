-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_random_form.lua

module("logicconfig.config.t_show_down_random_form", package.seeall)

local title = {
	buffId = 5,
	randomFormPlanId = 1,
	creepsMasterId = 3,
	selectBuffPlanId = 4,
	formId = 2
}
local dataList = {
	{
		1,
		1,
		1001,
		2,
		1
	},
	{
		1,
		2,
		1002,
		2,
		2
	},
	{
		1,
		3,
		1003,
		2,
		3
	},
	{
		1,
		4,
		1004,
		2,
		4
	},
	{
		1,
		5,
		1005,
		2,
		5
	},
	{
		1,
		6,
		1006,
		2,
		6
	},
	{
		1,
		7,
		1007,
		2,
		7
	}
}
local t_show_down_random_form = {
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

t_show_down_random_form.dataList = dataList

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

return t_show_down_random_form
