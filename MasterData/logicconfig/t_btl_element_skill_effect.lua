-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_element_skill_effect.lua

module("logicconfig.config.t_btl_element_skill_effect", package.seeall)

local title = {
	name = 2,
	elementSkillId = 1,
	transformRaceTypes = 3
}
local dataList = {
	{
		913005,
		"青骨元素技",
		"草"
	},
	{
		916889,
		"元素师光测试",
		"光"
	},
	{
		917007,
		"颂世神华·诺雅元素技",
		"创"
	},
	{
		914009,
		"洛塔元素技",
		"光"
	},
	{
		916012,
		"费因元素技",
		"空"
	},
	{
		912011,
		"路西法元素技",
		"火"
	},
	{
		911018,
		"神曜星蓝龙元素技",
		"水"
	},
	{
		915022,
		"绘笔灵花·缪可元素技",
		"暗"
	},
	{
		913018,
		"神曜青骨元素技",
		"草"
	},
	{
		916037,
		"神曜费因元素技",
		"空"
	},
	{
		912035,
		"神曜路西法元素技",
		"火"
	},
	{
		911033,
		"冰奇布元素技",
		"水"
	},
	{
		915038,
		"神曜缪可元素技",
		"暗"
	},
	{
		914048,
		"虚元素技",
		"光"
	}
}
local t_btl_element_skill_effect = {
	[913005] = dataList[1],
	[916889] = dataList[2],
	[917007] = dataList[3],
	[914009] = dataList[4],
	[916012] = dataList[5],
	[912011] = dataList[6],
	[911018] = dataList[7],
	[915022] = dataList[8],
	[913018] = dataList[9],
	[916037] = dataList[10],
	[912035] = dataList[11],
	[911033] = dataList[12],
	[915038] = dataList[13],
	[914048] = dataList[14]
}

t_btl_element_skill_effect.dataList = dataList

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

return t_btl_element_skill_effect
