local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 15,
				id = 29910010
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29920_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 29920012
			},
			{
				id = 29920010,
				frame = 30,
				force = {
					{
						shotdown = false,
						time = 0.2,
						distance = 120,
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29920_skill",
					0.6
				}
			},
			{
				frame = 30,
				id = 29920011
			},
			{
				id = 29920010,
				frame = 30,
				force = {
					{
						shotdown = false,
						time = 0.2,
						distance = 120,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 100,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"29920_xp",
					0.6
				}
			},
			{
				id = 29930010,
				behitted = "hitdown",
				frame = 81,
				shake = {
					x = 0,
					y = 20
				}
			},
			{
				frame = 82,
				id = 29930011
			},
			{
				frame = 83,
				id = 29930012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 100,
	bgfile = "29920_bg",
	locktarget = {
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
			texture = "role/29920.png",
			ani = "xp3",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/29920_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 37,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				distance = 0,
				time = 0.5,
				distanceY = 0,
				totalframe = 100,
				startframe = 0
			}
		}
	}
}

return var_0_0
