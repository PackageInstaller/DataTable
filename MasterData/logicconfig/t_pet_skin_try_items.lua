-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_skin_try_items.lua

module("logicconfig.config.t_pet_skin_try_items", package.seeall)

local title = {
	items = 2,
	skinId = 1
}
local dataList = {
	{
		1031301,
		"4:10000031#4:10000032"
	},
	{
		1100201,
		"4:10000033#4:10000034"
	}
}
local t_pet_skin_try_items = {
	[1031301] = dataList[1],
	[1100201] = dataList[2]
}

t_pet_skin_try_items.dataList = dataList

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

return t_pet_skin_try_items
