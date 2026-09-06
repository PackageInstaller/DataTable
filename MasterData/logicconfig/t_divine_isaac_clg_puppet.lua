-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_puppet.lua

module("logicconfig.config.t_divine_isaac_clg_puppet", package.seeall)

local title = {
	puppetId = 3,
	buffDesc = 5,
	phaseId = 2,
	formula = 4,
	activityId = 1
}
local dataList = {
	{
		491001,
		1,
		1,
		"1:1#2:1",
		"己阵精灵起始气势+50"
	},
	{
		491001,
		1,
		2,
		"1:1#3:1",
		"己阵精灵生命上限及全属性提高20%"
	},
	{
		491001,
		1,
		3,
		"2:1#3:1",
		"己阵每只精灵获得免疫（持续1次攻击）"
	},
	{
		491001,
		2,
		1,
		"1:1#2:1",
		"己阵精灵起始气势+50"
	},
	{
		491001,
		2,
		2,
		"1:1#3:1",
		"己阵精灵生命上限及全属性提高20%"
	},
	{
		491001,
		2,
		3,
		"2:1#3:1",
		"己阵每只精灵获得免疫（持续1次攻击）"
	},
	{
		491001,
		3,
		1,
		"1:2#2:2",
		"己阵精灵起始气势+50"
	},
	{
		491001,
		3,
		2,
		"1:2#3:2",
		"己阵精灵生命上限及全属性提高20%"
	},
	{
		491001,
		3,
		3,
		"2:2#3:2",
		"己阵每只精灵获得免疫（持续1次攻击）"
	}
}
local t_divine_isaac_clg_puppet = {
	[491001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_divine_isaac_clg_puppet.dataList = dataList

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

return t_divine_isaac_clg_puppet
