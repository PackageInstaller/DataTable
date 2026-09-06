-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_md_spine_behavior.lua

module("logicconfig.config.t_md_spine_behavior", package.seeall)

local title = {
	triggerBoardName = 9,
	condValidator = 5,
	triggerParam = 7,
	behaviorId = 3,
	skinPlanId = 1,
	triggerMotions = 10,
	triggerType = 6,
	nextBehaviorId = 4,
	triggerValidator = 8,
	behaviorLayerId = 2
}
local dataList = {
	{
		1101103,
		1,
		1,
		2,
		"publicparam$2,true",
		"PointerClick",
		nil,
		"",
		"tui",
		{
			{
				animName = "01",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1101103,
		1,
		2,
		1,
		"publicparam$2,false",
		"PointerClick",
		nil,
		"",
		"tui",
		{
			{
				animName = "00",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1101103,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"hudie",
		{
			{
				animName = "02",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1101103,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"tou",
		{
			{
				animName = "03",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1101103,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"xiong",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1101103,
		5,
		1,
		2,
		"publicparam$1,大于等于,100",
		"FreeDrag",
		nil,
		"",
		"xiong",
		{
			{
				publicParamId = "1",
				modifyValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1101103,
		5,
		2,
		1,
		"publicparam$1,小于,100",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "05",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1101103,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"qiang",
		{
			{
				animName = "06",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1101103,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1100203,
		1,
		1,
		2,
		"publicparam$2,true",
		"PointerClick",
		nil,
		"",
		"tui",
		{
			{
				animName = "01",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1100203,
		1,
		2,
		1,
		"publicparam$2,false",
		"PointerClick",
		nil,
		"",
		"tui",
		{
			{
				animName = "00",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1100203,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"hudie",
		{
			{
				animName = "02",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1100203,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"tou",
		{
			{
				animName = "03",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1100203,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"xiong",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1100203,
		5,
		1,
		2,
		"publicparam$1,大于等于,100",
		"FreeDrag",
		nil,
		"",
		"xiong",
		{
			{
				publicParamId = "1",
				modifyValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1100203,
		5,
		2,
		1,
		"publicparam$1,小于,100",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "05",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1100203,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"qiang",
		{
			{
				animName = "06",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1100203,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1401602,
		1,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03_ry",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04_lf",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "05_zl",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"06",
		{
			{
				animName = "06_mx",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		5,
		1,
		0,
		"",
		"FreeDrag",
		nil,
		"",
		"02",
		{
			{
				animName = "02_tq",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		6,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "01_qw",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1401602,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1031302,
		1,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03_ry",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04_lf",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "05_zl",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"06",
		{
			{
				animName = "06_mx",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		5,
		1,
		0,
		"",
		"FreeDrag",
		nil,
		"",
		"02",
		{
			{
				animName = "02_tq",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		6,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "01_qw",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1031302,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1800101,
		1,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"01",
		{
			{
				animName = "01",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		2,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"02",
		{
			{
				animName = "02",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"05",
		{
			{
				animName = "05",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		6,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"06",
		{
			{
				animName = "06",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800101,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1402301,
		1,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"01",
		{
			{
				animName = "01",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				spineEventIdList = {
					"audio_sx_1402301_01"
				}
			}
		}
	},
	{
		1402301,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"02",
		{
			{
				animName = "02",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1402301,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				spineEventIdList = {
					"audio_sx_1402301_02"
				}
			}
		}
	},
	{
		1402301,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				spineEventIdList = {
					"audio_sx_1402301_03"
				}
			}
		}
	},
	{
		1402301,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "05",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				spineEventIdList = {
					"audio_sx_1402301_04"
				}
			}
		}
	},
	{
		1402301,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1202001,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202001,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1602401,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "01",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"02",
		{
			{
				animName = "02",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "05",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"06",
		{
			{
				animName = "06",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602401,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1800102,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "01",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1800102,
		2,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"02",
		{
			{
				animName = "02",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1800102,
		2,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"02",
		{
			{
				trackIndex = "1",
				isKeep = "false",
				motionType = "spineanim"
			},
			{
				trackIndex = "2",
				isKeep = "false",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1800102,
		3,
		1,
		2,
		"publicparam$2,true",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "2",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1800102,
		3,
		2,
		1,
		"publicparam$2,false",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "03_2",
				isKeep = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1800102,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04",
				isForbid = "true",
				trackIndex = "3",
				motionType = "spineanim"
			}
		}
	},
	{
		1800102,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "05",
				isForbid = "true",
				trackIndex = "3",
				motionType = "spineanim"
			}
		}
	},
	{
		1800102,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1602606,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		2,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1602606,
		2,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1602606,
		2,
		3,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1602606,
		3,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		7,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602606,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1602607,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		2,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1602607,
		2,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1602607,
		2,
		3,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1602607,
		3,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		7,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"8",
		{
			{
				animName = "8",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1602607,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1600106,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		2,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1600106,
		2,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1600106,
		2,
		3,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1600106,
		3,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		7,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600106,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1600107,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		2,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1600107,
		2,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1600107,
		2,
		3,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1600107,
		3,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		7,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"8",
		{
			{
				animName = "8",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600107,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1802101,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"01",
		{
			{
				animName = "01",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802101,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"02",
		{
			{
				animName = "02",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1",
				showObjs = {
					"fx_feixisi_loop"
				},
				showObjsTicks = {
					0
				}
			}
		}
	},
	{
		1802101,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"03",
		{
			{
				animName = "03",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802101,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"04",
		{
			{
				animName = "04",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1",
				showObjs = {
					"fx_feixisi_loop"
				},
				showObjsTicks = {
					0
				}
			}
		}
	},
	{
		1802101,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"05",
		{
			{
				animName = "05",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802101,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"06",
		{
			{
				animName = "06",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1",
				showObjs = {
					"fx_feixisi_loop"
				},
				showObjsTicks = {
					0
				}
			}
		}
	},
	{
		1802101,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1503201,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1503201,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1503201,
		3,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1503201,
		4,
		1,
		2,
		"publicparam$2,等于,2",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1503201,
		4,
		2,
		3,
		"publicparam$2,等于,3",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1503201,
		4,
		3,
		4,
		"publicparam$1,大于等于,100",
		"FreeDrag",
		nil,
		"",
		"4",
		{
			{
				publicParamId = "1",
				modifyValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1503201,
		4,
		4,
		1,
		"publicparam$1,小于,100",
		"EnterState",
		nil,
		"",
		"4",
		{
			{
				animName = "4_3",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			},
			{
				publicParamId = "2",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1503201,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1503201,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1503201,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1603404,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603404,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603404,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603404,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603404,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603404,
		6,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1603404,
		6,
		2,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"7",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1603404,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1603405,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603405,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603405,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603405,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603405,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1603405,
		6,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1603405,
		6,
		2,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1603405,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1601604,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601604,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601604,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601604,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601604,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601604,
		6,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1601604,
		6,
		2,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"7",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1601604,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1601605,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601605,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601605,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601605,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601605,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1601605,
		6,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1601605,
		6,
		2,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				trackIndex = "1",
				isForbid = "true",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1601605,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1603202,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1603202,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1603202,
		3,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1603202,
		3,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1603202,
		3,
		3,
		4,
		"publicparam$1,等于,4",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "4",
				motionType = "publicparam"
			}
		}
	},
	{
		1603202,
		3,
		4,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1603202,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1603202,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1603202,
		6,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1603202,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1600502,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600502,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600502,
		3,
		1,
		2,
		"publicparam$1,等于,2",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1600502,
		3,
		2,
		3,
		"publicparam$1,等于,3",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1600502,
		3,
		3,
		4,
		"publicparam$1,等于,4",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "4",
				motionType = "publicparam"
			}
		}
	},
	{
		1600502,
		3,
		4,
		1,
		"publicparam$1,等于,1",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1600502,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600502,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600502,
		6,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1600502,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1802103,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802103,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802103,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802103,
		4,
		1,
		2,
		"publicparam$1",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "4_2",
				isKeep = "true",
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1802103,
		4,
		2,
		1,
		"publicparam$1",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1802103,
		5,
		1,
		2,
		"publicparam$2",
		"PointerClick",
		nil,
		"",
		"9",
		{
			{
				animName = "9",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "4",
				isKeep = "true"
			},
			{
				publicParamId = "2",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1802103,
		5,
		2,
		1,
		"publicparam$2",
		"PointerClick",
		nil,
		"",
		"9",
		{
			{
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1802103,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "spineinterfacebubblegame",
				motionType = "event"
			}
		}
	},
	{
		1802103,
		7,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "5_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "5_2",
				isForbid = "true",
				isLoop = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				eventName = "spineinterfacebubblegamestart",
				motionType = "event"
			}
		}
	},
	{
		1802103,
		8,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1802103,
		9,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1802103,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1601003,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"1",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1601003,
		2,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				animName = "2_2",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1601003,
		2,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1601003,
		3,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1601003,
		3,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_huanzhuang",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1601003,
		4,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1601003,
		4,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_huanzhuang",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1601003,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1604003000",
				motionType = "event"
			}
		}
	},
	{
		1601003,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1604003,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"1",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003,
		2,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				animName = "2_2",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1604003,
		2,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2_3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1604003,
		3,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003,
		3,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3_huanzhuang",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003,
		4,
		1,
		2,
		"publicparam$1,true",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003,
		4,
		2,
		1,
		"publicparam$1,false",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4_huanzhuang",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003,
		5,
		1,
		0,
		"",
		"PointerClickDouble",
		nil,
		"",
		"5",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1604003000",
				motionType = "event"
			}
		}
	},
	{
		1604003,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1604003000,
		1,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "5",
				isFadeOut = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			}
		}
	},
	{
		1604003000,
		2,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle",
				isLoop = "true",
				trackIndex = "0",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003000,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003000,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "7",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003000,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"1",
		{
			{
				animName = "8",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1604003000,
		6,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"",
		"0",
		{
			{
				animName = "0",
				isBlock = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1604003000,
		6,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"",
		"0",
		{
			{
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1604003000,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "9",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1403803,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"1",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		2,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isBlock = "true",
				trackIndex = "4",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1403803,
		2,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1403803,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,false",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		4,
		1,
		2,
		"publicparam$1,true",
		"PointerClickDouble",
		nil,
		"",
		"4-1 4-2",
		{
			{
				animName = "4-1",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "1",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "true",
				motionType = "publicparam"
			}
		}
	},
	{
		1403803,
		4,
		2,
		1,
		"publicparam$1,false",
		"PointerClickDouble",
		nil,
		"",
		"4-1 4-2",
		{
			{
				animName = "4-2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				publicParamId = "1",
				fixValue = "false",
				motionType = "publicparam"
			}
		}
	},
	{
		1403803,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,true",
		"4-3",
		{
			{
				animName = "4-3",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "2",
				isKeep = "true"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "xiwangshennvenvelopespinescreenview#1403803000",
				motionType = "event"
			}
		}
	},
	{
		1403803,
		6,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		7,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				animName = "4-5",
				isForbid = "true",
				trackIndex = "3",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,true",
		"4-6",
		{
			{
				animName = "4-6",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		9,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,true",
		"4-7",
		{
			{
				animName = "4-7",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1403803000,
		1,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803000,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803000,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1403803000,
		4,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				animName = "8",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1403803000,
		4,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"",
		"8",
		{
			{
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1403803000,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"9",
		{
			{
				animName = "9_tc",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1038,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1038,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1038,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1040,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1040,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1040,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1041,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "8_2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			}
		}
	},
	{
		1041,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1042,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1042,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1042,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1046,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1046,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1046,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1803101,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				audioId = "180310113",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803101,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"2_1",
		{
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			},
			{
				animName = "2_1",
				isBlock = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"2_2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"",
		{
			{
				animName = "2_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		5,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"4_1",
		{
			{
				audioId = "180310115",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			},
			{
				animName = "4_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "4_1_loop",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		5,
		2,
		3,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,2",
		"4_2",
		{
			{
				animName = "4_2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "4_2_loop",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		5,
		3,
		1,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,2",
		"4_3",
		{
			{
				animName = "4_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"3",
		{
			{
				audioId = "180310114",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			}
		}
	},
	{
		1803101,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				animName = "idle2",
				isLoop = "true",
				trackIndex = "0",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"3",
		{
			{
				animName = "x3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803101,
		9,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"2_1",
		{
			{
				publicParamId = "1",
				fixValue = "11",
				motionType = "publicparam"
			},
			{
				animName = "x2_1",
				isBlock = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,11",
		"2_2",
		{
			{
				animName = "x2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		11,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,11",
		"",
		{
			{
				animName = "x2_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1803101,
		12,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"6_1",
		{
			{
				audioId = "180310116",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "x6_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "x6_1_loop",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "12",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		12,
		2,
		3,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,12",
		"6_23",
		{
			{
				animName = "x6_2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "x6_2_loop",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		12,
		3,
		4,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,12",
		"6_23",
		{
			{
				animName = "x6_3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "x6_3_loop",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		12,
		4,
		1,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,12",
		"6_4",
		{
			{
				animName = "x6_4",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				animName = "idle",
				isLoop = "true",
				trackIndex = "0",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101,
		13,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"7",
		{
			{
				animName = "7",
				isForbid = "true",
				isFadeOut = "false",
				motionType = "spineanim",
				isBlock = "true",
				isKeep = "true",
				trackIndex = "1"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1803101000",
				motionType = "event"
			},
			{
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803101,
		14,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1803101000,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				audioId = "180310117",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "8",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "1",
				isKeep = "true"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		2,
		3,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				audioId = "180310119",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "9-1",
				isKeep = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		3,
		4,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				audioId = "180310118",
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "9-2",
				isKeep = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		4,
		5,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				trackIndex = "1",
				motionType = "audio"
			},
			{
				animName = "9-3",
				isKeep = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		5,
		6,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "9-4",
				isKeep = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		6,
		7,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "10",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1803101000,
		1,
		7,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1043,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1043,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1043,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1202105,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"4_1",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				animName = "6",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1202105000",
				motionType = "event"
			}
		}
	},
	{
		1202105,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1202105000,
		1,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "7",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105000,
		2,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"8",
		{
			{
				animName = "8_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1202105000,
		2,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,2",
		"8",
		{
			{
				animName = "8_2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "1"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1202105000,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"9",
		{
			{
				animName = "9",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105000,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"10",
		{
			{
				animName = "10",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1202105000,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"11",
		{
			{
				animName = "11_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				animName = "11_2",
				isLoop = "true",
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"11_1",
		{
			{
				animName = "11_3_1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"11_2",
		{
			{
				animName = "11_3_2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"11_3",
		{
			{
				animName = "11_3_3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		9,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"11_4",
		{
			{
				animName = "11_3_4",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"11_5",
		{
			{
				animName = "11_3_5",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "3"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1202105000,
		11,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"12",
		{
			{
				animName = "12",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "3",
				isKeep = "true"
			},
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1103704,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1103704,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"2",
		{
			{
				animName = "2",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "2",
				isKeep = "true"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"DRAW",
		{
			{
				animName = "2-1",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"WIN",
		{
			{
				animName = "2-2",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"LOSE",
		{
			{
				animName = "2-3",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,1",
		"CHEAT",
		{
			{
				animName = "2-4",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0&publicparam$2,等于,0",
		"3",
		{
			{
				animName = "3-1",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "3",
				isKeep = "true"
			},
			{
				publicParamId = "2",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0&publicparam$2,等于,1",
		"3",
		{
			{
				animName = "3-2",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "3",
				isKeep = "true"
			},
			{
				publicParamId = "2",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		9,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0&publicparam$2,不等于,1",
		"3",
		{
			{
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0&publicparam$2,不等于,3",
		"4",
		{
			{
				animName = "4",
				isForbid = "true",
				isBlock = "true",
				motionType = "spineanim",
				trackIndex = "3",
				isKeep = "true"
			},
			{
				publicParamId = "2",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		11,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0&publicparam$2,等于,3",
		"4",
		{
			{
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1103704,
		12,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"5",
		{
			{
				animName = "5",
				isBlock = "true",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "4"
			},
			{
				animName = "5-2",
				isKeep = "true",
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "2",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1103704,
		12,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,2",
		"5",
		{
			{
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1103704,
		13,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1702701,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1702701,
		2,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				goName = "fx_bojiaqiu_idle",
				slotName = "H_AE",
				alwaysVisible = "true",
				motionType = "bonefollow"
			},
			{
				goName = "fx_bojiaqiu_sword_normal",
				slotName = "sword",
				motionType = "bonefollow"
			}
		}
	},
	{
		1702701,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"2_1",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				animName = "2_rm",
				isLoop = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				goName = "fx_bojiaqiu_idle_red",
				slotName = "H_AE",
				alwaysVisible = "true",
				motionType = "bonefollow"
			},
			{
				goName = "fx_bojiaqiu_sword_obsessed",
				slotName = "sword",
				motionType = "bonefollow"
			},
			{
				publicParamId = "1",
				fixValue = "10",
				motionType = "publicparam"
			}
		}
	},
	{
		1702701,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"2_2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				goName = "fx_bojiaqiu_idle",
				slotName = "H_AE",
				alwaysVisible = "true",
				motionType = "bonefollow"
			},
			{
				goName = "fx_bojiaqiu_sword_normal",
				slotName = "sword",
				motionType = "bonefollow"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1702701,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"3",
		{
			{
				animName = "3_1",
				isForbid = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "2",
				showObjs = {
					"fx_bojiaqiu_3-1"
				},
				showObjsTicks = {
					0
				}
			}
		}
	},
	{
		1702701,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"3",
		{
			{
				animName = "3_2",
				isForbid = "true",
				motionType = "spineanim",
				trackIndex = "2",
				showObjs = {
					"fx_bojiaqiu_3-2"
				},
				showObjsTicks = {
					0
				}
			}
		}
	},
	{
		1702701,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,0",
		"4",
		{
			{
				animName = "4_1",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1702701,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"publicparam$1,等于,10",
		"4",
		{
			{
				animName = "4_2",
				isForbid = "true",
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1702701,
		9,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				isFadeOut = "false",
				motionType = "spineanim",
				isBlock = "true",
				isKeep = "true",
				trackIndex = "2"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1702701000",
				motionType = "event"
			},
			{
				trackIndex = "2",
				motionType = "spineanim"
			}
		}
	},
	{
		1702701,
		10,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1702701000,
		1,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1702701000,
		2,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "5_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1702701000,
		2,
		2,
		3,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "5_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim",
				isKeep = "true"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1702701000,
		2,
		3,
		4,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				animName = "5_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1702701000,
		2,
		4,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1047,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1047,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1047,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1802104,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104,
		3,
		1,
		2,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4-1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1802104,
		3,
		2,
		1,
		"",
		"PointerClick",
		nil,
		"",
		"4",
		{
			{
				animName = "4-2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1802104,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				isFadeOut = "false",
				motionType = "spineanim",
				isBlock = "true",
				isKeep = "true",
				trackIndex = "1"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1802104000",
				motionType = "event"
			},
			{
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_1",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "feiniyaclothespopwinview#clothes",
				motionType = "event"
			}
		}
	},
	{
		1802104,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_2",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "feiniyaclothespopwinview#shoes",
				motionType = "event"
			}
		}
	},
	{
		1802104,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_3",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "feiniyaclothespopwinview#hair",
				motionType = "event"
			}
		}
	},
	{
		1802104,
		8,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_4",
		{
			{
				eventName = "spineinterfacebagextension",
				eventParam = "feiniyaclothespopwinview#headwear",
				motionType = "event"
			}
		}
	},
	{
		1802104,
		9,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		10,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-1_1",
				isKeep = "true",
				trackIndex = "2",
				motionType = "spineanim"
			},
			{
				publicParamId = "1",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		11,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		12,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-2_1",
				isKeep = "true",
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		13,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-2_2",
				isKeep = "true",
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		14,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-2_3",
				isKeep = "true",
				trackIndex = "3",
				motionType = "spineanim"
			},
			{
				publicParamId = "2",
				fixValue = "3",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		15,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "3",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		16,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-3_1",
				isKeep = "true",
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "3",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		17,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-3_2",
				isKeep = "true",
				trackIndex = "4",
				motionType = "spineanim"
			},
			{
				publicParamId = "3",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		18,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "5",
				motionType = "spineanim"
			},
			{
				publicParamId = "4",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		19,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-4_1",
				isKeep = "true",
				trackIndex = "5",
				motionType = "spineanim"
			},
			{
				publicParamId = "4",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		20,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-4_2",
				isKeep = "true",
				trackIndex = "5",
				motionType = "spineanim"
			},
			{
				publicParamId = "4",
				fixValue = "2",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		21,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				animName = "2-4_3",
				isKeep = "true",
				trackIndex = "6",
				motionType = "spineanim"
			},
			{
				publicParamId = "5",
				fixValue = "1",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		22,
		1,
		0,
		"",
		"",
		nil,
		"",
		"",
		{
			{
				trackIndex = "6",
				motionType = "spineanim"
			},
			{
				publicParamId = "5",
				fixValue = "0",
				motionType = "publicparam"
			}
		}
	},
	{
		1802104,
		23,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1802104000,
		1,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5",
		{
			{
				animName = "5",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104000,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5_1",
		{
			{
				animName = "5-1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104000,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5_2",
		{
			{
				animName = "5-2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1802104000,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	},
	{
		1059,
		1,
		1,
		2,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "idle_special",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				animName = "idle",
				isBlock = "true",
				isFadeIn = "true",
				motionType = "spineanim",
				trackIndex = "0"
			},
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1059,
		1,
		2,
		1,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				motionType = "behaviorchange"
			}
		}
	},
	{
		1059,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1803102,
		1,
		1,
		0,
		"",
		"LimitEnterState",
		nil,
		"",
		"",
		{
			{
				animName = "1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_1",
		{
			{
				animName = "2_1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_2",
		{
			{
				animName = "2_2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_3",
		{
			{
				animName = "2_3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"2_4",
		{
			{
				animName = "2_4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"3",
		{
			{
				animName = "3",
				isForbid = "true",
				isFadeOut = "false",
				motionType = "spineanim",
				isBlock = "true",
				isKeep = "true",
				trackIndex = "1"
			},
			{
				eventName = "spineinterfacebagextension",
				eventParam = "commonpopspinescreen#1803102000",
				motionType = "event"
			},
			{
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102,
		7,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"",
		{
			{
				eventName = "handbookplaypetanim",
				motionType = "event"
			},
			{
				eventName = "petshowviewplaypetanim",
				motionType = "event"
			}
		}
	},
	{
		1803102000,
		1,
		1,
		0,
		"",
		"EnterState",
		nil,
		"",
		"",
		{
			{
				animName = "4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102000,
		2,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5-1",
		{
			{
				animName = "5-1",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102000,
		3,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5-2",
		{
			{
				animName = "5-2",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102000,
		4,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5-3",
		{
			{
				animName = "5-3",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102000,
		5,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"5-4",
		{
			{
				animName = "5-4",
				isForbid = "true",
				trackIndex = "1",
				motionType = "spineanim"
			}
		}
	},
	{
		1803102000,
		6,
		1,
		0,
		"",
		"PointerClick",
		nil,
		"",
		"6",
		{
			{
				eventName = "commonpopspinescreenclose",
				motionType = "event"
			}
		}
	}
}
local t_md_spine_behavior = {
	[1101103] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3]
		},
		{
			dataList[4]
		},
		{
			dataList[5]
		},
		{
			dataList[6],
			dataList[7]
		},
		{
			dataList[8]
		},
		{
			dataList[9]
		}
	},
	[1100203] = {
		{
			dataList[10],
			dataList[11]
		},
		{
			dataList[12]
		},
		{
			dataList[13]
		},
		{
			dataList[14]
		},
		{
			dataList[15],
			dataList[16]
		},
		{
			dataList[17]
		},
		{
			dataList[18]
		}
	},
	[1401602] = {
		{
			dataList[19]
		},
		{
			dataList[20]
		},
		{
			dataList[21]
		},
		{
			dataList[22]
		},
		{
			dataList[23]
		},
		{
			dataList[24]
		},
		{
			dataList[25]
		}
	},
	[1031302] = {
		{
			dataList[26]
		},
		{
			dataList[27]
		},
		{
			dataList[28]
		},
		{
			dataList[29]
		},
		{
			dataList[30]
		},
		{
			dataList[31]
		},
		{
			dataList[32]
		}
	},
	[1800101] = {
		{
			dataList[33]
		},
		{
			dataList[34]
		},
		{
			dataList[35]
		},
		{
			dataList[36]
		},
		{
			dataList[37]
		},
		{
			dataList[38]
		},
		{
			dataList[39]
		}
	},
	[1402301] = {
		{
			dataList[40]
		},
		{
			dataList[41]
		},
		{
			dataList[42]
		},
		{
			dataList[43]
		},
		{
			dataList[44]
		},
		{
			dataList[45]
		}
	},
	[1202001] = {
		{
			dataList[46]
		},
		{
			dataList[47]
		},
		{
			dataList[48]
		},
		{
			dataList[49]
		},
		{
			dataList[50]
		},
		{
			dataList[51]
		},
		{
			dataList[52]
		}
	},
	[1602401] = {
		{
			dataList[53]
		},
		{
			dataList[54]
		},
		{
			dataList[55]
		},
		{
			dataList[56]
		},
		{
			dataList[57]
		},
		{
			dataList[58]
		},
		{
			dataList[59]
		}
	},
	[1800102] = {
		{
			dataList[60]
		},
		{
			dataList[61],
			dataList[62]
		},
		{
			dataList[63],
			dataList[64]
		},
		{
			dataList[65]
		},
		{
			dataList[66]
		},
		{
			dataList[67]
		}
	},
	[1602606] = {
		{
			dataList[68]
		},
		{
			dataList[69],
			dataList[70],
			dataList[71]
		},
		{
			dataList[72]
		},
		{
			dataList[73]
		},
		{
			dataList[74]
		},
		{
			dataList[75]
		},
		{
			dataList[76]
		},
		{
			dataList[77]
		}
	},
	[1602607] = {
		{
			dataList[78]
		},
		{
			dataList[79],
			dataList[80],
			dataList[81]
		},
		{
			dataList[82]
		},
		{
			dataList[83]
		},
		{
			dataList[84]
		},
		{
			dataList[85]
		},
		{
			dataList[86]
		},
		{
			dataList[87]
		}
	},
	[1600106] = {
		{
			dataList[88]
		},
		{
			dataList[89],
			dataList[90],
			dataList[91]
		},
		{
			dataList[92]
		},
		{
			dataList[93]
		},
		{
			dataList[94]
		},
		{
			dataList[95]
		},
		{
			dataList[96]
		},
		{
			dataList[97]
		}
	},
	[1600107] = {
		{
			dataList[98]
		},
		{
			dataList[99],
			dataList[100],
			dataList[101]
		},
		{
			dataList[102]
		},
		{
			dataList[103]
		},
		{
			dataList[104]
		},
		{
			dataList[105]
		},
		{
			dataList[106]
		},
		{
			dataList[107]
		}
	},
	[1802101] = {
		{
			dataList[108]
		},
		{
			dataList[109]
		},
		{
			dataList[110]
		},
		{
			dataList[111]
		},
		{
			dataList[112]
		},
		{
			dataList[113]
		},
		{
			dataList[114]
		}
	},
	[1503201] = {
		{
			dataList[115]
		},
		{
			dataList[116]
		},
		{
			dataList[117]
		},
		{
			dataList[118],
			dataList[119],
			dataList[120],
			dataList[121]
		},
		{
			dataList[122]
		},
		{
			dataList[123]
		},
		{
			dataList[124]
		}
	},
	[1603404] = {
		{
			dataList[125]
		},
		{
			dataList[126]
		},
		{
			dataList[127]
		},
		{
			dataList[128]
		},
		{
			dataList[129]
		},
		{
			dataList[130],
			dataList[131]
		},
		{
			dataList[132]
		}
	},
	[1603405] = {
		{
			dataList[133]
		},
		{
			dataList[134]
		},
		{
			dataList[135]
		},
		{
			dataList[136]
		},
		{
			dataList[137]
		},
		{
			dataList[138],
			dataList[139]
		},
		{
			dataList[140]
		}
	},
	[1601604] = {
		{
			dataList[141]
		},
		{
			dataList[142]
		},
		{
			dataList[143]
		},
		{
			dataList[144]
		},
		{
			dataList[145]
		},
		{
			dataList[146],
			dataList[147]
		},
		{
			dataList[148]
		}
	},
	[1601605] = {
		{
			dataList[149]
		},
		{
			dataList[150]
		},
		{
			dataList[151]
		},
		{
			dataList[152]
		},
		{
			dataList[153]
		},
		{
			dataList[154],
			dataList[155]
		},
		{
			dataList[156]
		}
	},
	[1603202] = {
		{
			dataList[157]
		},
		{
			dataList[158]
		},
		{
			dataList[159],
			dataList[160],
			dataList[161],
			dataList[162]
		},
		{
			dataList[163]
		},
		{
			dataList[164]
		},
		{
			dataList[165]
		},
		{
			dataList[166]
		}
	},
	[1600502] = {
		{
			dataList[167]
		},
		{
			dataList[168]
		},
		{
			dataList[169],
			dataList[170],
			dataList[171],
			dataList[172]
		},
		{
			dataList[173]
		},
		{
			dataList[174]
		},
		{
			dataList[175]
		},
		{
			dataList[176]
		}
	},
	[1802103] = {
		{
			dataList[177]
		},
		{
			dataList[178]
		},
		{
			dataList[179]
		},
		{
			dataList[180],
			dataList[181]
		},
		{
			dataList[182],
			dataList[183]
		},
		{
			dataList[184]
		},
		{
			dataList[185]
		},
		{
			dataList[186]
		},
		{
			dataList[187]
		},
		{
			dataList[188]
		}
	},
	[1601003] = {
		{
			dataList[189]
		},
		{
			dataList[190],
			dataList[191]
		},
		{
			dataList[192],
			dataList[193]
		},
		{
			dataList[194],
			dataList[195]
		},
		{
			dataList[196]
		},
		{
			dataList[197]
		}
	},
	[1604003] = {
		{
			dataList[198]
		},
		{
			dataList[199],
			dataList[200]
		},
		{
			dataList[201],
			dataList[202]
		},
		{
			dataList[203],
			dataList[204]
		},
		{
			dataList[205]
		},
		{
			dataList[206]
		}
	},
	[1604003000] = {
		{
			dataList[207]
		},
		{
			dataList[208]
		},
		{
			dataList[209]
		},
		{
			dataList[210]
		},
		{
			dataList[211]
		},
		{
			dataList[212],
			dataList[213]
		},
		{
			dataList[214]
		}
	},
	[1403803] = {
		{
			dataList[215]
		},
		{
			dataList[216],
			dataList[217]
		},
		{
			dataList[218]
		},
		{
			dataList[219],
			dataList[220]
		},
		{
			dataList[221]
		},
		{
			dataList[222]
		},
		{
			dataList[223]
		},
		{
			dataList[224]
		},
		{
			dataList[225]
		},
		{
			dataList[226]
		}
	},
	[1403803000] = {
		{
			dataList[227]
		},
		{
			dataList[228]
		},
		{
			dataList[229]
		},
		{
			dataList[230],
			dataList[231]
		},
		{
			dataList[232]
		}
	},
	[1038] = {
		{
			dataList[233],
			dataList[234]
		},
		{
			dataList[235]
		}
	},
	[1040] = {
		{
			dataList[236],
			dataList[237]
		},
		{
			dataList[238]
		}
	},
	[1041] = {
		{
			dataList[239]
		},
		{
			dataList[240]
		}
	},
	[1042] = {
		{
			dataList[241],
			dataList[242]
		},
		{
			dataList[243]
		}
	},
	[1046] = {
		{
			dataList[244],
			dataList[245]
		},
		{
			dataList[246]
		}
	},
	[1803101] = {
		{
			dataList[247]
		},
		{
			dataList[248]
		},
		{
			dataList[249]
		},
		{
			dataList[250]
		},
		{
			dataList[251],
			dataList[252],
			dataList[253]
		},
		{
			dataList[254]
		},
		{
			dataList[255]
		},
		{
			dataList[256]
		},
		{
			dataList[257]
		},
		{
			dataList[258]
		},
		{
			dataList[259]
		},
		{
			dataList[260],
			dataList[261],
			dataList[262],
			dataList[263]
		},
		{
			dataList[264]
		},
		{
			dataList[265]
		}
	},
	[1803101000] = {
		{
			dataList[266],
			dataList[267],
			dataList[268],
			dataList[269],
			dataList[270],
			dataList[271],
			dataList[272]
		}
	},
	[1043] = {
		{
			dataList[273],
			dataList[274]
		},
		{
			dataList[275]
		}
	},
	[1202105] = {
		{
			dataList[276]
		},
		{
			dataList[277]
		},
		{
			dataList[278]
		},
		{
			dataList[279]
		},
		{
			dataList[280]
		},
		{
			dataList[281]
		},
		{
			dataList[282]
		},
		{
			dataList[283]
		}
	},
	[1202105000] = {
		{
			dataList[284]
		},
		{
			dataList[285],
			dataList[286]
		},
		{
			dataList[287]
		},
		{
			dataList[288]
		},
		{
			dataList[289]
		},
		{
			dataList[290]
		},
		{
			dataList[291]
		},
		{
			dataList[292]
		},
		{
			dataList[293]
		},
		{
			dataList[294]
		},
		{
			dataList[295]
		}
	},
	[1103704] = {
		{
			dataList[296]
		},
		{
			dataList[297]
		},
		{
			dataList[298]
		},
		{
			dataList[299]
		},
		{
			dataList[300]
		},
		{
			dataList[301]
		},
		{
			dataList[302]
		},
		{
			dataList[303]
		},
		{
			dataList[304]
		},
		{
			dataList[305]
		},
		{
			dataList[306]
		},
		{
			dataList[307],
			dataList[308]
		},
		{
			dataList[309]
		}
	},
	[1702701] = {
		{
			dataList[310]
		},
		{
			dataList[311]
		},
		{
			dataList[312]
		},
		{
			dataList[313]
		},
		{
			dataList[314]
		},
		{
			dataList[315]
		},
		{
			dataList[316]
		},
		{
			dataList[317]
		},
		{
			dataList[318]
		},
		{
			dataList[319]
		}
	},
	[1702701000] = {
		{
			dataList[320]
		},
		{
			dataList[321],
			dataList[322],
			dataList[323],
			dataList[324]
		}
	},
	[1047] = {
		{
			dataList[325],
			dataList[326]
		},
		{
			dataList[327]
		}
	},
	[1802104] = {
		{
			dataList[328]
		},
		{
			dataList[329]
		},
		{
			dataList[330],
			dataList[331]
		},
		{
			dataList[332]
		},
		{
			dataList[333]
		},
		{
			dataList[334]
		},
		{
			dataList[335]
		},
		{
			dataList[336]
		},
		{
			dataList[337]
		},
		{
			dataList[338]
		},
		{
			dataList[339]
		},
		{
			dataList[340]
		},
		{
			dataList[341]
		},
		{
			dataList[342]
		},
		{
			dataList[343]
		},
		{
			dataList[344]
		},
		{
			dataList[345]
		},
		{
			dataList[346]
		},
		{
			dataList[347]
		},
		{
			dataList[348]
		},
		{
			dataList[349]
		},
		{
			dataList[350]
		},
		{
			dataList[351]
		}
	},
	[1802104000] = {
		{
			dataList[352]
		},
		{
			dataList[353]
		},
		{
			dataList[354]
		},
		{
			dataList[355]
		}
	},
	[1059] = {
		{
			dataList[356],
			dataList[357]
		},
		{
			dataList[358]
		}
	},
	[1803102] = {
		{
			dataList[359]
		},
		{
			dataList[360]
		},
		{
			dataList[361]
		},
		{
			dataList[362]
		},
		{
			dataList[363]
		},
		{
			dataList[364]
		},
		{
			dataList[365]
		}
	},
	[1803102000] = {
		{
			dataList[366]
		},
		{
			dataList[367]
		},
		{
			dataList[368]
		},
		{
			dataList[369]
		},
		{
			dataList[370]
		},
		{
			dataList[371]
		}
	}
}

t_md_spine_behavior.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_md_spine_behavior
