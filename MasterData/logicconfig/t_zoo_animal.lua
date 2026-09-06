-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal.lua

module("logicconfig.config.t_zoo_animal", package.seeall)

local title = {
	eggShow = 7,
	name = 2,
	hatchCD = 3,
	raceId = 1,
	onlineDate = 12,
	canRecycle = 11,
	adultShow = 9,
	offlineDate = 13,
	skeletonId = 14,
	eggName = 4,
	groupShow = 8,
	eggIcon = 6,
	eggDesc = 5,
	hatchProgress = 10
}
local dataList = {
	{
		1,
		"小诺",
		3600,
		"小诺蛋",
		"这是一个新手村送你的蛋",
		"btn_cwcy_02",
		"btn_cwcy_02",
		"btn_cwcy_02",
		"btn_cwcy_02",
		{
			100,
			200
		},
		true,
		nil,
		nil,
		101
	},
	{
		2,
		"小炎",
		3600,
		"小炎蛋",
		"这是一个新手村送你的蛋",
		"btn_cwcy_02",
		"btn_cwcy_02",
		"btn_cwcy_02",
		"btn_cwcy_02",
		{
			100,
			200
		},
		true,
		nil,
		nil,
		102
	}
}
local t_zoo_animal = {
	dataList[1],
	dataList[2]
}

t_zoo_animal.dataList = dataList

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

return t_zoo_animal
