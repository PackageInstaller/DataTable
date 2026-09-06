-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_challenge_support.lua

module("logicconfig.config.t_legend_challenge_support", package.seeall)

local title = {
	awakenLv = 6,
	talentLv = 5,
	creepsId = 1,
	onlyUseExtProperties = 10,
	faceId = 14,
	summonedPetId = 12,
	posId = 7,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 3,
	maxHp = 13,
	extproperties = 9,
	raceId = 2,
	lv = 4
}
local dataList = {
	{
		1000000201,
		10082,
		"烈阳·龙君焰",
		10,
		0,
		0,
		5,
		"",
		"生命+523#攻击+400#物防+22#魔防+20#速度+41",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000202,
		10082,
		"烈阳·龙君焰",
		20,
		0,
		0,
		5,
		"",
		"生命+1046#攻击+800#物防+45#魔防+41#速度+83",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000901,
		10083,
		"无畏·苍零式",
		30,
		0,
		0,
		5,
		"",
		"生命+4673#攻击+3577#物防+186#魔防+202#速度+373",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000902,
		10083,
		"无畏·苍零式",
		40,
		0,
		0,
		5,
		"",
		"生命+9347#攻击+7154#物防+373#魔防+405#速度+747",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000903,
		10083,
		"无畏·苍零式",
		45,
		0,
		0,
		5,
		"",
		"生命+14021#攻击+10731#物防+560#魔防+607#速度+1121",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000904,
		10083,
		"无畏·苍零式",
		50,
		0,
		0,
		5,
		"",
		"生命+18695#攻击+14308#物防+747#魔防+810#速度+1495",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000000905,
		10083,
		"无畏·苍零式",
		50,
		0,
		0,
		5,
		"",
		"生命+23369#攻击+17885#物防+934#魔防+1012#速度+1869",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000001101,
		10084,
		"寒战·空无流",
		50,
		0,
		0,
		5,
		"",
		"生命+9053#攻击+6613#物防+382#魔防+367#速度+764",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000001102,
		10084,
		"寒战·空无流",
		50,
		0,
		0,
		5,
		"",
		"生命+18107#攻击+13227#物防+764#魔防+734#速度+1528",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000001103,
		10084,
		"寒战·空无流",
		50,
		0,
		0,
		5,
		"",
		"生命+27160#攻击+19841#物防+1146#魔防+1102#速度+2292",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000001104,
		10084,
		"寒战·空无流",
		50,
		0,
		0,
		5,
		"",
		"生命+36214#攻击+26455#物防+1528#魔防+1469#速度+3057",
		true,
		"",
		"",
		"",
		""
	},
	{
		1000001105,
		10084,
		"寒战·空无流",
		50,
		0,
		0,
		5,
		"",
		"生命+45268#攻击+33069#物防+1910#魔防+1837#速度+3821",
		true,
		"",
		"",
		"",
		""
	}
}
local t_legend_challenge_support = {
	[1000000201] = dataList[1],
	[1000000202] = dataList[2],
	[1000000901] = dataList[3],
	[1000000902] = dataList[4],
	[1000000903] = dataList[5],
	[1000000904] = dataList[6],
	[1000000905] = dataList[7],
	[1000001101] = dataList[8],
	[1000001102] = dataList[9],
	[1000001103] = dataList[10],
	[1000001104] = dataList[11],
	[1000001105] = dataList[12]
}

t_legend_challenge_support.dataList = dataList

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

return t_legend_challenge_support
