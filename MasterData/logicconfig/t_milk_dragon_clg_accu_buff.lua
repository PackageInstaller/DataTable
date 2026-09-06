-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg_accu_buff.lua

module("logicconfig.config.t_milk_dragon_clg_accu_buff", package.seeall)

local title = {
	accScore = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		451001,
		5,
		"己阵除光耀圣龙外，全属性及生命上限提高10%"
	},
	{
		451001,
		10,
		"己阵除光耀圣龙外，全属性及生命上限提高30%"
	},
	{
		451001,
		15,
		"己阵除光耀圣龙外，全属性及生命上限提高50%"
	},
	{
		451001,
		20,
		"己阵除光耀圣龙外，全属性及生命上限提高100%"
	},
	{
		451001,
		25,
		"己阵除光耀圣龙外，全属性及生命上限提高300%"
	},
	{
		451001,
		30,
		"己阵除光耀圣龙外，全属性及生命上限提高500%"
	}
}
local t_milk_dragon_clg_accu_buff = {
	[451001] = {
		[5] = dataList[1],
		[10] = dataList[2],
		[15] = dataList[3],
		[20] = dataList[4],
		[25] = dataList[5],
		[30] = dataList[6]
	}
}

t_milk_dragon_clg_accu_buff.dataList = dataList

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

return t_milk_dragon_clg_accu_buff
