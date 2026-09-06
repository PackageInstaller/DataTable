-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_female_psychic_challenge_upgrade_buff.lua

module("logicconfig.config.t_female_psychic_challenge_upgrade_buff", package.seeall)

local title = {
	level = 2,
	desc = 3,
	upgradeBuffPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"全属性+10%"
	},
	{
		1,
		2,
		"全属性+30%"
	},
	{
		1,
		3,
		"全属性+50%"
	},
	{
		1,
		4,
		"全属性+150%"
	},
	{
		1,
		5,
		"全属性+300%"
	},
	{
		1,
		6,
		"全属性+500%"
	},
	{
		1,
		7,
		"全属性+800%"
	},
	{
		1,
		8,
		"全属性+1200%"
	},
	{
		1,
		9,
		"全属性+1500%"
	}
}
local t_female_psychic_challenge_upgrade_buff = {
	{
		dataList[1],
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

t_female_psychic_challenge_upgrade_buff.dataList = dataList

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

return t_female_psychic_challenge_upgrade_buff
