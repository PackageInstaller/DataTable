-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_resource_convert_quality_tab.lua

module("logicconfig.config.t_resource_convert_quality_tab", package.seeall)

local title = {
	matType = 2,
	funId = 6,
	tabName = 3,
	id = 1,
	planType = 5,
	desc = 4
}
local dataList = {
	{
		1,
		7,
		"装备",
		"装备分解后强化材料<color=#C54949>100%</color>返还",
		1,
		0
	},
	{
		2,
		15,
		"收藏品",
		"可转换成以下物品",
		1,
		0
	},
	{
		3,
		4,
		"道具",
		"可转换成以下物品",
		2,
		0
	},
	{
		4,
		24,
		"灵纹",
		"可转换成以下物品",
		1,
		603
	}
}
local t_resource_convert_quality_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_resource_convert_quality_tab.dataList = dataList

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

return t_resource_convert_quality_tab
