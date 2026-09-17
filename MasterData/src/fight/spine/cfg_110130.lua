local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				bullet = "attack"
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 11013031,
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 11013051,
				frame = 18
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
		totalframe = 2,
		turnbacklimit = true,
		animation = "attack",
		exe_tbl = {
			{
				id = 11013011,
				frame = 1
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "110130_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = -0.2,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 11013021,
				frame = 2
			}
		}
	}
}

return var_0_0
