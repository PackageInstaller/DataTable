-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_buff_plan.lua

module("logicconfig.config.t_star_battle_buff_plan", package.seeall)

local title = {
	buffPlanId = 1,
	signInDays = 3,
	buffId = 2,
	buffDesc = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"最大生命&全属性+10%"
	},
	{
		1,
		2,
		2,
		"最大生命&全属性+50%"
	},
	{
		1,
		3,
		3,
		"最大生命&全属性+300%"
	},
	{
		1,
		4,
		4,
		"最大生命&全属性+800%"
	},
	{
		2,
		1,
		1,
		"最大生命&全属性+10%"
	},
	{
		2,
		2,
		2,
		"最大生命&全属性+50%"
	},
	{
		2,
		3,
		3,
		"最大生命&全属性+300%"
	},
	{
		2,
		4,
		4,
		"最大生命&全属性+800%"
	},
	{
		3,
		1,
		1,
		"最大生命&全属性+10%"
	},
	{
		3,
		2,
		2,
		"最大生命&全属性+50%"
	},
	{
		3,
		3,
		3,
		"最大生命&全属性+300%"
	},
	{
		3,
		4,
		4,
		"最大生命&全属性+800%"
	},
	{
		4,
		1,
		1,
		"最大生命&全属性+10%"
	},
	{
		4,
		2,
		2,
		"最大生命&全属性+50%"
	},
	{
		4,
		3,
		3,
		"最大生命&全属性+300%"
	},
	{
		4,
		4,
		4,
		"最大生命&全属性+800%"
	}
}
local t_star_battle_buff_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_star_battle_buff_plan.dataList = dataList

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

return t_star_battle_buff_plan
