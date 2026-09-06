-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_diamond_privilege.lua

module("logicconfig.config.t_golden_diamond_privilege", package.seeall)

local title = {
	param = 3,
	itemName = 2,
	type = 1
}
local dataList = {
	{
		1,
		"免费神唤",
		1
	},
	{
		2,
		"招财猫",
		1
	},
	{
		3,
		"冒险幻境扫荡翻倍",
		10
	},
	{
		4,
		"主线副本扫荡翻倍",
		10
	},
	{
		5,
		"免费性转",
		0
	},
	{
		6,
		"世界boss免费次数",
		1
	},
	{
		7,
		"护送一键完成",
		0
	},
	{
		8,
		"失落遗迹第二层扫荡",
		4
	},
	{
		9,
		"免费资源找回",
		0
	}
}
local t_golden_diamond_privilege = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_golden_diamond_privilege.dataList = dataList

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

return t_golden_diamond_privilege
