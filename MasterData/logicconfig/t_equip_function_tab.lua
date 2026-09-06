-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equip_function_tab.lua

module("logicconfig.config.t_equip_function_tab", package.seeall)

local title = {
	cost = 12,
	name = 2,
	viewSifter = 10,
	tabId = 1,
	funcId = 4,
	tag = 6,
	viewRules = 9,
	redIds = 5,
	params = 8,
	viewName = 7,
	isFilter = 11,
	sort = 3
}
local dataList = {
	{
		1,
		"强化",
		1,
		0,
		"",
		"",
		"equipstrengthen",
		"",
		"equipstrengthen",
		"equipselectlist#3:属性:属性筛选:299,1#4:职业:职业筛选:400,1#6:品质:品质筛选:400,1#5:部位:部位筛选:400,1|equipstrengthen#3:属性:属性筛选:115,240#4:职业:职业筛选:245,240#6:品质:品质筛选:400,1#5:部位:部位筛选:400,1",
		true,
		"8:1"
	},
	{
		2,
		"突破",
		2,
		0,
		"",
		"",
		"equiptupo",
		"",
		"equiptupo",
		"equipselectlist#3:属性:属性筛选:299,1#4:职业:职业筛选:400,1#6:品质:品质筛选:400,1#5:部位:部位筛选:400,1|equipstrengthen#3:属性:属性筛选:115,240#4:职业:职业筛选:245,240#6:品质:品质筛选:400,1#5:部位:部位筛选:400,2",
		true,
		""
	}
}
local t_equip_function_tab = {
	dataList[1],
	dataList[2]
}

t_equip_function_tab.dataList = dataList

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

return t_equip_function_tab
