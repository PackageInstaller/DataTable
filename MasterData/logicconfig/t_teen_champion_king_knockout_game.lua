-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_knockout_game.lua

module("logicconfig.config.t_teen_champion_king_knockout_game", package.seeall)

local title = {
	petNum = 4,
	canChangePos = 6,
	summonPet = 5,
	roundTime = 3,
	gameRoundId = 2,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		501001,
		1,
		60,
		1,
		true,
		false,
		"第一轮：请上1只召唤师及其契约兽，超时将自动确认（不自动上阵精灵）"
	},
	{
		501001,
		2,
		60,
		2,
		false,
		false,
		"第二轮：请上2只精灵，不可更改契约兽，超时将自动确认（不自动上阵精灵）"
	},
	{
		501001,
		3,
		60,
		2,
		false,
		false,
		"第三轮：请上2只精灵，不可更改契约兽，超时将自动确认（不自动上阵精灵）"
	},
	{
		501001,
		4,
		30,
		0,
		false,
		true,
		"第四轮：本轮可调整宠物、通灵技、元素技能，超时将自动确认"
	}
}
local t_teen_champion_king_knockout_game = {
	[501001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_teen_champion_king_knockout_game.dataList = dataList

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

return t_teen_champion_king_knockout_game
