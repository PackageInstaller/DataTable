return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				id = 64070021
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 46,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 30,
				id = 64070031
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 25,
				id = 64070041
			},
			{
				frame = 26,
				id = 64070042
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 22,
				id = 64070051
			},
			{
				frame = 23,
				id = 64070052
			},
			{
				frame = 24,
				id = 64070053
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 94,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				id = 64070061,
				behitted = "hitdown",
				frame = 50
			},
			{
				id = 64070061,
				behitted = "hitdown",
				frame = 57
			},
			{
				id = 64070061,
				behitted = "hitdown",
				frame = 64
			},
			{
				id = 64070061,
				behitted = "hitdown",
				frame = 71
			},
			{
				id = 64070061,
				behitted = "hitdown",
				frame = 78
			},
			{
				frame = 85,
				id = 64070063
			},
			{
				frame = 93,
				id = 64070062
			}
		}
	}
}
