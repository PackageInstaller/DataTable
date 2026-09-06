-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_champion_guess.lua

module("logicconfig.config.t_teen_champion_king_champion_guess", package.seeall)

local title = {
	returnWanPercent = 3,
	rightGuessCount = 2,
	activityId = 1
}
local dataList = {
	{
		501001,
		0,
		10000
	},
	{
		501001,
		1,
		15000
	},
	{
		501001,
		2,
		20000
	},
	{
		501001,
		3,
		25000
	},
	{
		501001,
		4,
		30000
	},
	{
		501001,
		5,
		35000
	},
	{
		501001,
		6,
		40000
	},
	{
		501001,
		7,
		45000
	},
	{
		501001,
		8,
		50000
	}
}
local t_teen_champion_king_champion_guess = {
	[501001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_teen_champion_king_champion_guess.dataList = dataList

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

return t_teen_champion_king_champion_guess
