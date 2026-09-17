return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				id = 61020021
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 16,
				id = 61020031
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
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 32,
				id = 61020041
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
		totalframe = 47,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				id = 61020051,
				frame = 19,
				effect = {
					{
						ani = "skill3_run",
						name = "610100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "self"
					}
				}
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
		totalframe = 65,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "100481_xp"
			},
			{
				frame = 27,
				id = 61020061
			},
			{
				frame = 28,
				id = 61020061
			},
			{
				frame = 29,
				id = 61020061
			},
			{
				frame = 65,
				id = 61020062
			}
		}
	}
}
