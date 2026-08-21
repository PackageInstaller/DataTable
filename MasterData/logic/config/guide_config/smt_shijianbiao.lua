-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/smt_shijianbiao.lua

local configData = {
	step1 = {
		tips = "游戏内会周期性进入密室时间，和显示时间的对照详见上表",
		img = "smt_shijianbiao1",
		mask = true,
		imgKuang = {
			{
				45.42654,
				161.1201,
				0,
				352,
				111.9
			},
			{
				5.678314,
				-151.1875,
				0,
				885.8,
				190
			}
		},
		leftHint = {
			{
				175.5434,
				73.60279,
				0,
				"游戏外时间"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "可以快捷查看密室时间的切换倒计时",
		img = "smt_shijianbiao1",
		mask = true,
		imgKuang = {
			{
				-160.4126,
				-58.91484,
				0,
				127,
				40
			}
		},
		leftHint = {},
		rightHint = {
			{
				367.1867,
				-145.0126,
				0,
				"倒计时"
			}
		}
	},
	step3 = {
		tips = "在正常时间还可以通过道具强制开启密室时间",
		img = "smt_shijianbiao1",
		mask = true,
		imgKuang = {
			{
				360.5734,
				-53.23651,
				0,
				140,
				50
			}
		},
		leftHint = {
			{
				599.9979,
				-139.3343,
				0,
				"强制开始"
			}
		},
		rightHint = {}
	},
	step4 = {
		tips = "密室时间会存在不同于正常时间的玩法，请主管留意这一周期",
		img = "smt_shijianbiao1",
		mask = true,
		imgKuang = {
			{
				5.678314,
				-151.1875,
				0,
				885.8,
				190
			}
		},
		leftHint = {},
		rightHint = {}
	}
}

return configData
