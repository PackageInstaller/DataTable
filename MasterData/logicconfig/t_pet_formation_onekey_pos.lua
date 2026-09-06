-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_formation_onekey_pos.lua

module("logicconfig.config.t_pet_formation_onekey_pos", package.seeall)

local title = {
	p9 = 10,
	p6 = 7,
	p3 = 4,
	p2 = 3,
	p8 = 9,
	p5 = 6,
	id = 1,
	p4 = 5,
	p1 = 2,
	p7 = 8
}
local dataList = {
	{
		"前排",
		102,
		103,
		101,
		86,
		87,
		85,
		0,
		0,
		0
	},
	{
		"后排",
		0,
		0,
		0,
		91,
		90,
		89,
		88,
		87,
		86
	}
}
local t_pet_formation_onekey_pos = {
	前排 = dataList[1],
	后排 = dataList[2]
}

t_pet_formation_onekey_pos.dataList = dataList

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

return t_pet_formation_onekey_pos
