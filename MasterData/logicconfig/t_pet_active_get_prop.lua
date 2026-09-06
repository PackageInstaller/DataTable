-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_active_get_prop.lua

module("logicconfig.config.t_pet_active_get_prop", package.seeall)

local title = {
	propId = 2,
	exchangeTimesLimit = 5,
	exchangeCost = 4,
	prop = 3,
	exchangePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"100:11033:1:1",
		"4:389:6000",
		1
	},
	{
		1,
		2,
		"4:84532:1",
		"4:389:2000",
		6
	},
	{
		1,
		3,
		"4:90111:1",
		"4:389:2000",
		1
	}
}
local t_pet_active_get_prop = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_pet_active_get_prop.dataList = dataList

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

return t_pet_active_get_prop
