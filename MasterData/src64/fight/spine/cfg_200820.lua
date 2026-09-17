local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				frame = 17,
				id = 200810011
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 10,
				sound = {
					"29820_attack_01",
					0.6
				}
			},
			{
				frame = 17,
				id = 200810010
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
				sound = {
					"29820_skill_01",
					0.6
				}
			},
			{
				frame = 26,
				id = 200820011
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 45,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29820_skill_01",
					0.6
				}
			},
			{
				frame = 26,
				id = 200820010
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "use_xp"
			}
		}
	},
	use_xp = {
		totalframe = 135,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29820_xp_01",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "xp"
			},
			{
				id = 200830010,
				behitted = "hitdown",
				frame = 43,
				forceY = {
					{
						distance = 150,
						time = 1.1
					}
				}
			},
			{
				id = 200830012,
				behitted = "hitdown",
				frame = 71,
				forceY = {
					{
						distance = 100,
						time = 1.1
					}
				}
			},
			{
				id = 200830011,
				behitted = "hitdown",
				frame = 120
			},
			{
				id = 200830013,
				behitted = "hitdown",
				frame = 121
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 100,
	bgfilescale = 0.9,
	initpos = 0,
	bgfile = "200820_bg",
	totalframe = 135,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
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
			texture = "role/200820.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/200820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 13,
			startframe = 121,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {
			{
				startframe = 36,
				scale = 0.8,
				anchory = 0,
				outtime = 0.3,
				totalframe = 90,
				intime = 0.1
			}
		},
		move = {
			{
				pos = "target",
				time = 0.8,
				distance = -550,
				totalframe = 90,
				startframe = 36
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 200,
	movingtype = "lockdirection",
	speed = 80,
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
		totalframe = 60
	}
}

return var_0_0
