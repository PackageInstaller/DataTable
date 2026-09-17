local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack_1",
		exe_tbl = {
			{
				id = 26110001,
				frame = 9,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack_2",
		exe_tbl = {
			{
				id = 26110001,
				frame = 14,
				sound = {
					"20200_attack",
					0.6
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 44,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"26120_skill",
					0.6
				}
			},
			{
				frame = 10,
				bullet = "skill1"
			},
			{
				frame = 30,
				bullet = "skill1"
			}
		}
	}
}

var_0_0.extra.skill1 = {
	movingani = "skill",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skill2",
		exe_tbl = {
			{
				id = 26120001,
				frame = 3
			}
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = false,
	xpeffect = "xp_effect",
	totalframe = 110,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26120_xp",
				0.6
			}
		},
		{
			id = 26130001,
			behitted = "hitdown",
			frame = 12
		},
		{
			id = 26130001,
			behitted = "hitdown",
			frame = 22
		},
		{
			id = 26130001,
			behitted = "hitdown",
			frame = 32
		},
		{
			frame = 55,
			bullet = "xp"
		},
		{
			frame = 60,
			id = 26130002
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "lockdirection",
	speed = 700,
	offsetZ = 1,
	filename = "26100_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "carry",
		direction = 1
	},
	attack = {
		animation = "skill2",
		totalframe = 15
	}
}
var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 1,
	bgfile = "26100_bg",
	totalframe = 110,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = true
	},
	inserteffect = {
		{
			texture = "role/26120.png",
			ani = "xp",
			donotlock = false,
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/26120_xp",
				1
			}
		}
	},
	bgani = {
		{
			startframe = 0,
			ani = "bg"
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 59,
			timescale = 0.4
		}
	},
	camera = {
		zoom = {
			{
				startframe = 0,
				scale = 1.2,
				outtime = 0.3,
				totalframe = 30,
				intime = 0.1
			},
			{
				startframe = 59,
				scale = 0.8,
				outtime = 0.3,
				totalframe = 51,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 59,
				startframe = 0,
				time = 0.2
			},
			{
				distance = 150,
				time = 0.3,
				distanceY = 0,
				totalframe = 30,
				startframe = 70
			},
			{
				pos = "self",
				totalframe = 10,
				startframe = 100,
				time = 0.1
			}
		}
	}
}

return var_0_0
