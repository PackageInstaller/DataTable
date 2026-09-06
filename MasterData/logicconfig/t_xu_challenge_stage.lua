-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xu_challenge_stage.lua

module("logicconfig.config.t_xu_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	petValidator = 4,
	canSacrificeStageNum = 5,
	validatorDesc = 6,
	creepsMasterId = 3,
	prize = 7,
	activityId = 1
}
local dataList = {
	{
		613001,
		1,
		1002,
		"RaceType$水|RaceType$草|RaceType$火",
		2,
		"需上水或草或火属性精灵",
		""
	},
	{
		613001,
		2,
		1001,
		"RaceType$光|RaceType$暗",
		2,
		"需上光或暗属性精灵",
		""
	},
	{
		613001,
		3,
		1003,
		"RaceType$空|RaceType$创",
		2,
		"需上空或创属性精灵",
		"4:510842:20"
	},
	{
		613001,
		4,
		1004,
		"Job$肉盾|Job$平衡",
		2,
		"需上肉盾或平衡精灵",
		""
	},
	{
		613001,
		5,
		1005,
		"Job$魔法|Job$利爪",
		2,
		"需上魔法或利爪精灵",
		""
	},
	{
		613001,
		6,
		1006,
		"Job$疾速|Job$治疗",
		2,
		"需上疾速或治疗精灵",
		"4:510842:40"
	},
	{
		613001,
		7,
		1007,
		"Signs$龙|Gender$1",
		2,
		"需上龙族或女性精灵",
		"4:510842:60"
	}
}
local t_xu_challenge_stage = {
	[613001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_xu_challenge_stage.dataList = dataList

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

return t_xu_challenge_stage
