-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mount_property_plan.lua

module("logicconfig.config.t_mount_property_plan", package.seeall)

local title = {
	attributePlan = 1,
	addValue = 3,
	attribute = 2
}
local dataList = {
	{
		2,
		"生命",
		18
	},
	{
		2,
		"攻击",
		3
	},
	{
		2,
		"物防",
		1
	},
	{
		2,
		"魔防",
		1
	},
	{
		3,
		"生命",
		18
	},
	{
		3,
		"攻击",
		3
	},
	{
		3,
		"物防",
		1
	},
	{
		3,
		"魔防",
		1
	},
	{
		301,
		"生命",
		16
	},
	{
		301,
		"攻击",
		3
	},
	{
		301,
		"物防",
		1
	},
	{
		301,
		"魔防",
		1
	},
	{
		4,
		"生命",
		18
	},
	{
		4,
		"攻击",
		3
	},
	{
		4,
		"物防",
		1
	},
	{
		4,
		"魔防",
		1
	},
	{
		401,
		"生命",
		16
	},
	{
		401,
		"攻击",
		3
	},
	{
		401,
		"物防",
		1
	},
	{
		401,
		"魔防",
		1
	},
	{
		402,
		"生命",
		16
	},
	{
		402,
		"攻击",
		3
	},
	{
		402,
		"物防",
		1
	},
	{
		402,
		"魔防",
		1
	}
}
local t_mount_property_plan = {
	[2] = {
		生命 = dataList[1],
		攻击 = dataList[2],
		物防 = dataList[3],
		魔防 = dataList[4]
	},
	[3] = {
		生命 = dataList[5],
		攻击 = dataList[6],
		物防 = dataList[7],
		魔防 = dataList[8]
	},
	[301] = {
		生命 = dataList[9],
		攻击 = dataList[10],
		物防 = dataList[11],
		魔防 = dataList[12]
	},
	[4] = {
		生命 = dataList[13],
		攻击 = dataList[14],
		物防 = dataList[15],
		魔防 = dataList[16]
	},
	[401] = {
		生命 = dataList[17],
		攻击 = dataList[18],
		物防 = dataList[19],
		魔防 = dataList[20]
	},
	[402] = {
		生命 = dataList[21],
		攻击 = dataList[22],
		物防 = dataList[23],
		魔防 = dataList[24]
	}
}

t_mount_property_plan.dataList = dataList

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

return t_mount_property_plan
