local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				bullet = "attack"
			},
			{
				frame = 20,
				bullet = "attack2"
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
		totalframe = 24,
		animation = "skill",
		exe_tbl = {
			{
				frame = 21,
				id = 11012031,
				effect = {
					{
						ani = "attack",
						name = "110120_effect",
						offsetZ = 1,
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
		totalframe = 70,
		animation = "xp",
		exe_tbl = {
			{
				frame = 5,
				effect = {
					{
						ani = "xp",
						name = "110120_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 11012051,
				frame = 50
			},
			{
				id = 11012051,
				frame = 52
			},
			{
				id = 11012051,
				frame = 54
			},
			{
				id = 11012051,
				frame = 57
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "110120_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				id = 11012021,
				frame = 1
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "110120_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 1,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				id = 11012021,
				frame = 3
			}
		}
	}
}

return var_0_0
