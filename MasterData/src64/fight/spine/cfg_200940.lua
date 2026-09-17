local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				frame = 18,
				id = 200910010
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 200910010
			},
			{
				frame = 15,
				id = 200910011
			},
			{
				frame = 15,
				id = 200910012
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202920_skill",
					1
				}
			},
			{
				frame = 30,
				id = 200920010
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
		totalframe = 100,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 6,
				sound = {
					"200920_xp",
					1
				}
			},
			{
				id = 200930010,
				frame = 53,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				id = 200930010,
				frame = 70,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				id = 200930010,
				frame = 82,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				frame = 92,
				id = 200930011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 0,
	bgfilescale = 1,
	bgfile = "200940_bg",
	totalframe = 100,
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	locktarget = {
		locktarget = "openent"
	},
	inserteffect = {
		{
			texture = "role/200940.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 5,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 45
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 55,
				startframe = 35,
				time = 0.5
			}
		}
	}
}

return var_0_0
