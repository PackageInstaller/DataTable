local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 27,
		animation = "attack1",
		exe_tbl = {
			{
				id = 212310010,
				frame = 13
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
		skillattackframe = 50,
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 16,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 212320010,
				frame = 34,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 120,
						object = "target"
					}
				}
			},
			{
				frame = 35,
				id = 212320011
			}
		}
	},
	usexp = {
		totalframe = 164,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_xp1"
				}
			},
			{
				id = 212330010,
				frame = 93,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 98,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 105,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 212330010,
				frame = 121,
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				frame = 123,
				id = 212330011
			},
			{
				frame = 125,
				id = 212330012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	initpos = -100,
	focusoffset = 150,
	totalframe = 164,
	bgfile = "212320_bg",
	locktarget = {
		mindistance = 250,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "212320_bg"
		}
	},
	inserteffect = {
		{
			texture = "role/212320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/212320_xp",
				1
			}
		}
	},
	camera = {
		move = {
			{
				distance = 50,
				totalframe = 27,
				startframe = 43,
				time = 0.1
			}
		}
	}
}

return var_0_0
