-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_comment_common_config.lua

module("logicconfig.config.t_pet_comment_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PET_LEVEL_LIMIT",
		"50"
	},
	{
		"WORLD_NUMBER",
		"50"
	},
	{
		"UPDATA_COOL_TIME",
		"60"
	},
	{
		"COMMENT_DES",
		"精灵等级达到%s级后才能评论，评论限制%s字"
	},
	{
		"REPORT_TEXT_COUNT",
		"200"
	}
}
local t_pet_comment_common_config = {
	PET_LEVEL_LIMIT = dataList[1],
	WORLD_NUMBER = dataList[2],
	UPDATA_COOL_TIME = dataList[3],
	COMMENT_DES = dataList[4],
	REPORT_TEXT_COUNT = dataList[5]
}

t_pet_comment_common_config.dataList = dataList

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

return t_pet_comment_common_config
