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
				id = 23710001,
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
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
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
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
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
				frame = 30,
				force = {
					{
						time = 0.1,
						distance = 140,
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
				id = 23720001,
				frame = 34,
				shake = {
					x = 0,
					y = 2
				}
			}
		}
	},
	useskill1_1 = {
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
				id = 23720101,
				frame = 33,
				shake = {
					x = 0,
					y = 2
				}
			}
		}
	},
	useskill1_2 = {
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
		sound = {
			frame = 10,
			volume = 0.6,
			file = "23720-skill"
		},
		exe_tbl = {
			{
				id = 23720201,
				frame = 33,
				shake = {
					x = 0,
					y = 2
				}
			}
		}
	},
	useskill1_3 = {
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
				id = 23720301,
				frame = 33,
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
		exe_type = "crash",
		totalframe = 102,
		action_on_start = {
			{
				startframe = 52,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 300,
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
				id = 23730001,
				frame = 75,
				shake = {
					x = 6,
					y = 2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 102,
	bgfile = "23720_bg",
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
			texture = "role/23720.png",
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
