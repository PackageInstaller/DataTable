-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_badge_suit.lua

module("logicconfig.config.t_season_mode_pve_badge_suit", package.seeall)

local title = {
	propertyParam = 3,
	buffs = 4,
	suitDesc = 5,
	numZdl = 6,
	num = 2,
	suitType = 1,
	provideZdlWanPercent = 7
}
local dataList = {
	{
		5001,
		3,
		"生命+122353#攻击+23090#物防+8282#魔防+9035#速度+2949",
		"",
		"提高队伍全属性",
		0,
		0
	},
	{
		5001,
		6,
		"生命+244706#攻击+46180#物防+16565#魔防+18071#速度+5898",
		"",
		"大幅提高队伍全属性",
		0,
		0
	},
	{
		5001,
		10,
		"生命+407843#攻击+76967#物防+27608#魔防+30118#速度+9830",
		"",
		"显著提高队伍全属性并使队伍消耗体力减少20%",
		0,
		0
	},
	{
		5002,
		3,
		"生命+122353#攻击+23090#物防+8282#魔防+9035#速度+2949",
		"",
		"提高队伍全属性",
		0,
		0
	},
	{
		5002,
		6,
		"生命+244706#攻击+46180#物防+16565#魔防+18071#速度+5898",
		"",
		"大幅提高队伍全属性",
		0,
		0
	},
	{
		5002,
		10,
		"生命+407843#攻击+76967#物防+27608#魔防+30118#速度+9830",
		"",
		"显著提高队伍全属性并使队伍消耗体力减少20%",
		0,
		0
	},
	{
		5003,
		3,
		"生命+122353#攻击+23090#物防+8282#魔防+9035#速度+2949",
		"",
		"提高队伍全属性",
		0,
		0
	},
	{
		5003,
		6,
		"生命+244706#攻击+46180#物防+16565#魔防+18071#速度+5898",
		"",
		"大幅提高队伍全属性",
		0,
		0
	},
	{
		5003,
		10,
		"生命+407843#攻击+76967#物防+27608#魔防+30118#速度+9830",
		"",
		"显著提高队伍全属性并使队伍消耗体力减少20%",
		0,
		0
	}
}
local t_season_mode_pve_badge_suit = {
	[5001] = {
		[3] = dataList[1],
		[6] = dataList[2],
		[10] = dataList[3]
	},
	[5002] = {
		[3] = dataList[4],
		[6] = dataList[5],
		[10] = dataList[6]
	},
	[5003] = {
		[3] = dataList[7],
		[6] = dataList[8],
		[10] = dataList[9]
	}
}

t_season_mode_pve_badge_suit.dataList = dataList

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

return t_season_mode_pve_badge_suit
