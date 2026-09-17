local var_0_0 = {
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 8,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 19,
				id = 11011021,
				effect = {
					{
						ani = "attack",
						name = "110110_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack1 = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 19,
				id = 11011021,
				effect = {
					{
						ani = "attack",
						name = "110110_effect",
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
				frame = 26,
				force = {
					{
						time = 0.3,
						distance = 240,
						object = "target"
					}
				}
			},
			{
				id = 11011031,
				frame = 24,
				shake = {
					x = 0,
					y = 2
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
	usexp = {
		turnbacklimit = true,
		exe_crash_type = "carry",
		animation = "xp",
		xpeffect = "xp_effect",
		exe_crash_bound = 100,
		exe_type = "crash",
		totalframe = 50,
		action_on_start = {
			{
				startframe = 27,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 220,
							time = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 11011051,
				behitted = "hitdown",
				frame = 35,
				shake = {
					x = 6,
					y = 2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "77100_bg",
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
	lockframe = {
		{
			totalframe = 5,
			startframe = 5,
			timescale = 0.2
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 40,
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
