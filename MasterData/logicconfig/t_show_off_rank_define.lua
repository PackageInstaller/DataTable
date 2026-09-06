-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_off_rank_define.lua

module("logicconfig.config.t_show_off_rank_define", package.seeall)

local title = {
	rankId = 1,
	memberSupplier = 6,
	rankType = 2,
	topLimit = 5,
	memberSupplierParam = 7,
	tableName = 4,
	desc = 3
}
local dataList = {
	{
		1,
		"PET_SKIN_OVER_ALL",
		"皮肤数量总榜",
		"pet_skin_over_all_rank",
		10000,
		"",
		""
	},
	{
		2,
		"PET_SKIN_POSTER",
		"皮肤海报数量榜",
		"pet_skin_poster_rank",
		10000,
		"",
		""
	},
	{
		3,
		"PET_SKIN_QUALITY",
		"皮肤品质数量榜",
		"pet_skin_quality_rank",
		10000,
		"PET_SKIN_QUALITY",
		""
	}
}
local t_show_off_rank_define = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_show_off_rank_define.dataList = dataList

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

return t_show_off_rank_define
