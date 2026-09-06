-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_buff.lua

module("logicconfig.config.t_guard_city_buff", package.seeall)

local title = {
	des = 3,
	buffPlanId = 1,
	days = 2
}
local dataList = {
	{
		1,
		1,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		2,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		3,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		4,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		5,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		6,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	},
	{
		1,
		7,
		{
			"14013,14014",
			" <color=#20B376FF>精灵属性+10%</color>"
		}
	}
}
local t_guard_city_buff = {
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

t_guard_city_buff.dataList = dataList

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

return t_guard_city_buff
