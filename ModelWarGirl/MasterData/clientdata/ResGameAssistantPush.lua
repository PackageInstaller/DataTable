-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResGameAssistantPush.lua

local RT = {}

RT[1] = {
	"kBattleTypeEquipTower",
	"3"
}
RT[2] = {
	"kBattleTypeBossTower",
	"3"
}
RT[3] = {
	"kBattleTypeCampTower",
	"3"
}

local Data = {
	{
		id = 1,
		assist_id = 3,
		condition = 2,
		arg1 = {
			"kBattleTypeStage",
			"3"
		},
		arg2 = {
			"1",
			"1",
			"1",
			"1",
			"25",
			"6"
		},
		push_text = Lang.get(106820)
	},
	{
		id = 2,
		assist_id = 7,
		condition = 2,
		arg1 = RT[1],
		arg2 = {
			"1",
			"1",
			"30"
		},
		push_text = Lang.get(106821)
	},
	{
		id = 3,
		assist_id = 8,
		condition = 2,
		arg1 = RT[1],
		arg2 = {
			"2",
			"1",
			"30"
		},
		push_text = Lang.get(106822)
	},
	{
		id = 4,
		assist_id = 9,
		condition = 2,
		arg1 = RT[1],
		arg2 = {
			"3",
			"1",
			"30"
		},
		push_text = Lang.get(106823)
	},
	{
		id = 5,
		assist_id = 15,
		condition = 2,
		arg1 = RT[2],
		arg2 = {
			"1",
			"1",
			"10"
		},
		push_text = Lang.get(106824)
	},
	{
		id = 6,
		assist_id = 16,
		condition = 2,
		arg1 = RT[2],
		arg2 = {
			"2",
			"1",
			"10"
		},
		push_text = Lang.get(106825)
	},
	{
		id = 7,
		assist_id = 10,
		condition = 2,
		arg1 = {
			"kBattleTypeOnceTower",
			"3"
		},
		arg2 = {
			"1",
			"75"
		},
		push_text = Lang.get(106826)
	},
	{
		id = 8,
		assist_id = 21,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"1",
			"1",
			"3"
		},
		push_text = Lang.get(106827)
	},
	{
		id = 9,
		assist_id = 24,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"2",
			"1",
			"3"
		},
		push_text = Lang.get(106828)
	},
	{
		id = 10,
		assist_id = 27,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"3",
			"1",
			"3"
		},
		push_text = Lang.get(106829)
	},
	{
		id = 11,
		assist_id = 22,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"4",
			"1",
			"3"
		},
		push_text = Lang.get(106830)
	},
	{
		id = 12,
		assist_id = 25,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"5",
			"1",
			"3"
		},
		push_text = Lang.get(106831)
	},
	{
		id = 13,
		assist_id = 28,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"6",
			"1",
			"3"
		},
		push_text = Lang.get(106832)
	},
	{
		id = 14,
		assist_id = 23,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"7",
			"1",
			"3"
		},
		push_text = Lang.get(106833)
	},
	{
		id = 15,
		assist_id = 26,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"8",
			"1",
			"3"
		},
		push_text = Lang.get(106834)
	},
	{
		id = 16,
		assist_id = 29,
		condition = 2,
		arg1 = RT[3],
		arg2 = {
			"9",
			"1",
			"3"
		},
		push_text = Lang.get(106835)
	},
	{
		condition = 4,
		id = 17,
		assist_id = 14,
		arg1 = {
			"kResOpActTypePetGashapon"
		},
		push_text = Lang.get(106836)
	},
	{
		condition = 4,
		id = 18,
		assist_id = 11,
		arg1 = {
			"kResOpActTypeMonopoly"
		},
		push_text = Lang.get(106837)
	},
	{
		condition = 5,
		id = 19,
		assist_id = 20,
		arg1 = {
			"266"
		},
		push_text = Lang.get(106838)
	},
	{
		condition = 5,
		id = 20,
		assist_id = 19,
		arg1 = {
			"311"
		},
		push_text = Lang.get(106839)
	},
	{
		condition = 5,
		id = 21,
		assist_id = 17,
		arg1 = {
			"280"
		},
		push_text = Lang.get(106840)
	},
	{
		condition = 2,
		id = 22,
		assist_id = 2,
		arg1 = {
			"kBattleTypeTower",
			"3"
		},
		push_text = Lang.get(106841)
	}
}

return Data
