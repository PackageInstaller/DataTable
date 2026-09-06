-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_person_rank_prize.lua

module("logicconfig.config.t_element_spark_person_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		311001,
		1,
		{
			1,
			200
		},
		"第1-200名",
		"1:300042:-1:1"
	},
	{
		311002,
		1,
		{
			1,
			200
		},
		"第1-200名",
		"1:300042:-1:1"
	}
}
local t_element_spark_person_rank_prize = {
	[311001] = {
		dataList[1]
	},
	[311002] = {
		dataList[2]
	}
}

t_element_spark_person_rank_prize.dataList = dataList

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

return t_element_spark_person_rank_prize
