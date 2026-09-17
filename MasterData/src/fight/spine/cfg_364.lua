local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 32,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 28,
				bullet = "skill",
				shake = {
					x = 4,
					y = 4
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
		totalframe = 68,
		animation = "xp",
		exe_tbl = {
			{
				frame = 20,
				effect = {
					{
						ani = "xp-run",
						name = "36400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 54,
				behitted = "hitdown",
				bullet = "xp",
				shake = {
					x = 6,
					y = 0
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "36400_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.6,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 36410001,
				frame = 3
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "36400_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 20,
		animation = "skill-attack",
		exe_tbl = {
			{
				id = 36420001,
				frame = 3
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp-run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "36400_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 23,
		animation = "xp-attack",
		exe_tbl = {
			{
				id = 36430001,
				frame = 3
			}
		}
	}
}

return var_0_0
