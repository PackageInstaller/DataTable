-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_combination_skill_formula.lua

module("logicconfig.config.t_btl_combination_skill_formula", package.seeall)

local title = {
	formulaId = 2,
	priority = 3,
	disintegrationSkillId = 6,
	skillId = 1,
	raceIdLimit = 4,
	effectPath = 7,
	targetRaceId = 5
}
local dataList = {
	{
		610338,
		1,
		10,
		"10338#5",
		50338,
		710338,
		"common/buff/fx_buff_duolaheti"
	},
	{
		610339,
		1,
		10,
		"10339#5",
		50339,
		710339,
		"common/buff/fx_buff_anheiheti"
	},
	{
		610341,
		1,
		10,
		"10341#5",
		50341,
		710341,
		"common/buff/fx_buff_rexueheti"
	},
	{
		610342,
		1,
		10,
		"10342#5",
		50342,
		710342,
		"common/buff/fx_buff_lianjinheti"
	},
	{
		610343,
		1,
		10,
		"10343#5",
		50343,
		710343,
		"common/buff/fx_buff_aixinheti"
	}
}
local t_btl_combination_skill_formula = {
	[610338] = {
		dataList[1]
	},
	[610339] = {
		dataList[2]
	},
	[610341] = {
		dataList[3]
	},
	[610342] = {
		dataList[4]
	},
	[610343] = {
		dataList[5]
	}
}

t_btl_combination_skill_formula.dataList = dataList

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

return t_btl_combination_skill_formula
