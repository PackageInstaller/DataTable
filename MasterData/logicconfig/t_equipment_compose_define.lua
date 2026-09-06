-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_compose_define.lua

module("logicconfig.config.t_equipment_compose_define", package.seeall)

local title = {
	itemPos = 7,
	topShowMat = 9,
	tabId = 1,
	planId = 4,
	subName = 3,
	tabDes = 6,
	redPointId = 5,
	icon = 8,
	mainName = 2
}
local dataList = {
	{
		1,
		"装备合成",
		"装备合成",
		1,
		331,
		"合成指定属性<color=#cd7800>橙+1</color>、<color=#cd7800>橙</color>\r\n随机属性<color=#cd7800>橙</color>等装备",
		"-338,-3",
		"board_lianjin_05",
		"4:8003#4:8002#8:1#105:1"
	},
	{
		2,
		"收藏品",
		"藏品置换",
		2,
		332,
		"置换指定/随机<color=#cd7800>橙色</color>、<color=#df5bff>紫</color>、<color=#0083e7>蓝</color>随机收藏品",
		"0,188",
		"board_lianjin_04",
		"4:2003#4:2002#4:2001#4:2000"
	},
	{
		3,
		"星神",
		"星神合成",
		3,
		333,
		"合成<color=#cd7800>气吞</color>\r\n指定<color=#cd7800>金色</color>星神",
		"0,-188",
		"board_lianjin_06",
		"105:1#8:1"
	},
	{
		4,
		"装备强化",
		"装备强化",
		0,
		0,
		"<color=#cd7800>强化所有</color>装备\r\n突破<color=#cd7800>橙+1</color>、<color=#cd7800>橙+2</color>",
		"338,-3",
		"board_lianjin_10",
		""
	}
}
local t_equipment_compose_define = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_equipment_compose_define.dataList = dataList

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

return t_equipment_compose_define
