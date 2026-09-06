-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_clue_formula.lua

module("logicconfig.config.t_annual_fuben_clue_formula", package.seeall)

local title = {
	activityId = 1,
	clueId = 2
}
local dataList = {
	{
		546001,
		10
	},
	{
		546001,
		11
	},
	{
		546001,
		12
	}
}
local t_annual_fuben_clue_formula = {
	[546001] = {
		[10] = dataList[1],
		[11] = dataList[2],
		[12] = dataList[3]
	}
}

t_annual_fuben_clue_formula.dataList = dataList

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

return t_annual_fuben_clue_formula
