-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_growth_sham_pet.lua

module("logicconfig.config.t_pet_growth_sham_pet", package.seeall)

local title = {
	id = 1,
	power = 2
}
local dataList = {
	{
		11000,
		{
			231,
			8940,
			19715,
			30310,
			36647,
			42402
		}
	}
}
local t_pet_growth_sham_pet = {
	[11000] = dataList[1]
}

t_pet_growth_sham_pet.dataList = dataList

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

return t_pet_growth_sham_pet
