local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"201720_attack",
					0.6
				}
			},
			{
				frame = 20,
				bullet = "attack"
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 60,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202020_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 202020010,
				effect = {
					{
						ani = "skill",
						name = "202020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 30,
				id = 202020010,
				effect = {
					{
						ani = "skill",
						name = "202020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 202020010,
				effect = {
					{
						ani = "skill",
						name = "202020_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202020_xp",
					0.6
				}
			},
			{
				id = 202030010,
				behitted = "hitdown",
				frame = 76
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	totalframe = 90,
	bgfile = "202020_bg",
	locktarget = {
		mindistance = 200,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/202020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/Hikari_05",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 15
			},
			{
				scale = 1,
				totalframe = 30,
				startframe = 55
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 50,
				startframe = 40,
				time = 1.6
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "202020_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 202010010
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill_run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 10000,
	offsetZ = 1,
	filename = "202020_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "skill",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 1000,
					maxcatapult = 3,
					condition = "next"
				}
			}
		},
		exe_tbl = {
			{
				id = 202020010,
				frame = 10
			}
		}
	}
}

return var_0_0
