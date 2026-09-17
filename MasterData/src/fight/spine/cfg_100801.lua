return {
	extra = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10080120,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "100801_effect",
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
		totalframe = 54,
		animation = "skill",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 10080130,
				frame = 40,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 150,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 450
					}
				},
				effect = {
					{
						ani = "skill",
						name = "100801_effect",
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
