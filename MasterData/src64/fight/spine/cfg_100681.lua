return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10068120,
				frame = 10
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
				frame = 10,
				id = 10068130,
				effect = {
					{
						ani = "skill",
						name = "100681_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"440300-xp",
					0.3
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
		totalframe = 60,
		animation = "xp",
		exe_tbl = {
			{
				id = 10068160,
				frame = 25,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 150,
						object = "target"
					}
				},
				effect = {
					{
						ani = "xp",
						name = "100681_effect",
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
