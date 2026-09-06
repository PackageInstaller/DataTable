-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ai_xin_mm_common.lua

module("logicconfig.config.t_ai_xin_mm_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"7"
	},
	{
		"PRIZE",
		"4:6001:1"
	},
	{
		"EVOLVE_PET_RACE_ID",
		"10344"
	},
	{
		"MAINVIEW_ROLEMODEL_CFG",
		"153,-19,0.5"
	},
	{
		"GOODS_ID",
		"531"
	}
}
local t_ai_xin_mm_common = {
	CHALLENGE_ID = dataList[1],
	PRIZE = dataList[2],
	EVOLVE_PET_RACE_ID = dataList[3],
	MAINVIEW_ROLEMODEL_CFG = dataList[4],
	GOODS_ID = dataList[5]
}

t_ai_xin_mm_common.dataList = dataList

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

return t_ai_xin_mm_common
