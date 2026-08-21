-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/util/CustomTemplate.lua

module("logic.extensions.hacktool.util.CustomTemplate", package.seeall)

local title = {
	equipmentLv = 6,
	echoLv = 4,
	wakeup = 3,
	breakLv = 2,
	equipmentQua = 5,
	powerNodeId = 1
}
local templateB = {
	[10] = {
		0,
		3,
		false,
		0,
		0,
		0
	},
	[15] = {
		3,
		3,
		false,
		0,
		0,
		0
	},
	[20] = {
		5,
		3,
		false,
		0,
		1,
		1
	},
	[25] = {
		8,
		3,
		false,
		0,
		1,
		5
	},
	[30] = {
		10,
		4,
		false,
		0,
		2,
		5
	},
	[35] = {
		11,
		4,
		false,
		1,
		2,
		6
	},
	[40] = {
		12,
		4,
		false,
		1,
		2,
		7
	},
	[45] = {
		13,
		4,
		false,
		2,
		2,
		8
	},
	[50] = {
		15,
		5,
		true,
		2,
		2,
		10
	},
	[55] = {
		16,
		5,
		true,
		2,
		3,
		10
	},
	[60] = {
		16,
		5,
		true,
		2,
		3,
		13
	},
	[65] = {
		18,
		5,
		true,
		2,
		3,
		20
	},
	[70] = {
		20,
		5,
		true,
		2,
		4,
		22
	},
	[75] = {
		20,
		5,
		true,
		2,
		4,
		24
	},
	[80] = {
		20,
		5,
		true,
		3,
		4,
		26
	},
	[85] = {
		20,
		5,
		true,
		3,
		4,
		28
	},
	[90] = {
		20,
		5,
		true,
		3,
		4,
		30
	},
	[100] = {
		20,
		5,
		true,
		5,
		4,
		30
	}
}
local templateA = {
	[10] = {
		0,
		0,
		false,
		0,
		0,
		0
	},
	[15] = {
		3,
		0,
		false,
		0,
		0,
		0
	},
	[20] = {
		5,
		0,
		false,
		0,
		1,
		1
	},
	[25] = {
		8,
		0,
		false,
		0,
		1,
		5
	},
	[30] = {
		10,
		0,
		false,
		0,
		2,
		5
	},
	[35] = {
		11,
		1,
		false,
		1,
		2,
		6
	},
	[40] = {
		12,
		1,
		false,
		1,
		2,
		7
	},
	[45] = {
		13,
		1,
		false,
		2,
		2,
		8
	},
	[50] = {
		15,
		1,
		true,
		2,
		2,
		10
	},
	[55] = {
		16,
		2,
		true,
		2,
		3,
		10
	},
	[60] = {
		16,
		2,
		true,
		2,
		3,
		13
	},
	[65] = {
		18,
		3,
		true,
		3,
		3,
		20
	},
	[70] = {
		20,
		3,
		true,
		4,
		4,
		22
	},
	[75] = {
		21,
		3,
		true,
		4,
		4,
		24
	},
	[80] = {
		23,
		4,
		true,
		4,
		4,
		26
	},
	[85] = {
		23,
		4,
		true,
		5,
		4,
		28
	},
	[90] = {
		25,
		5,
		true,
		5,
		4,
		30
	},
	[100] = {
		25,
		5,
		true,
		5,
		4,
		30
	}
}
local templateS = {
	[10] = {
		0,
		0,
		false,
		0,
		0,
		0
	},
	[15] = {
		3,
		0,
		false,
		0,
		0,
		0
	},
	[20] = {
		5,
		0,
		false,
		0,
		1,
		1
	},
	[25] = {
		8,
		0,
		false,
		0,
		1,
		5
	},
	[30] = {
		10,
		0,
		false,
		0,
		2,
		5
	},
	[35] = {
		11,
		0,
		false,
		1,
		2,
		6
	},
	[40] = {
		12,
		0,
		false,
		1,
		2,
		7
	},
	[45] = {
		13,
		0,
		false,
		2,
		2,
		8
	},
	[50] = {
		15,
		0,
		true,
		2,
		2,
		10
	},
	[55] = {
		16,
		0,
		true,
		2,
		3,
		10
	},
	[60] = {
		16,
		0,
		true,
		2,
		3,
		13
	},
	[65] = {
		18,
		0,
		true,
		3,
		3,
		20
	},
	[70] = {
		20,
		0,
		true,
		4,
		4,
		22
	},
	[75] = {
		21,
		0,
		true,
		4,
		4,
		24
	},
	[80] = {
		23,
		0,
		true,
		4,
		4,
		26
	},
	[85] = {
		23,
		0,
		true,
		5,
		4,
		28
	},
	[90] = {
		25,
		0,
		true,
		5,
		4,
		30
	},
	[100] = {
		25,
		5,
		true,
		5,
		4,
		30
	}
}
local templateHero = {
	templateS,
	templateA,
	templateB
}
local heroEquip = {
	[2000005] = {
		1344005,
		1003
	},
	[2000012] = {
		1345003,
		1007
	},
	[2000019] = {
		1335001,
		1010
	},
	[2000039] = {
		1315003,
		1004
	},
	[2000008] = {
		1314002,
		1002
	},
	[2000055] = {
		1345003,
		1001
	},
	[2000041] = {
		1325005,
		1008
	},
	[2000011] = {
		1315003,
		1002
	},
	[2000013] = {
		1345003,
		1001
	},
	[2000007] = {
		1365003,
		1003
	},
	[2000028] = {
		1314002,
		1010
	},
	[2000031] = {
		1314002,
		1010
	},
	[2000020] = {
		1324002,
		1004
	},
	[2000021] = {
		1354001,
		1010
	},
	[2000022] = {
		1334002,
		1005
	},
	[2000036] = {
		1354001,
		1007
	},
	[2000056] = {
		1365003,
		1003
	},
	[2000016] = {
		1315003,
		1002
	},
	[2000030] = {
		1335001,
		1010
	},
	[2000043] = {
		1344005,
		1003
	},
	[2000047] = {
		1314002,
		1010
	},
	[2000053] = {
		1344005,
		1003
	},
	[2000025] = {
		1303005,
		1006
	},
	[2000010] = {
		1344002,
		1003
	},
	[2000015] = {
		1354002,
		1002
	},
	[2000029] = {
		1354002,
		1010
	},
	[2000046] = {
		1314002,
		1002
	},
	[2000051] = {
		1354001,
		1010
	},
	[2000057] = {
		1345003,
		1001
	}
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

function getLvTemplateByQua(quality, level)
	local template = templateHero[quality][level]

	setmetatable(template, mt)

	return template
end

function getHeroEquipTemplate(heroId)
	local template = heroEquip[heroId]

	if not template then
		return false
	end

	local cfg = {
		echoId = template[1],
		suitId = template[2]
	}

	return cfg
end

function getTemplate(quality)
	return templateHero[quality]
end
