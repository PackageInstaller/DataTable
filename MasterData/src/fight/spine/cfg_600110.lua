return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60011021,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = "23720-skill"
			},
			{
				frame = 20,
				id = 60011031,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
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
		turnbacklimit = true,
		totalframe = 60,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 25,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 600,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "25520_skill"
			},
			{
				id = 60011041,
				behitted = "hitdown",
				frame = 30
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
		totalframe = 100,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "26120_xp"
			},
			{
				id = 60011061,
				frame = 60,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 60011061,
				behitted = "hitdown",
				frame = 65,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 60011061,
				frame = 75,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			},
			{
				id = 60011061,
				behitted = "hitdown",
				frame = 80,
				force = {
					{
						shotdown = false,
						time = 0.1,
						distance = 100,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "600110_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 1,
						object = "target"
					}
				}
			}
		}
	}
}
