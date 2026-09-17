local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60015021,
				frame = 16,
				effect = {
					{
						ani = "attack",
						name = "600150_effect",
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "260_skill2"
			},
			{
				frame = 20,
				bullet = "skill"
			},
			{
				frame = 25,
				bullet = "skill"
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
		totalframe = 80,
		animation = "xp",
		exe_tbl = {
			{
				frame = 15,
				sound = "460210-skill2"
			},
			{
				frame = 30,
				sound = "460210-skill2"
			},
			{
				frame = 45,
				sound = "460210-skill2"
			},
			{
				frame = 60,
				sound = "460210-skill2"
			},
			{
				frame = 75,
				sound = "460210-skill2"
			},
			{
				frame = 20,
				bullet = "xp"
			},
			{
				frame = 25,
				bullet = "xp"
			},
			{
				frame = 30,
				bullet = "xp"
			},
			{
				frame = 35,
				bullet = "xp"
			},
			{
				frame = 40,
				bullet = "xp"
			},
			{
				frame = 45,
				bullet = "xp"
			},
			{
				frame = 50,
				bullet = "xp"
			},
			{
				frame = 55,
				bullet = "xp"
			},
			{
				frame = 60,
				bullet = "xp"
			},
			{
				frame = 65,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "600150_effect",
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
		totalframe = 7,
		animation = "skill",
		exe_tbl = {
			{
				id = 60015031,
				frame = 5
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
	filename = "600150_effect",
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
		totalframe = 13,
		animation = "xp",
		exe_tbl = {
			{
				id = 60015061,
				frame = 8
			}
		}
	}
}

return var_0_0
