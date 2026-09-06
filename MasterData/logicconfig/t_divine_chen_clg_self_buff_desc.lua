-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_self_buff_desc.lua

module("logicconfig.config.t_divine_chen_clg_self_buff_desc", package.seeall)

local title = {
	sortId = 2,
	zoneDesc = 3,
	planId = 1,
	showDesc = 4
}
local dataList = {
	{
		1,
		1,
		"1-2",
		"我方战力最高的女性精灵每个大回合结束时+5点气势"
	},
	{
		1,
		2,
		"3-4",
		"我方战力最高的女性精灵每个大回合结束时+15点气势"
	},
	{
		1,
		3,
		"5-6",
		"我方战力最高的女性精灵每个大回合结束时+25点气势"
	},
	{
		2,
		1,
		"1-2",
		"我方战力最高的女性精灵每个大回合结束时+5点气势"
	},
	{
		2,
		2,
		"3-4",
		"我方战力最高的女性精灵每个大回合结束时+15点气势"
	},
	{
		2,
		3,
		"5-6",
		"我方战力最高的女性精灵每个大回合结束时+25点气势"
	}
}
local t_divine_chen_clg_self_buff_desc = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_chen_clg_self_buff_desc.dataList = dataList

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

return t_divine_chen_clg_self_buff_desc
