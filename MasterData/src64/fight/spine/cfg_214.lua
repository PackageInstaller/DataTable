local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
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
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				id = 21420001,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "21400_effect",
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
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				id = 21421001,
				frame = 17,
				effect = {
					{
						ani = "skill2",
						name = "21420_effect",
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
	},
	usexp = {
		totalframe = 30,
		animation = "xp",
		lock_screen = {
			texture = "role/21403.png",
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
				frame = 31,
				id = 21430001,
				effect = {
					{
						ani = "xp_attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.25,
						object = "target"
					}
				},
				sound = {
					"leidian",
					0.6
				}
			}
		}
	},
	usexp1 = {
		totalframe = 30,
		animation = "xp",
		lock_screen = {
			texture = "role/21403.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 31,
				id = 21433001,
				effect = {
					{
						ani = "xp_attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.25,
						object = "target"
					}
				},
				sound = {
					"leidian",
					0.6
				}
			}
		}
	},
	usexp2 = {
		totalframe = 30,
		animation = "xp",
		lock_screen = {
			texture = "role/21410.png",
			lastframe = 30,
			zorder = 200,
			file = "xp2",
			startframe = 0,
			ani = "xp"
		},
		exe_tbl = {
			{
				frame = 31,
				id = 21440001,
				effect = {
					{
						ani = "xp_attack",
						name = "21400_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.25,
						object = "target"
					}
				},
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
	speed = 500,
	offsetZ = 1,
	filename = "21400_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 0,
				id = 21410001,
				sound = {
					"leidianduan",
					0.6
				}
			}
		}
	}
}

return var_0_0
