-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_buff.lua

module("logicconfig.config.t_dragon_dishitian_buff", package.seeall)

local title = {
	buffdesc = 5,
	buffType = 2,
	progress = 4,
	activityId = 1,
	level = 3
}
local dataList = {
	{
		343002,
		1,
		1,
		200,
		"最大生命&全属性+5%，下一级需300进度"
	},
	{
		343002,
		1,
		2,
		300,
		"最大生命&全属性+25%，下一级需400进度"
	},
	{
		343002,
		1,
		3,
		400,
		"最大生命&全属性+150%，下一级需500进度"
	},
	{
		343002,
		1,
		4,
		500,
		"最大生命&全属性+400%，下一级需600进度"
	},
	{
		343002,
		1,
		5,
		600,
		"最大生命&全属性+800%"
	},
	{
		343002,
		2,
		1,
		200,
		"暴击率+10%，下一级需300进度"
	},
	{
		343002,
		2,
		2,
		300,
		"暴击率+20%，下一级需400进度"
	},
	{
		343002,
		2,
		3,
		400,
		"暴击率+30%，下一级需500进度"
	},
	{
		343002,
		2,
		4,
		500,
		"暴击率+40%，下一级需600进度"
	},
	{
		343002,
		2,
		5,
		600,
		"暴击率+50%"
	}
}
local t_dragon_dishitian_buff = {
	[343002] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		}
	}
}

t_dragon_dishitian_buff.dataList = dataList

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

return t_dragon_dishitian_buff
