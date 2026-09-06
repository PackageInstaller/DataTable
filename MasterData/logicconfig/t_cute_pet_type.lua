-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_type.lua

module("logicconfig.config.t_cute_pet_type", package.seeall)

local title = {
	name = 2,
	type = 1
}
local dataList = {
	{
		1,
		"爆裂宠"
	},
	{
		2,
		"制衡宠"
	},
	{
		3,
		"铁甲宠"
	},
	{
		4,
		"乖乖宠"
	}
}
local t_cute_pet_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_cute_pet_type.dataList = dataList

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

return t_cute_pet_type
