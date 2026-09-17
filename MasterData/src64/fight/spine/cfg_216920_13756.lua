local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23720-attack",
					0.6
				}
			},
			{
				id = 216910010,
				frame = 15
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
		skillattackframe = 45,
		totalframe = 46,
		animation = "skill",
		action_on_start = {
			{
				startframe = 30,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 50
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23720-skill",
					0.6
				}
			},
			{
				id = 216920010,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		animation = "xp",
		xpeffect = "xp_effect",
		exe_crash_bound = 150,
		totalframe = 102,
		action_on_start = {
			{
				startframe = 52,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 1
						}
					}
				}
			}
		},
		sound = {
			frame = 8,
			volume = 0.6,
			file = "23720-xp"
		},
		exe_tbl = {
			{
				frame = 70,
				force = {
					{
						time = 0.1,
						distance = 500,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 200
					}
				}
			},
			{
				id = 216930012,
				frame = 80,
				shake = {
					x = 6,
					y = 2
				}
			},
			{
				frame = 61,
				id = 216930010
			},
			{
				frame = 75,
				id = 216930011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 102,
	bgfile = "216920_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/216920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/23720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 94,
			timescale = 0.4
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 42
			}
		},
		move = {}
	}
}

return var_0_0
