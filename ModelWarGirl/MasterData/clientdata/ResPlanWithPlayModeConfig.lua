-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResPlanWithPlayModeConfig.lua

local RT = {}

RT[1] = {
	"kBattleTypeEquipTower"
}
RT[2] = {
	"kBattleTypeBossTower"
}
RT[3] = {
	"kBattleTypeWorldBoss"
}
RT[4] = {
	"kBattleTypeCampTower"
}
RT[5] = {
	"kBattleTypeOpActTower"
}

local Data = {
	{
		id = 1,
		battle_array_id = {
			0
		},
		battle_type = {
			"kBattleTypeStage",
			"kBattleTypeOnceTower",
			"kBattleTypeAsyncPVP",
			"kBattleTypeRent"
		},
		plan_default_name = Lang.get(50880)
	},
	{
		plan_add_num = 1,
		condition_id = 28,
		id = 2,
		battle_array_id = {
			1
		},
		battle_type = {
			"kBattleTypeMaze"
		},
		plan_default_name = Lang.get(1461)
	},
	{
		plan_add_num = 2,
		condition_id = 27,
		id = 3,
		battle_array_id = {
			2
		},
		battle_type = RT[1],
		plan_default_name = Lang.get(51124)
	},
	{
		plan_add_num = 2,
		condition_id = 27,
		id = 4,
		battle_array_id = {
			3
		},
		battle_type = RT[1],
		plan_default_name = Lang.get(51125)
	},
	{
		plan_add_num = 2,
		condition_id = 27,
		id = 5,
		battle_array_id = {
			4
		},
		battle_type = RT[1],
		plan_default_name = Lang.get(51126)
	},
	{
		plan_add_num = 1,
		condition_id = 23,
		id = 6,
		battle_array_id = {
			5
		},
		battle_type = RT[2],
		plan_default_name = Lang.get(51127)
	},
	{
		plan_add_num = 1,
		condition_id = 23,
		id = 7,
		battle_array_id = {
			6
		},
		battle_type = RT[2],
		plan_default_name = Lang.get(51128)
	},
	{
		plan_add_num = 1,
		condition_id = 24,
		id = 8,
		battle_array_id = {
			7
		},
		battle_type = RT[2],
		plan_default_name = Lang.get(51129)
	},
	{
		condition_id = 72,
		id = 9,
		battle_array_id = {
			11,
			12,
			13
		},
		battle_type = {
			"kBattleTypeMultiPVP"
		},
		plan_default_name = Lang.get(395)
	},
	{
		plan_add_num = 1,
		condition_id = 301,
		id = 10,
		battle_array_id = {
			19,
			20,
			21
		},
		battle_type = {
			"kBattleTypeOpActArena"
		},
		plan_default_name = Lang.get(323)
	},
	{
		condition_id = 73,
		id = 11,
		battle_array_id = {
			14
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(51130)
	},
	{
		condition_id = 73,
		id = 12,
		battle_array_id = {
			45
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(51131)
	},
	{
		condition_id = 73,
		id = 13,
		battle_array_id = {
			46
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(51132)
	},
	{
		condition_id = 73,
		id = 14,
		battle_array_id = {
			47
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(51133)
	},
	{
		condition_id = 73,
		id = 15,
		battle_array_id = {
			48
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(51134)
	},
	{
		condition_id = 73,
		id = 16,
		battle_array_id = {
			49
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(80231)
	},
	{
		condition_id = 73,
		id = 17,
		battle_array_id = {
			50
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(1447)
	},
	{
		condition_id = 73,
		id = 18,
		battle_array_id = {
			51
		},
		battle_type = RT[3],
		plan_default_name = Lang.get(1447)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 19,
		battle_array_id = {
			52
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51158)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 20,
		battle_array_id = {
			53
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51159)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 21,
		battle_array_id = {
			54
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51160)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 22,
		battle_array_id = {
			55
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51161)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 23,
		battle_array_id = {
			56
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51162)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 24,
		battle_array_id = {
			57
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51163)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 25,
		battle_array_id = {
			58
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51164)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 26,
		battle_array_id = {
			59
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51165)
	},
	{
		plan_add_num = 2,
		condition_id = 188,
		id = 27,
		battle_array_id = {
			60
		},
		battle_type = RT[4],
		plan_default_name = Lang.get(51166)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 28,
		battle_array_id = {
			22
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51145)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 29,
		battle_array_id = {
			23
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51146)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 30,
		battle_array_id = {
			24
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51147)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 31,
		battle_array_id = {
			25
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51148)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 32,
		battle_array_id = {
			26
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51149)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 33,
		battle_array_id = {
			27
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51150)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 34,
		battle_array_id = {
			28
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51151)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 35,
		battle_array_id = {
			29
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51152)
	},
	{
		plan_add_num = 1,
		condition_id = 305,
		id = 36,
		battle_array_id = {
			30
		},
		battle_type = RT[5],
		plan_default_name = Lang.get(51153)
	}
}

return Data
