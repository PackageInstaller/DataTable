-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_buff.lua

module("logicconfig.config.t_element_spark_buff", package.seeall)

local title = {
	describ = 3,
	name = 2,
	buffId = 1,
	icon = 4
}
local dataList = {
	{
		1,
		"守军加强lv.1",
		"守阵全属性提高5%，5回合后结束战斗",
		"icon_expedition_ydnzhufu"
	},
	{
		2,
		"守军加强lv.2",
		"守阵全属性提高10%，4回合后结束战斗",
		"icon_expedition_ydnzhufu"
	},
	{
		3,
		"守军加强lv.3",
		"守阵全属性提高15%，3回合后结束战斗",
		"icon_expedition_ydnzhufu"
	}
}
local t_element_spark_buff = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_element_spark_buff.dataList = dataList

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

return t_element_spark_buff
