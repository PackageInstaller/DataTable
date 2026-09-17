local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10088121,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "100881_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.8,
						object = "target"
					}
				}
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 10088131,
				frame = 26,
				effect = {
					{
						ani = "skill",
						name = "100881_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 10088132,
				frame = 27,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 200,
						object = "target"
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
		totalframe = 60,
		animation = "xp",
		exe_tbl = {
			{
				frame = 25,
				bullet = "xp"
			},
			{
				frame = 35,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100881_effect",
	initpos = {
		offsetY = 1.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "xp",
		exe_tbl = {
			{
				id = 10088161,
				frame = 2
			}
		}
	}
}

return var_0_0
