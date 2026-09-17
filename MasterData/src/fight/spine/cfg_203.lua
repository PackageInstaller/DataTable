local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				frame = 7,
				bullet = "attack",
				sound = {
					"leidianduan",
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
	xp2 = {
		{
			{
				method = "useSkill",
				param = "usexp2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "usexp3"
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 20,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 12,
				bullet = "skill1"
			}
		}
	},
	useskill2 = {
		totalframe = 15,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 7,
				bullet = "skill2",
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 51,
		animation = "xp",
		lock_screen = {
			texture = "role/20303.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 35,
				bullet = "xp",
				sound = {
					"leidian",
					0.6
				}
			}
		}
	},
	usexp1 = {
		totalframe = 51,
		animation = "xp",
		lock_screen = {
			texture = "role/20301.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 35,
				bullet = "xp1",
				sound = {
					"leidian",
					0.6
				}
			}
		}
	},
	usexp2 = {
		totalframe = 51,
		animation = "xp",
		lock_screen = {
			texture = "role/20303.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 35,
				bullet = "xp2",
				sound = {
					"leidian",
					0.6
				}
			}
		}
	},
	usexp3 = {
		totalframe = 51,
		animation = "xp",
		lock_screen = {
			texture = "role/20310.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 35,
				bullet = "xp3",
				sound = {
					"leidian",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 20310001,
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 27,
		animation = "xp_attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 600,
					maxcatapult = 2,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20330001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 27,
		animation = "xp_attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 600,
					maxcatapult = 2,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20331001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.xp2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 27,
		animation = "xp_attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 600,
					maxcatapult = 2,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20333001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.xp3 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 27,
		animation = "xp_attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 600,
					maxcatapult = 2,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20340001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 37,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 2,
				id = 20320001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leipixia",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = -1,
	filename = "20300_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				id = 20321001,
				effect = {
					{
						ani = "passive_effect",
						name = "20320_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	}
}

return var_0_0
