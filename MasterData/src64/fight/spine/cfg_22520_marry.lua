local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				id = 22510001,
				effect = {
					{
						ani = "attack",
						name = "22520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"22500_attack",
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
		skillattackframe = 45,
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_skill",
					0.6
				}
			},
			{
				id = 22520001,
				frame = 14
			},
			{
				id = 22520001,
				frame = 30
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_skill",
					0.6
				}
			},
			{
				id = 22520101,
				frame = 14
			},
			{
				id = 22520101,
				frame = 30
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_skill",
					0.6
				}
			},
			{
				id = 22520201,
				frame = 14
			},
			{
				id = 22520201,
				frame = 30
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_skill",
					0.6
				}
			},
			{
				id = 22520301,
				frame = 14
			},
			{
				id = 22520301,
				frame = 30
			}
		}
	},
	usexp = {
		totalframe = 96,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 34,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22500_xp"
				}
			},
			{
				id = 22550001,
				frame = 36
			},
			{
				id = 22550001,
				frame = 48
			},
			{
				frame = 66,
				behitted = "hitdown",
				id = 22550002,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 94,
	bgfile = "marry_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "animation"
		}
	},
	inserteffect = {
		{
			texture = "role/22520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 36,
			timescale = 0.15
		},
		{
			totalframe = 6,
			startframe = 66,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 10
			}
		}
	}
}

return var_0_0
