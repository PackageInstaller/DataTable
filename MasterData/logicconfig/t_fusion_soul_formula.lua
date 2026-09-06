-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_formula.lua

module("logicconfig.config.t_fusion_soul_formula", package.seeall)

local title = {
	activityId = 1,
	clueId = 2
}
local dataList = {
	{
		498001,
		8
	},
	{
		498001,
		9
	},
	{
		498001,
		10
	},
	{
		498001,
		18
	},
	{
		498001,
		19
	},
	{
		498001,
		28
	},
	{
		498001,
		29
	},
	{
		498001,
		30
	},
	{
		498001,
		31
	},
	{
		498001,
		32
	}
}
local t_fusion_soul_formula = {
	[498001] = {
		[8] = dataList[1],
		[9] = dataList[2],
		[10] = dataList[3],
		[18] = dataList[4],
		[19] = dataList[5],
		[28] = dataList[6],
		[29] = dataList[7],
		[30] = dataList[8],
		[31] = dataList[9],
		[32] = dataList[10]
	}
}

t_fusion_soul_formula.dataList = dataList

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

return t_fusion_soul_formula
