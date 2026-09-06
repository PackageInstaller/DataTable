-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_domain_skill.lua

module("logicconfig.config.t_btl_domain_skill", package.seeall)

local title = {
	name = 2,
	skillId = 1
}
local dataList = {
	{
		714001,
		"暗夜星芒"
	},
	{
		714006,
		"审判殿堂"
	},
	{
		712002,
		"龙门焰阵"
	},
	{
		71200201,
		"龙门焰阵"
	},
	{
		711006,
		"神水天围"
	},
	{
		71100601,
		"神水天围"
	},
	{
		713003,
		"万象空垒"
	},
	{
		71300301,
		"万象空垒"
	},
	{
		715015,
		"神启修尔领域技"
	},
	{
		71501501,
		"神启修尔领域技"
	},
	{
		71400606,
		"审判殿堂"
	},
	{
		71400101,
		"暗夜星芒"
	}
}
local t_btl_domain_skill = {
	[714001] = dataList[1],
	[714006] = dataList[2],
	[712002] = dataList[3],
	[71200201] = dataList[4],
	[711006] = dataList[5],
	[71100601] = dataList[6],
	[713003] = dataList[7],
	[71300301] = dataList[8],
	[715015] = dataList[9],
	[71501501] = dataList[10],
	[71400606] = dataList[11],
	[71400101] = dataList[12]
}

t_btl_domain_skill.dataList = dataList

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

return t_btl_domain_skill
