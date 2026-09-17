return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60014021,
				frame = 16
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
				frame = 1,
				sound = "420220-skill3"
			},
			{
				frame = 27,
				id = 60014031,
				effect = {
					{
						ani = "skill",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						shotdown = false,
						time = 0.5,
						distance = 400,
						object = "target"
					}
				}
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
	useskill2 = {
		totalframe = 57,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 10,
				sound = "450210-skill2"
			},
			{
				frame = 36,
				id = 60014041,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill2",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 60014041,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill2",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
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
		totalframe = 80,
		animation = "xp",
		exe_tbl = {
			{
				frame = 20,
				sound = "400300-xp"
			},
			{
				id = 60014061,
				frame = 31,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 35,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 39,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 43,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 47,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 51,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 55,
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			},
			{
				id = 60014061,
				frame = 59,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp",
						name = "600140_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			}
		}
	}
}
