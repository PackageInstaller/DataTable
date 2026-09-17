local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60024021,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "600240_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "21200_xp"
			},
			{
				id = 60024031,
				frame = 20,
				effect = {
					{
						ani = "attack",
						name = "600240_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 60024031,
				frame = 25,
				effect = {
					{
						ani = "attack",
						name = "600240_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				frame = 60,
				id = 60024031,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "600240_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
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
		totalframe = 45,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "254_skill"
			},
			{
				frame = 5,
				sound = "254_skill"
			},
			{
				frame = 15,
				bullet = "skill2"
			},
			{
				frame = 25,
				bullet = "skill2"
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
		totalframe = 70,
		animation = "xp",
		exe_tbl = {
			{
				frame = 15,
				sound = "21320_xp"
			},
			{
				frame = 62,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "600240_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 60024031,
				frame = 5
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "600240_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 19,
		animation = "xp",
		exe_tbl = {
			{
				id = 60024061,
				frame = 4
			}
		}
	}
}

return var_0_0
