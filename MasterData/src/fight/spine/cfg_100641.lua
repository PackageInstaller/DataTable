return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				id = 10064120,
				effect = {
					{
						ani = "attack",
						name = "100641_effect",
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
		totalframe = 60,
		animation = "skill",
		exe_tbl = {
			{
				id = 10064130,
				frame = 30
			}
		}
	}
}
