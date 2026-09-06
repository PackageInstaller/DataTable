-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_creeps.lua

module("logicconfig.config.t_seek_food_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	talentLv = 7,
	extproperties = 10,
	creepsMasterId = 1,
	lv = 6
}
local dataList = {
	{
		101,
		1,
		90329,
		"裁决圣者·谜",
		5,
		100,
		0,
		0,
		"",
		"生命+1476923#攻击+98399#物防+15000#魔防+13846#速度+66461",
		true,
		"",
		"",
		""
	},
	{
		102,
		1,
		90326,
		"焚世·赤焰龙皇",
		5,
		100,
		0,
		0,
		"",
		"生命+1969230#攻击+131200#物防+18461#魔防+20000#速度+88615",
		true,
		"",
		"",
		""
	},
	{
		103,
		1,
		90331,
		"疾风匕隐·卡索",
		5,
		100,
		0,
		0,
		"",
		"生命+1772307#攻击+81600#物防+15000#魔防+15000#速度+77538",
		true,
		"",
		"",
		""
	},
	{
		104,
		1,
		90332,
		"石姬新娘·镭拉",
		5,
		100,
		0,
		0,
		"",
		"生命+4332307#攻击+76800#物防+40000#魔防+40000#速度+59076",
		true,
		"",
		"",
		""
	},
	{
		105,
		1,
		90333,
		"千钧万盾·尤烈",
		5,
		100,
		0,
		0,
		"",
		"生命+3249230#攻击+57600#物防+30000#魔防+30000#速度+44307",
		true,
		"",
		"",
		""
	},
	{
		106,
		1,
		90334,
		"无间魔焰·瞳",
		5,
		100,
		0,
		0,
		"",
		"生命+1969230#攻击+131200#物防+18461#魔防+20000#速度+88615",
		true,
		"",
		"",
		""
	},
	{
		107,
		1,
		90345,
		"龙女·耶梦加得",
		5,
		100,
		0,
		0,
		"",
		"生命+1772307#攻击+81600#物防+15000#魔防+15000#速度+77538",
		true,
		"",
		"",
		""
	},
	{
		108,
		1,
		90352,
		"天女武神·狄丝",
		5,
		100,
		0,
		0,
		"",
		"生命+1969230#攻击+131200#物防+20000#魔防+18461#速度+88615",
		true,
		"",
		"",
		""
	}
}
local t_seek_food_creeps = {
	[101] = {
		dataList[1]
	},
	[102] = {
		dataList[2]
	},
	[103] = {
		dataList[3]
	},
	[104] = {
		dataList[4]
	},
	[105] = {
		dataList[5]
	},
	[106] = {
		dataList[6]
	},
	[107] = {
		dataList[7]
	},
	[108] = {
		dataList[8]
	}
}

t_seek_food_creeps.dataList = dataList

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

return t_seek_food_creeps
