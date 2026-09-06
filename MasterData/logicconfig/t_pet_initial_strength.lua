-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_initial_strength.lua

module("logicconfig.config.t_pet_initial_strength", package.seeall)

local title = {
	raceId = 1,
	starGodDefineIds = 2
}
local dataList = {
	{
		11000,
		{
			503,
			504,
			506,
			509
		}
	},
	{
		14003,
		{
			503,
			504,
			506,
			507
		}
	}
}
local t_pet_initial_strength = {
	[11000] = dataList[1],
	[14003] = dataList[2]
}

t_pet_initial_strength.dataList = dataList

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

return t_pet_initial_strength
