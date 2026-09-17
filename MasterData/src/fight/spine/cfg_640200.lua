return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				id = 64020021,
				frame = 10
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
		totalframe = 48,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 26,
				id = 64020031
			},
			{
				frame = 35,
				id = 64020031
			},
			{
				frame = 36,
				id = 64020032
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
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 33,
				id = 64020041
			},
			{
				frame = 41,
				id = 64020041
			},
			{
				frame = 52,
				id = 64020041
			},
			{
				frame = 53,
				id = 64020042
			}
		}
	}
}
