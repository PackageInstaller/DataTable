-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_material_recover_common.lua

module("logicconfig.config.t_material_recover_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FREE_RECOVER_PERCENT",
		"50"
	},
	{
		"PERFECT_RECOVER_PERCENT",
		"100"
	},
	{
		"MAX_KEEP_DAYS",
		"6"
	},
	{
		"GOODS_ID",
		"169"
	}
}
local t_material_recover_common = {
	FREE_RECOVER_PERCENT = dataList[1],
	PERFECT_RECOVER_PERCENT = dataList[2],
	MAX_KEEP_DAYS = dataList[3],
	GOODS_ID = dataList[4]
}

t_material_recover_common.dataList = dataList

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

return t_material_recover_common
