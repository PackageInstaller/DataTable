-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_buff.lua

module("logicconfig.config.t_divine_xing_jiang_clg_buff", package.seeall)

local title = {
	buffDesc = 4,
	name = 3,
	activityId = 1,
	progress = 2
}
local dataList = {
	{
		359001,
		30,
		"第一级",
		"全属性+10%"
	},
	{
		359001,
		60,
		"第二级",
		"全属性+30%"
	},
	{
		359001,
		90,
		"第三级",
		"全属性+50%"
	},
	{
		359001,
		120,
		"第四级",
		"全属性+100%"
	},
	{
		359001,
		150,
		"第五级",
		"全属性+500%"
	},
	{
		359001,
		180,
		"第六级",
		"全属性+1000%"
	}
}
local t_divine_xing_jiang_clg_buff = {
	[359001] = {
		[30] = dataList[1],
		[60] = dataList[2],
		[90] = dataList[3],
		[120] = dataList[4],
		[150] = dataList[5],
		[180] = dataList[6]
	}
}

t_divine_xing_jiang_clg_buff.dataList = dataList

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

return t_divine_xing_jiang_clg_buff
