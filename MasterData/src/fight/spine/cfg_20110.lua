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
					"horn_fire",
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
					"horn_fire",
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
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 16,
				id = 20120001,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"horn_fire",
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
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 16,
				id = 20120101,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"horn_fire",
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
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 16,
				id = 20120201,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"horn_fire",
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
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 16,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 100,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 16,
				id = 20120301,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				},
				sound = {
					"horn_fire",
					0.6
				}
			}
		}
	},
	xp_begin = {
		totalframe = 118,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		anitype = "released",
		animation = "xp",
		action_on_start = {
			{
				startframe = 35,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 100
						}
					}
				}
			},
			{
				startframe = 77,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 50,
							time = 0.1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 37,
				id = 20140001,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				frame = 52,
				id = 20140001,
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				behitted = "hitdown",
				frame = 77,
				id = 20140001,
				force = {
					{
						time = 0.15,
						distance = 25,
						object = "target"
					}
				},
				forceY = {
					speed = 700
				},
				shake = {
					x = 4,
					y = 10
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				frame = 90,
				forceY = {
					speed = -2000
				}
			},
			{
				behitted = "hitdown",
				id = 20140002,
				frame = 92,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				sound = {
					"horn_fire",
					0.6
				}
			},
			{
				frame = 93,
				forceY = {
					speed = 400
				},
				force = {
					{
						time = 0.6,
						shutdown = false,
						distance = 240,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 117,
	bgfile = "20100_bg",
	locktarget = {
		mindistance = 150,
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
			texture = "role/20110.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 87,
			timescale = 0.1
		},
		{
			totalframe = 6,
			startframe = 92.5,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 0
			},
			{
				scale = 1.2,
				totalframe = 10,
				startframe = 90
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 75,
				startframe = 35,
				time = 0.1
			},
			{
				distanceY = 100,
				totalframe = 10,
				startframe = 75,
				time = 0.1
			},
			{
				distance = 80,
				time = 0.1,
				distanceY = -50,
				totalframe = 10,
				startframe = 90
			}
		}
	}
}

return var_0_0
