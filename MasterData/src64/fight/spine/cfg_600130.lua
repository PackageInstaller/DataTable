local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
			},
			{
				frame = 20,
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
				frame = 1,
				sound = "460200-skill1"
			},
			{
				id = 60013031,
				frame = 27,
				effect = {
					{
						ani = "skill",
						name = "600130_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				0.8,
				frame = 15,
				sound = "260_skill2"
			},
			{
				id = 60013041,
				frame = 30,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill2",
						name = "600130_effect",
						offsetZ = 3,
						offsetY = 0.5,
						offsetX = 0.8,
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
		totalframe = 87,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "22220_xp"
			},
			{
				id = 60013061,
				behitted = "hitdown",
				frame = 64
			},
			{
				frame = 67,
				id = 60013061
			},
			{
				id = 60013061,
				behitted = "hitdown",
				frame = 70
			},
			{
				frame = 73,
				id = 60013061
			},
			{
				id = 60013061,
				behitted = "hitdown",
				frame = 75
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "600130_effect",
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
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60013021,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "600130_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
