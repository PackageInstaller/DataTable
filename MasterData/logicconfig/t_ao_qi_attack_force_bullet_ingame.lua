-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_bullet_ingame.lua

module("logicconfig.config.t_ao_qi_attack_force_bullet_ingame", package.seeall)

local title = {
	isRotate = 7,
	radius = 2,
	bulletId = 1,
	hitCount = 9,
	maxDistance = 10,
	relativeRotate = 6,
	relativeScale = 5,
	Speed = 8,
	resPath = 3,
	relativePos = 4
}
local dataList = {
	{
		1,
		20,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi01",
		{
			-10,
			0
		},
		0.5,
		0,
		false,
		500,
		1,
		500
	},
	{
		2,
		20,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi02",
		{
			-35,
			0
		},
		0.5,
		-90,
		false,
		500,
		1,
		500
	},
	{
		3,
		10,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi03",
		{
			0,
			0
		},
		0.5,
		-90,
		true,
		500,
		1,
		500
	},
	{
		4,
		50,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi04",
		{
			0,
			0
		},
		0.5,
		0,
		true,
		500,
		999,
		500
	},
	{
		5,
		10,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi14",
		{
			-35,
			0
		},
		0.6,
		0,
		false,
		500,
		1,
		500
	},
	{
		6,
		50,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi06",
		{
			0,
			0
		},
		0.3,
		0,
		true,
		500,
		999,
		900
	},
	{
		7,
		25,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi16",
		{
			-5,
			0
		},
		0.3,
		90,
		false,
		500,
		1,
		500
	},
	{
		8,
		25,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi15",
		{
			-5,
			0
		},
		0.3,
		90,
		false,
		500,
		1,
		500
	},
	{
		9,
		40,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi09",
		{
			0,
			0
		},
		0.5,
		0,
		true,
		500,
		1,
		500
	},
	{
		10,
		25,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi20",
		{
			0,
			0
		},
		0.8,
		0,
		false,
		500,
		1,
		500
	},
	{
		11,
		25,
		"ui/bigbg/aqafweapon/board_bingrenzongshi_wuqi17",
		{
			0,
			0
		},
		0.8,
		0,
		false,
		500,
		1,
		500
	}
}
local t_ao_qi_attack_force_bullet_ingame = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_ao_qi_attack_force_bullet_ingame.dataList = dataList

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

return t_ao_qi_attack_force_bullet_ingame
