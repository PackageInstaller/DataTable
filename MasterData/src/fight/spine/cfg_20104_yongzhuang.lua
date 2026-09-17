local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 20110001,
				frame = 11,
				sound = {
					"20100_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 11,
				id = 20110001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 20,
				id = 20120001,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"20100_skill",
					0.6
				}
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 20,
				id = 20120101,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"20100_skill",
					0.6
				}
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 20,
				id = 20120201,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"20100_skill",
					0.6
				}
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
		turnbacklimit = true,
		exe_crash_type = "carry",
		exe_crash_bound = 80,
		exe_type = "crash",
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.2
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 20,
				id = 20120301,
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"20100_skill",
					0.6
				}
			}
		}
	},
	xp_begin = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		anitype = "released",
		animation = "xp",
		action_on_start = {
			{
				startframe = 21,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 50
						}
					}
				}
			},
			{
				startframe = 33,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
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
					"20104-xp",
					0.6
				}
			},
			{
				behitted = "hit",
				id = 20134001,
				frame = 26,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				},
				shake = {
					x = 8,
					y = 0
				}
			},
			{
				behitted = "hit",
				id = 20134001,
				frame = 38,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 120,
						object = "target"
					}
				},
				shake = {
					x = 8,
					y = 0
				}
			},
			{
				behitted = "hit",
				id = 20134003,
				frame = 59,
				forceY = {
					speed = 200
				},
				shake = {
					x = 4,
					y = 30
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 30,
						object = "target"
					}
				}
			},
			{
				behitted = "hitdown",
				frame = 75,
				id = 20134003,
				forceY = {
					speed = 600
				},
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				},
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
	totalframe = 90,
	bgfile = "swim_bg",
	locktarget = {
		mindistance = 150,
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
			texture = "role/20104.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20104_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 75,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 17,
				startframe = 0
			},
			{
				scale = 1,
				totalframe = 70,
				startframe = 20
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 25,
				startframe = 55,
				time = 0.1
			}
		}
	}
}

return var_0_0
