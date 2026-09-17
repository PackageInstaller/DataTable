local var_0_0 = {
	extra = {},
	attack1 = {
		totalframe = 33,
		animation = "attack1",
		exe_tbl = {
			{
				id = 36210001,
				frame = 16,
				effect = {
					{
						ani = "attack",
						name = "36200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 37,
		animation = "attack2",
		exe_tbl = {
			{
				id = 36210001,
				frame = 16,
				effect = {
					{
						ani = "attack",
						name = "36200_effect",
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 58,
		animation = "skill",
		exe_tbl = {
			{
				bullet = "skill1",
				frame = 37,
				sound = {
					"20200_attack",
					0.6
				},
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "skill-attack",
						name = "36200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 480,
	offsetZ = 1,
	filename = "22000_effect",
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
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 36220001,
				frame = 1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 66,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1
		},
		{
			id = 36230001,
			frame = 45,
			shake = {
				x = 0,
				y = 8
			},
			force = {
				{
					time = 0.6,
					shutdown = false,
					distance = 180,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
