-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mizong_clg_star_prize.lua

module("logicconfig.config.t_divine_mizong_clg_star_prize", package.seeall)

local title = {
	firstPassPrize = 3,
	gainStarDecs = 6,
	starPrizePlan = 1,
	upgradeBuffItemCount = 4,
	specialPetHpRate = 5,
	star = 2
}
local dataList = {
	{
		1,
		1,
		"104:2:50",
		2,
		"大于&0",
		"破阵时，承受位精灵存活"
	},
	{
		1,
		2,
		"104:2:50",
		3,
		"大于等于&0.5",
		"破阵时，承受位精灵血量>=50%"
	},
	{
		1,
		3,
		"104:2:50",
		5,
		"大于等于&0.9",
		"破阵时，承受位精灵血量>=90%"
	}
}
local t_divine_mizong_clg_star_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_mizong_clg_star_prize.dataList = dataList

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

return t_divine_mizong_clg_star_prize
