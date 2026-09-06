-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_title_common_client.lua

module("logicconfig.config.t_pet_title_common_client", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PET_TITLE_DESC",
		"<size=30>奥奇称号</size>   是精灵的荣耀!"
	},
	{
		"GET_PET_TITLE",
		"精灵称号代表着一只精灵的荣耀，每个精灵称号都属于努力、奋斗的小奥奇才能获取，来之不易！"
	}
}
local t_pet_title_common_client = {
	PET_TITLE_DESC = dataList[1],
	GET_PET_TITLE = dataList[2]
}

t_pet_title_common_client.dataList = dataList

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

return t_pet_title_common_client
