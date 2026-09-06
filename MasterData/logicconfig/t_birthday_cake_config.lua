-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_cake_config.lua

module("logicconfig.config.t_birthday_cake_config", package.seeall)

local title = {
	reward = 5,
	cakePlan = 1,
	consume = 3,
	contribute = 4,
	cakeId = 2
}
local dataList = {
	{
		1,
		1,
		"10:224001:1",
		10,
		"8:1:5000"
	},
	{
		1,
		2,
		"10:224002:1",
		10,
		"8:1:5000"
	},
	{
		1,
		3,
		"10:224003:1",
		10,
		"8:1:5000"
	},
	{
		2,
		1,
		"10:224004:1",
		10,
		"8:1:5000"
	},
	{
		2,
		2,
		"10:224005:1",
		10,
		"8:1:5000"
	},
	{
		2,
		3,
		"10:224006:1",
		10,
		"8:1:5000"
	}
}
local t_birthday_cake_config = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_birthday_cake_config.dataList = dataList

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

return t_birthday_cake_config
