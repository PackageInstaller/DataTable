-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_surround.lua

module("logicconfig.config.t_element_spark_surround", package.seeall)

local title = {
	production = 3,
	planId = 1,
	surroundCount = 2
}
local dataList = {
	{
		1,
		3,
		{
			4
		}
	},
	{
		1,
		6,
		{
			20
		}
	},
	{
		1,
		9,
		{
			21
		}
	},
	{
		1,
		12,
		{
			22
		}
	}
}
local t_element_spark_surround = {
	{
		[3] = dataList[1],
		[6] = dataList[2],
		[9] = dataList[3],
		[12] = dataList[4]
	}
}

t_element_spark_surround.dataList = dataList

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

return t_element_spark_surround
