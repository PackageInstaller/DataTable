local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				bullet = "attack",
				sound = {
					"20400_attack",
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
		totalframe = 42,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"22820_skill",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1"
			},
			{
				frame = 30,
				bullet = "skill2"
			},
			{
				frame = 30,
				bullet = "skill3"
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
		totalframe = 42,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"22820_skill",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1_1"
			},
			{
				frame = 30,
				bullet = "skill2_1"
			},
			{
				frame = 30,
				bullet = "skill3_1"
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
		totalframe = 42,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"22820_skill",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1_2"
			},
			{
				frame = 30,
				bullet = "skill2_2"
			},
			{
				frame = 30,
				bullet = "skill3_2"
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
		totalframe = 42,
		animation = "skill",
		exe_tbl = {
			{
				frame = 5,
				sound = {
					"22820_skill",
					0.6
				}
			},
			{
				frame = 30,
				bullet = "skill1_3"
			},
			{
				frame = 30,
				bullet = "skill2_3"
			},
			{
				frame = 30,
				bullet = "skill3_3"
			}
		}
	},
	usexp = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22820_xp1"
				}
			},
			{
				behitted = "hitdown",
				frame = 69,
				id = 22850001,
				force = {
					{
						time = 0.15,
						shutdown = false,
						distance = 120,
						object = "target"
					}
				},
				forceY = {
					speed = 600
				},
				shake = {
					period = 8,
					x = 20,
					y = 20
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 90,
	bgfile = "22800_bg",
	locktarget = {
		mindistance = 330,
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
			texture = "role/22820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 66,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				intime = 0.2,
				anchory = 250,
				outtime = 0.1,
				totalframe = 51,
				startframe = 0
			},
			{
				scale = 0.9,
				intime = 0.1,
				anchory = 250,
				outtime = 0.2,
				totalframe = 10,
				startframe = 51
			},
			{
				scale = 0.9,
				intime = 0.05,
				anchory = 250,
				outtime = 0.2,
				totalframe = 16,
				startframe = 61
			}
		},
		move = {
			{
				distanceY = 120,
				totalframe = 51,
				startframe = 0,
				time = 0.1
			},
			{
				distance = 200,
				time = 0.1,
				distanceY = -120,
				totalframe = 16,
				startframe = 53
			},
			{
				distance = 70,
				totalframe = 20,
				startframe = 69,
				time = 0.15
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 0.55,
		object = "self"
	},
	finalpos = {
		offsetY = 0.55,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22810001
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktime",
	speed = 1200,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		time = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 24,
		animation = "xp_attack",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 22830001,
				frame = 6,
				forceY = {
					speed = 500
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.95,
		offsetX = 0.9,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.95,
		offsetX = 0.9,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820101,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.95,
		offsetX = 0.9,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820201,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.95,
		offsetX = 0.9,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820301,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 1.2,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2_1 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 1.2,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820101,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2_2 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 1.2,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820201,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2_3 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 1.2,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820301,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill3 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.96,
		offsetX = -1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820001,
				force = {
					{
						time = 0.2,
						shakeutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill3_1 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.96,
		offsetX = -1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820101,
				force = {
					{
						time = 0.2,
						shakeutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill3_2 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.96,
		offsetX = -1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820201,
				force = {
					{
						time = 0.2,
						shakeutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill3_3 = {
	movingani = "skill_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "12815_22800_effect",
	initpos = {
		offsetY = 0.96,
		offsetX = -1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.65,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 1,
				id = 22820301,
				force = {
					{
						time = 0.2,
						shakeutdown = true,
						distance = 30,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
