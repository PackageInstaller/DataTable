local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack2_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack2_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack2",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack3_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack1_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack2_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack2_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack2",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack3_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack1_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack2_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack2_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack2",
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	attack3_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"yinxiang",
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	skill1 = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 9
				}
			},
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		},
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 6
				}
			},
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		},
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_1 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				id = 21820001,
				frame = 16,
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820002,
				frame = 16,
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820003,
				frame = 16,
				sound = {
					"zhiliao",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 85,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 35,
				id = 21830002,
				effect = {
					{
						ani = "xp4",
						name = "21800_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"yinxiang",
					0.6
				}
			},
			{
				frame = 55,
				id = 21830002,
				effect = {
					{
						ani = "xp4",
						name = "21800_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"yinxiang",
					0.6
				}
			},
			{
				frame = 75,
				id = 21830002,
				effect = {
					{
						ani = "xp4",
						name = "21800_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"yinxiang",
					0.6
				}
			},
			{
				id = 21830001,
				frame = 85,
				sound = {
					"yinxiang",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	initposy = 290,
	totalframe = 85,
	bgfile = "21800_bg",
	locktarget = {
		locktargetpool = "self"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	bgaction = {
		{
			param = 101,
			startframe = 0,
			action = "setZOrder"
		},
		{
			param = 0,
			startframe = 14,
			action = "setZOrder"
		}
	},
	inserteffect = {
		{
			texture = "role/21810.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				startframe = 30,
				scale = 1.05,
				outtime = 0.6,
				totalframe = 45,
				intime = 0.3
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 85,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 35,
			id = 21850002,
			effect = {
				{
					ani = "xp4",
					name = "21800_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"yinxiang",
				0.6
			}
		},
		{
			frame = 55,
			id = 21850002,
			effect = {
				{
					ani = "xp4",
					name = "21800_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"yinxiang",
				0.6
			}
		},
		{
			frame = 75,
			id = 21850002,
			effect = {
				{
					ani = "xp4",
					name = "21800_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"yinxiang",
				0.6
			}
		},
		{
			id = 21850001,
			frame = 85,
			sound = {
				"yinxiang",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	initposy = 290,
	totalframe = 85,
	bgfile = "21600_bg",
	locktarget = {
		locktargetpool = "self"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	bgaction = {
		{
			param = 101,
			startframe = 0,
			action = "setZOrder"
		},
		{
			param = 0,
			startframe = 14,
			action = "setZOrder"
		}
	},
	inserteffect = {
		{
			texture = "role/21810.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	camera = {
		zoom = {
			{
				startframe = 30,
				scale = 1.05,
				outtime = 0.6,
				totalframe = 45,
				intime = 0.3
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run1",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				id = 21810001,
				sound = "guitar1"
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run3",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = 1,
	filename = "21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				id = 21810003,
				sound = "zhiliao"
			}
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run2",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = 1,
	filename = "21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 21810002,
				sound = "guitar2"
			}
		}
	}
}

return var_0_0
