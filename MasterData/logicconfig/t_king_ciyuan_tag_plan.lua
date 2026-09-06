-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_tag_plan.lua

module("logicconfig.config.t_king_ciyuan_tag_plan", package.seeall)

local title = {
	name = 3,
	extTagPlan = 1,
	tagId = 2
}
local dataList = {
	{
		1,
		1,
		"战意"
	},
	{
		1,
		2,
		"识破"
	},
	{
		1,
		3,
		"猛击"
	},
	{
		1,
		4,
		"强生"
	},
	{
		1,
		5,
		"嗜血"
	},
	{
		1,
		6,
		"增气"
	},
	{
		1,
		7,
		"振奋"
	}
}
local t_king_ciyuan_tag_plan = {
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

t_king_ciyuan_tag_plan.dataList = dataList

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

return t_king_ciyuan_tag_plan
