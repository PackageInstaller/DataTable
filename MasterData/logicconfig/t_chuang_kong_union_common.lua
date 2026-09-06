-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_kong_union_common.lua

module("logicconfig.config.t_chuang_kong_union_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ENTRANCE_PET_IDS",
		"16000#16002"
	},
	{
		"ENTRANCE_RED_POINT_IDS",
		"-172#-173#-174"
	},
	{
		"GOODS_ID",
		"11117"
	},
	{
		"GOODS_NAME",
		"特惠星神"
	}
}
local t_chuang_kong_union_common = {
	ENTRANCE_PET_IDS = dataList[1],
	ENTRANCE_RED_POINT_IDS = dataList[2],
	GOODS_ID = dataList[3],
	GOODS_NAME = dataList[4]
}

t_chuang_kong_union_common.dataList = dataList

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

return t_chuang_kong_union_common
