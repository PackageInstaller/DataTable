-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_koi_number.lua

module("logicconfig.config.t_anniversary_koi_number", package.seeall)

local title = {
	numberPlanId = 1,
	id = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		1,
		5
	},
	{
		1,
		6
	}
}
local t_anniversary_koi_number = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_anniversary_koi_number.dataList = dataList

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

return t_anniversary_koi_number
