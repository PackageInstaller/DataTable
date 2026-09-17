local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 5,
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
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack2"
			}
		},
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 15,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack3"
			}
		},
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 20,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack4"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 22,
				bullet = "dan1"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 22,
				bullet = "dan2"
			}
		}
	},
	attack3 = {
		totalframe = 30,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 22,
				bullet = "dan3"
			}
		}
	},
	attack4 = {
		totalframe = 30,
		animation = "attack4",
		exe_tbl = {
			{
				frame = 22,
				bullet = "dan4"
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
				frame = 22,
				bullet = "skill"
			},
			{
				frame = 28,
				bullet = "skill"
			},
			{
				frame = 32,
				bullet = "skill"
			},
			{
				frame = 37,
				bullet = "skill"
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
		xpeffect = "xp_effect",
		totalframe = 60,
		animation = "xp",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 15,
							posx = 0
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10010191,
				frame = 30
			},
			{
				id = 10010191,
				frame = 35
			},
			{
				id = 10010191,
				frame = 40
			},
			{
				id = 10010191,
				frame = 45
			},
			{
				id = 10010191,
				frame = 50
			},
			{
				id = 10010191,
				frame = 55
			}
		}
	}
}

var_0_0.extra.dan1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100101_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = -0.1,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10010161,
				effect = {
					{
						ani = "attack",
						name = "100101_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.dan2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100101_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = -0.1,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10010161,
				effect = {
					{
						ani = "attack",
						name = "100101_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.dan3 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100101_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = -0.1,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10010161,
				effect = {
					{
						ani = "attack",
						name = "100101_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.dan4 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100101_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = -0.1,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10010161,
				effect = {
					{
						ani = "attack",
						name = "100101_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100101_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = -0.3,
		object = "target"
	},
	attack = {
		totalframe = 17,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10010171,
				effect = {
					{
						ani = "skill",
						name = "100101_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 55,
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
				scale = 1.1,
				totalframe = 40,
				startframe = 16
			}
		},
		move = {}
	}
}

return var_0_0
