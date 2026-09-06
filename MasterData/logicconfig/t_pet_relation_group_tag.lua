-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_relation_group_tag.lua

module("logicconfig.config.t_pet_relation_group_tag", package.seeall)

local title = {
	url = 3,
	name = 2,
	show = 4,
	tagName = 1
}
local dataList = {
	{
		"tag_1",
		"旧神",
		"",
		1
	}
}
local t_pet_relation_group_tag = {
	tag_1 = dataList[1]
}

t_pet_relation_group_tag.dataList = dataList

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

return t_pet_relation_group_tag
